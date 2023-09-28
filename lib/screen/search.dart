import 'package:flutter/material.dart';
import 'package:sihproject/language_constants.dart';
import 'package:sihproject/screen/searchbus.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController startPointController = TextEditingController();
    TextEditingController destinationController = TextEditingController();

    return Scaffold(

      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: startPointController,
              decoration: InputDecoration(
                labelText: translation(context).startPoint,
                labelStyle: TextStyle(color: Colors.red),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                ),
                prefixIcon: Icon(Icons.location_on, color: Colors.red),
              ),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: destinationController,
              decoration: InputDecoration(
                labelText: translation(context).destination,
                labelStyle: TextStyle(color: Colors.red),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                ),
                prefixIcon: Icon(Icons.location_on, color: Colors.red),
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                String searchValue = startPointController.text;
                String destinationValue = destinationController.text;
                print("it is tapped with ");
                // Navigate to BusResultScreen with user-input values
                Navigator.of(context).push(

                  MaterialPageRoute(
                    builder: (context) => BusResultScreen(
                      search: searchValue,
                      destination: destinationValue,
                    ),
                  ),
                );
              },
              child: Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  translation(context).search,
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
                onPrimary: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
