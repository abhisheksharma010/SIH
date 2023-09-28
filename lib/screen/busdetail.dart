import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

// import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';

class BusDetailsPage extends StatefulWidget {
  final Map<String, dynamic> bus;
  final String destination;
  final String search;

  BusDetailsPage({
    required this.bus,
    required this.search,
    required this.destination,
  });

  @override
  _BusDetailsPageState createState() => _BusDetailsPageState();
}

class _BusDetailsPageState extends State<BusDetailsPage> {
  String? destinationImage;
   String? weatherData;

  // @override
  // void initState() {
  //   super.initState();
  //   _fetchDestinationImage(); // Fetch a single destination image
  //   _fetchWeatherData(widget.search, widget.destination); // Fetch weather data
  // }
  bool _hasCallSupport = false;
  Future<void>? _launched;
  String _phone = '';

  @override
  void initState() {
    super.initState();

    _fetchDestinationImage(); // Fetch a single destination image
    _fetchWeatherData(widget.search, widget.destination);
    // Check for phone call support.
    canLaunchUrl(Uri(scheme: 'tel', path: '123')).then((bool result) {
      setState(() {
        _hasCallSupport = result;
      });
    });
  }

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  Future<void> _launchInWebViewOrVC(Uri url) async {
    if (!await launchUrl(url, mode: LaunchMode.inAppWebView)) {
      throw Exception('Could not launch $url');
    }
  }

  Future<void> _fetchDestinationImage() async {
    final unsplashApiKey = '4OT1Sb8VK_-MqDfxwIrM_On0BtVrfaq0LRbl7rrVW-s';
    final apiUrl =
        'https://api.unsplash.com/search/photos?page=1&query=${widget.destination}&client_id=$unsplashApiKey';

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['results'].isNotEmpty) {
        setState(() {
          destinationImage = data['results'][0]['urls']['regular'];
        });
      }
    } else {
      throw Exception('Failed to fetch destination image');
    }
  }

  Future<void> _fetchWeatherData(String search, String destination) async {
    final apiKey = '7bdd4a3c2bc3410bdf134917523d33ba';
    final searchApiUrl =
        'https://api.openweathermap.org/data/2.5/weather?q=$search&appid=$apiKey';
    final destinationApiUrl =
        'https://api.openweathermap.org/data/2.5/weather?q=$destination&appid=$apiKey';

    final searchResponse = await http.get(Uri.parse(searchApiUrl));
    final destinationResponse = await http.get(Uri.parse(destinationApiUrl));

    if (searchResponse.statusCode == 200 &&
        destinationResponse.statusCode == 200) {
      final searchWeatherDataMap = json.decode(searchResponse.body);
      final destinationWeatherDataMap = json.decode(destinationResponse.body);
      final searchWeatherDescription =
      searchWeatherDataMap['weather'][0]['description'];
      final destinationWeatherDescription =
      destinationWeatherDataMap['weather'][0]['description'];

      setState(() {
        weatherData =
        'Weather in ${widget.search}: $searchWeatherDescription\n'
            'Weather in ${widget.destination}: $destinationWeatherDescription';
      });
    } else {
      throw Exception('Failed to fetch weather data');
    }
  }

  // Function to open a website
  void _openWebsite() async {
    final String websiteUrl = 'https://www.youtube.com/'; // Replace with the actual website URL

    if (await canLaunch(websiteUrl)) {
      await launch(websiteUrl);
    } else {
      throw 'Could not launch $websiteUrl';
    }
  }

  // Function to display bus details and weather details
  Widget _buildBusDetailsAndWeather() {
    final Uri toLaunch =
    Uri(scheme: 'https', host: 'www.youtube.com', path: 'headers/');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Display destination image and bus icon
        if (destinationImage != null)
          Column(
            children: [
              Image.network(
                destinationImage!,
                fit: BoxFit.cover,
                height: 200.0, // Fixed height for the image
                width: double.infinity, // Make the image take the complete width
              ),
              SizedBox(
                height: 20,
              ),
              Icon(
                Icons.directions_bus,
                size: 48.0,
                color: Colors.red,
              ),
            ],
          ),
        // Call the function to display bus details
        if (destinationImage != null) // Check if destinationImage is not null
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: _buildBusDetails(),
          ),
        // Display weather data
        if (weatherData != null)
          Padding(
            padding: EdgeInsets.all(16.0),
            child: _buildWeatherDetails(),
          ),
        // Button to open the website
        ElevatedButton(
          onPressed: () => setState(() {
            _launched = _launchInWebViewOrVC(toLaunch);
          }),
          child: Text('Visit Website'),
        ),
      ],
    );
  }

  // Function to display bus details
  Widget _buildBusDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildProfileField('Bus Name', widget.bus['DriverName'].toString()),
        buildProfileField(
            'Conductor Mobile', widget.bus['ConductorMobile'].toString()),
        buildProfileField('Bus Number', widget.bus['BusNo'].toString()),
        buildProfileField(
            'Seats Available', widget.bus['SeatsAvailable'].toString()),
        buildProfileField('Fuel Type', widget.bus['fuelType'].toString()),
        // Add more bus details here using the database schema
      ],
    );
  }

  // Function to display weather details
  Widget _buildWeatherDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildProfileField('Weather Details', weatherData!),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bus Details'),
      ),
      body: SingleChildScrollView(
        child: _buildBusDetailsAndWeather(),
      ),
    );
  }
}

Widget buildProfileField(String label, String value) {
  return Container(
    padding: EdgeInsets.all(16.0),
    margin: EdgeInsets.symmetric(vertical: 8.0),
    decoration: BoxDecoration(
      // color: Colors.grey[200],
      // borderRadius: BorderRadius.circular(8.0),
    ),
    child: Row(
      children: [
        Container(
          width: 150.0,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
        ),
        SizedBox(width: 20.0),
        Expanded(
          // Wrap the value in an Expanded widget
          child: Text(
            value,
            style: TextStyle(
              fontSize: 18.0,
            ),
          ),
        ),
      ],
    ),
  );
}
