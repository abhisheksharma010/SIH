import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'busdetail.dart';

class BusResultScreen extends StatefulWidget {
  final String search;
  final String destination;

  BusResultScreen({required this.search, required this.destination});

  @override
  _BusResultScreenState createState() => _BusResultScreenState();
}

class _BusResultScreenState extends State<BusResultScreen> {
  List<dynamic> busData = []; // Store fetched bus data here

  @override
  void initState() {
    super.initState();
    fetchData();
    print("yo yo");
  }

  Future<void> fetchData() async {
    print("it is called");
    final url = Uri.parse(
        'https://temps-x4t0.onrender.com/api/bus?search=${widget.search}&destination=${widget.destination}');
    // https://temps-x4t0.onrender.com/map/show/650aa782644c9c5cfa3a683d
    try {
      final response = await http.get(url);
      print(url);

      if (response.statusCode == 200) {
        setState(() {
          busData = json.decode(response.body)['results']; // Extract 'results' array
          // Print the response data to the console for debugging
          print('Response Data: $busData');
        });
      } else {
        // Handle HTTP error status codes here, e.g., show an error message
        print('Failed to fetch bus data. Status code: ${response.statusCode}');
        // You can display an error message to the user or take other actions as needed.
      }
    } catch (e) {
      // Handle any other exceptions that may occur, e.g., network errors
      print('An error occurred: $e');
      // You can display an error message to the user or take other actions as needed.
    }
  }

  @override
  Widget build(BuildContext context) {
    void _openBusDetailsPage(Map<String, dynamic> bus) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BusDetailsPage(bus: bus, search: widget.search, destination: widget.destination),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.search} to ${widget.destination}'),
      ),
      body: ListView.builder(
        itemCount: busData.length,
        itemBuilder: (context, index) {
          final bus = busData[index];
          return GestureDetector(
            onTap: () {
              _openBusDetailsPage(bus);
            },
            child: Container(
              padding: EdgeInsets.all(16.0),
              margin: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Icon(
                        Icons.directions_bus,
                        size: 48.0,
                        color: Colors.red,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Active',
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row (
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                'Bus Number: ${bus["BusNo"]}',
                                style: TextStyle(fontSize: 14.0),
                              ),
                            ),
                            Text(
                              ' Seats : ${bus["SeatsAvailable"]}',
                              style: TextStyle(fontSize: 14.0),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Type :CNG',
                              style: TextStyle(fontSize: 14.0),
                            ),
                            Text(
                              'Price :200',
                              style: TextStyle(fontSize: 14.0),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                'Bus ID: 12ad-34',
                                style: TextStyle(fontSize: 14.0),
                              ),
                            ),
                            Text(
                              'Date: 12-23-2023',
                              style: TextStyle(fontSize: 14.0),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
