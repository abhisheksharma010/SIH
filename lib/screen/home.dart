import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:convert';
import 'dart:async';
import 'tabs.dart';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_maps/maps.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BingMapsWidget(),
    );
  }
}

class BingMapsWidget extends StatefulWidget {
  @override
  _BingMapsWidgetState createState() => _BingMapsWidgetState();
}

class _BingMapsWidgetState extends State<BingMapsWidget> {
  Position? _position;
  MapZoomPanBehavior? _zoomPanBehavior;
  WeatherData? _weatherData;
  late IO.Socket socket;
  late Timer locationUpdateTimer;


  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    socket = IO.io('https://temps-x4t0.onrender.com/', <String, dynamic>{
      'transports': ['websocket'],
    });
    socket.onConnect((_) {
      print('Connected to Socket.IO server');
    });

    // _getCurrentLocation();
    socket.on('busLocationUpdate', (data) {
      print('Received bus location update: $data');
      // Handle the received data as needed
    });
    socket.connect();

    // Start a timer that periodically sends location updates every 5 seconds
    locationUpdateTimer = Timer.periodic(Duration(seconds: 30), (Timer timer) {
      _sendLocationUpdate();
    });

    _zoomPanBehavior = MapZoomPanBehavior();

    _fetchWeatherData();
  }

  void _getCurrentLocation() async {
    Position position = await _determinePosition();
    setState(() {
      _position = position;
    });
    _fetchWeatherData();
  }

  Future<Position> _determinePosition() async {
    LocationPermission permission;

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location Permissions are denied');
      }
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<void> _fetchWeatherData() async {
    if (_position != null) {
      final apiKey = '9143c57eecaf85c074934a7c0b87dc55'; // Replace with your OpenWeatherMap API key
      final apiUrl =
          'https://api.openweathermap.org/data/2.5/weather?lat=${_position!.latitude}&lon=${_position!.longitude}&appid=$apiKey';

      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        print("successful");
      } else {
        throw Exception('Failed to load weather data');
      }
    }
  }


  void _sendLocationUpdate() async {
    try {
      Position position = await _determinePosition();
      print(position);
      socket.emit('busLocationUpdate', {
        'busNo' : 'UP80DSXXX2',
        'latitude': position.latitude,
        'longitude': position.longitude,
        'speed': position.speed,
        'timestamp': position.timestamp.toString(),
        // Include other relevant data
      });
    } catch (error) {
      print('Error getting location: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (_weatherData != null)
                Column(
                  children: [
                    Text(
                      'Weather Conditions:',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    _getWeatherIcon(_weatherData!.weather), // Display weather icon
                    Text(
                      'Weather: ${_weatherData!.weather}',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    Text(
                      'Description: ${_weatherData!.weatherDescription}',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    Text(
                      'Gust: ${_weatherData!.gust} m/s',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    Text(
                      'Humidity: ${_weatherData!.humidity}%',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ],
                )
              else
                Center(child: CircularProgressIndicator()),
            ],
          ),
        ),
        Text(
          _weatherData != null && !_weatherData!.weather.contains("Rain")
              ? 'Good day to travel!'
              : 'Weather is not good to travel',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: _weatherData != null && !_weatherData!.weather.contains("Rain")
                ? Colors.green // Good to travel
                : Colors.red, // Not good to travel (rainy)
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.red,
                        width: 2.0,
                      ),
                    ),
                    child: FutureBuilder<String?>(
                      future: getBingUrlTemplate(
                        'http://dev.virtualearth.net/REST/V1/Imagery/Metadata/Road?output=json&include=ImageryProviders&key=AsQBBgOPkXW1lC257SLEiIqRUu_a14Ti7y67EeaX9IS-FIvyWB4vXrmri4HFf_fu',
                      ),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return SfMaps(
                            layers: [
                              MapTileLayer(
                                initialFocalLatLng: MapLatLng(_position!.latitude, _position!.longitude),
                                zoomPanBehavior: _zoomPanBehavior,
                                initialZoomLevel: 15,
                                urlTemplate: snapshot.data!,
                              ),
                            ],
                          );
                        }
                        return Center(child: CircularProgressIndicator());
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _getWeatherIcon(String weather) {
    switch (weather.toLowerCase()) {
      case 'clouds':
        return Icon(Icons.cloud);
      case 'rain':
        return Icon(Icons.grain);
      case 'clear':
        return Icon(Icons.wb_sunny);
      default:
        return Icon(Icons.wb_cloudy);
    }
  }

  Future<String?> getBingUrlTemplate(String url) async {
    final http.Response response = await _fetchResponse(url);
    assert(response.statusCode == 200, 'Invalid key');
    if (response.statusCode == 200) {
      final Map<String, dynamic> decodedJson =
      // ignore: avoid_as
      json.decode(response.body) as Map<String, dynamic>;
      late String imageUrl;
      late String imageUrlSubDomains;
      if (decodedJson['authenticationResultCode'] == 'ValidCredentials') {
        for (final String key in decodedJson.keys) {
          if (key == 'resourceSets') {
            // ignore: avoid_as
            final List<dynamic> resourceSets = decodedJson[key] as List<dynamic>;
            for (final dynamic key in resourceSets[0].keys) {
              if (key == 'resources') {
                final List<dynamic> resources =
                // ignore: avoid_as
                resourceSets[0][key] as List<dynamic>;
                final Map<String, dynamic> resourcesMap =
                // ignore: avoid_as
                resources[0] as Map<String, dynamic>;
                imageUrl = resourcesMap['imageUrl'].toString();
                final List<dynamic> subDomains =
                // ignore: avoid_as
                resourcesMap['imageUrlSubdomains'] as List<dynamic>;
                imageUrlSubDomains = subDomains[0].toString();
                break;
              }
            }
            break;
          }
        }

        final List<String> splitUrl = imageUrl.split('{subdomain}');
        return splitUrl[0] + imageUrlSubDomains + splitUrl[1];
      }
    }
    return null;
  }

  Future<http.Response> _fetchResponse(String url) async {
    final response = await http.get(Uri.parse(url));
    return response;
  }
}

class WeatherData {
  final double temperature;
  final String weather;
  final String weatherDescription;
  final double gust;
  final int humidity;

  WeatherData({
    required this.temperature,
    required this.weather,
    required this.weatherDescription,
    required this.gust,
    required this.humidity,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    final mainData = json['main'];
    final weatherData = json['weather'][0];
    final temperature = mainData['temp'] as double;
    final weather = weatherData['main'] as String;
    final weatherDescription = weatherData['description'] as String;
    final gust = json['wind']['gust'] as double;
    final humidity = mainData['humidity'] as int;

    return WeatherData(
      temperature: temperature,
      weather: weather,
      weatherDescription: weatherDescription,
      gust: gust,
      humidity: humidity,
    );
  }
}
