import 'package:flutter/material.dart';
import 'package:sihproject/language.dart';
import 'package:sihproject/main.dart';
// import 'package:inditrans/inditrans.dart';
import 'package:sihproject/screen/editProfileScreen.dart';
import 'package:sihproject/language_constants.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  List<String> options = ["English", "Hindi", "Bengali", "Pahari", "Tibetan"];
  int selectedIndex = 0;

  void selectOption(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  // Function to navigate to the Edit Profile screen
  void navigateToEditProfile() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => EditProfileScreen(), // Replace with your Edit Profile screen
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(translation(context).setting),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 26.0), // Add left and right padding
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween, // Place items at both ends
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  translation(context).language,
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 20),
                DropdownButton<Language>(
                  hint: Text(translation(context).languagename),
                  iconSize: 30,
                  onChanged: (Language? language) async {
                    if (language != null) {
                      Locale _locale = await setLocale(language.languageCode);
                      MyApp.setLocale(context, _locale);
                    }
                  },
                  items: Language.languageList().map<DropdownMenuItem<Language>>(
                        (e) => DropdownMenuItem<Language>(
                      value: e,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text(e.name),
                        ],
                      ),
                    ),
                  ).toList(),
                ),
              ],
            ),
            SizedBox(height: 20),
            InkWell(
              onTap: navigateToEditProfile, // Navigate to Edit Profile screen
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 16.0, right: 16.0), // Add padding to both sides
                    child: Text(
                      "Edit Profile",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Icon(
                    Icons.edit,
                    color: Colors.red, // Set the color of the pencil icon to red
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
