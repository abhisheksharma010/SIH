import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  MainDrawer({Key? key, required this.onSelectScreen});

  final void Function(String identifier) onSelectScreen;

  @override
  Widget build(BuildContext context) {
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
                  'SmartBus!',
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
              'Profile',
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
          ListTile(
            leading: Icon(
              Icons.search,
              size: 26,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: Text(
              'Search',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 18, // Adjust font size
                fontWeight: FontWeight.bold, // Add font weight
              ),
            ),
            onTap: () {
              onSelectScreen('search');
            },
          ),
          ListTile(
            leading: Icon(
              Icons.book,
              size: 26,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: Text(
              'Booked',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 18, // Adjust font size
                fontWeight: FontWeight.bold, // Add font weight
              ),
            ),
            onTap: () {
              onSelectScreen('booked');
            },
          ),
          ListTile(
            leading: Icon(
              Icons.settings,
              size: 26,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: Text(
              'setting',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 18, // Adjust font size
                fontWeight: FontWeight.bold, // Add font weight
              ),
            ),
            onTap: () {
              onSelectScreen('setting.dart');
            },
          ),
          ListTile(
            leading: Icon(
              Icons.logout,
              size: 26,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: Text(
              'Log Out',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 18, // Adjust font size
                fontWeight: FontWeight.bold, // Add font weight
              ),
            ),
            onTap: () {
              onSelectScreen('logout');
            },
          ),
          // Repeat the ListTile widgets for other menu items
        ],
      ),
    );
  }
}
