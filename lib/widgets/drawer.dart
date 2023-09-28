import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:sihuser/language_constants.dart';
import 'package:sihuser/screen/login.dart';
class MainDrawer extends StatelessWidget {
  MainDrawer({Key? key, required this.onSelectScreen});

  final void Function(String identifier) onSelectScreen;

  @override
  Widget build(BuildContext context) {
    Future<void> _logout() async {
      print("called");
      final response = await http.get(
        Uri.parse('https://anyy.onrender.com/api/logout'), // Replace with your server's logout endpoint
      );

      if (response.statusCode == 200) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ),
        );
        // Handle successful logout on the client side, such as clearing user data or navigating to the login page.
      } else {
        // Handle logout error, show an error message, etc.
      }
    }
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.red,
                  Colors.red

                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.bus_alert_outlined,
                  size: 48,
                  color: Colors.white, // Adjust icon color
                ),
                const SizedBox(width: 18),
                Text(
                  translation(context).smartBus,

                  style: TextStyle(
                    color: Colors.white, // Adjust text color
                    fontSize: 28, // Adjust font size
                    fontWeight: FontWeight.bold, // Add font weight
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.person,
              size: 26,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: Text(

              translation(context).profile,
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 18, // Adjust font size
                fontWeight: FontWeight.bold, // Add font weight
              ),
            ),
            onTap: () {
              onSelectScreen('profile');
            },
          ),
          // ListTile(
          //   leading: Icon(
          //     Icons.search,
          //     size: 26,
          //     color: Theme.of(context).colorScheme.primary,
          //   ),
          //   title: Text(
          //
          //     translation(context).search,
          //     style: TextStyle(
          //       color: Theme.of(context).colorScheme.primary,
          //       fontSize: 18, // Adjust font size
          //       fontWeight: FontWeight.bold, // Add font weight
          //     ),
          //   ),
          //   onTap: () {
          //     onSelectScreen('search');
          //   },
          // ),
          // ListTile(
          //   leading: Icon(
          //     Icons.book,
          //     size: 26,
          //     color: Theme.of(context).colorScheme.primary,
          //   ),
          //   title: Text(
          //
          //     translation(context).booked,
          //     style: TextStyle(
          //       color: Theme.of(context).colorScheme.primary,
          //       fontSize: 18, // Adjust font size
          //       fontWeight: FontWeight.bold, // Add font weight
          //     ),
          //   ),
          //   onTap: () {
          //     onSelectScreen('booked');
          //   },
          // ),
          ListTile(
            leading: Icon(
              Icons.settings,
              size: 26,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: Text(

              translation(context).setting,
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 18, // Adjust font size
                fontWeight: FontWeight.bold, // Add font weight
              ),
            ),
            onTap: () {
              onSelectScreen('setting');
            },
          ),
          ListTile(
            leading: Icon(
              Icons.logout,
              size: 26,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: Text(

              translation(context).logout,
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 18, // Adjust font size
                fontWeight: FontWeight.bold, // Add font weight
              ),
            ),
            onTap: () {
              print("new world");
              _logout();
            },
          ),
          // Repeat the ListTile widgets for other menu items
        ],
      ),
    );
  }
}