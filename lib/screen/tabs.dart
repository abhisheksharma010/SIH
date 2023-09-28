import 'package:flutter/material.dart';
import 'package:sihuser/screen/home.dart';
import 'package:sihuser/screen/booked.dart';
import 'package:sihuser/screen/search.dart';
import 'package:sihuser/screen/profile.dart';
import 'package:sihuser/widgets/setting.dart';
import 'package:sihuser/screen/searchbus.dart';
import 'package:sihuser/widgets/drawer.dart';
import 'editProfileScreen.dart';
import 'package:sihuser/screen/map.dart';
import 'package:sihuser/language_constants.dart';

class AppState extends StatefulWidget {
  AppState({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AppState();
  }
}

class _AppState extends State<AppState> {
  final tabs = [HomeScreen(),  ProfileScreen()];
  int currentTabIndex = 0;
  String intToString(int ibt) {
    if (ibt == 0) {
      return translation(context).smartBus;
    }
    // else if (ibt == 2) {
    //   return translation(context).booked;
    // }
    else {
      return translation(context).profile ; // You can provide a default value for other cases
    }
  }
  final appBarTitles = ['Home',  'Profile'];

  void selectScreen(int index) {
    setState(() {
      currentTabIndex = index;
      // Close the drawer if needed
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: currentTabIndex == 0
            ? Text(
          intToString(0),
          style: TextStyle(color: Colors.white), // Set title text color to white
        )
            : Text(
          intToString(currentTabIndex),
          style: TextStyle(color: Colors.white), // Set title text color to white
        ),

        flexibleSpace: Container(
          color: Colors.red,
        ),
        iconTheme: IconThemeData(color: Colors.white),
        actions: currentTabIndex == 1
            ? [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => EditProfileScreen(),
                ),
              );
              // Handle edit action
            },
          ),
        ]
            : null,
      ),
      drawer: MainDrawer(
        onSelectScreen: (identifier) async {
          // Handle navigation within the drawer widget
          if (identifier == 'home') {
            selectScreen(0);
          }
          // else if (identifier == 'booked') {
          //   selectScreen(2);
          // }
          else if (identifier == 'profile') {
            selectScreen(1);
          } else if (identifier == 'setting') {
            await Navigator.of(context).push<Map<SettingsScreen, bool>>(
              MaterialPageRoute(
                builder: (ctx) =>  SettingsScreen(),
              ),
            );
          }
        },
      ),
      backgroundColor: Colors.white, // Set background color to white
      body: tabs[currentTabIndex],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          // sets the background color of the `BottomNavigationBar`
          canvasColor: Colors.white,
          // sets the active color of the `BottomNavigationBar` if `Brightness` is light
          primaryColor: Colors.white,
          textTheme: Theme.of(context)
              .textTheme
              .copyWith(caption: TextStyle(color: Colors.white70)),
          // sets the inactive color of the `BottomNavigationBar`
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: currentTabIndex,
          onTap: (currentIndex) {
            setState(() {
              currentTabIndex = currentIndex;
            });
          },
          selectedLabelStyle: TextStyle(color: Colors.white),
          unselectedLabelStyle:
          TextStyle(color: Colors.black.withOpacity(0.6)),
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.black.withOpacity(0.6),
          backgroundColor: Colors.red, // Set background color to blue
          items:  [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),

              label:  translation(context).home,
            ),
            // BottomNavigationBarItem(
            //   icon: Icon(
            //     Icons.search,
            //   ),
            //   label:  translation(context).search,
            // ),
            // BottomNavigationBarItem(
            //   icon: Icon(
            //     Icons.library_books,
            //   ),
            //   label:  translation(context).booked,
            // ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
              ),
              label:  translation(context).profile,
            ),
          ],
        ),
      ),
    );
  }
}
