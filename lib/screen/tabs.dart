import 'package:flutter/material.dart';
import 'package:smartbus/screen/home.dart';
import 'package:smartbus/screen/booked.dart';
import 'package:smartbus/screen/search.dart';
import 'package:smartbus/screen/profile.dart';
import 'package:smartbus/widgets/setting.dart';
import 'package:smartbus/widgets/drawer.dart';

class AppState extends StatefulWidget {
  AppState({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AppState();
  }
}

class _AppState extends State<AppState> {
  final tabs = [HomeScreen(), SearchScreen(), BookedScreen(), ProfileScreen()];
  int currentTabIndex = 0;

  final appBarTitles = ['SmartBus', 'Search', 'Booked', 'Profile'];

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
          appBarTitles[0],
          style: TextStyle(color: Colors.white), // Set title text color to white
        )
            : Text(
          appBarTitles[currentTabIndex],
          style: TextStyle(color: Colors.white), // Set title text color to white
        ),
        flexibleSpace: Container(
          color: Colors.red,
        ),
        iconTheme: IconThemeData(color: Colors.white), // Set drawer icon color to white
      ),
      drawer: MainDrawer(
        onSelectScreen: (identifier) async {
          // Handle navigation within the drawer widget
          if (identifier == 'home') {
            selectScreen(0);
          } else if (identifier == 'search') {
            selectScreen(1);
          } else if (identifier == 'booked') {
            selectScreen(2);
          } else if (identifier == 'profile') {
            selectScreen(3);
          }
          // else if(identifier == 'setting'){
          //   await Navigator.of(context).push<Map<SettingsScreen, bool>>(
          //     MaterialPageRoute(
          //       // builder: (ctx) =>  SettingsScreen(),
          //     ),
          //   );
          // }
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
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
              ),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.library_books,
              ),
              label: 'Booked',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
              ),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
