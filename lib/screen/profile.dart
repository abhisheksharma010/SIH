import 'package:flutter/material.dart';
import 'dart:io'; // Import the dart:io package
import 'package:image_picker/image_picker.dart';

class UserProfile {
  final String firstName;
  final String lastName;
  final int age;
  final String dateOfBirth;
  final String city;
  final String country;
  final String email;
  final String number;

  UserProfile({
  required this.firstName,
  required this.lastName,
  required this.age,
  required this.dateOfBirth,
  required this.city,
  required this.country,
  required this.email,
  required this.number,
});
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  XFile? _imageFile;
  final ImagePicker _picker = ImagePicker();

  // Create a dummy UserProfile object
  final UserProfile dummyUserProfile = UserProfile(
    firstName: "John",
    lastName: "Doe",
    age: 30,
    dateOfBirth: "01/01/1990",
    city: "New York",
    country: "USA",
    email: "john.doe@example.com",
    number: " 123-456-7890",
  );

  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery);

    setState(() {
      _imageFile = pickedFile;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  radius: 80.0,
                  backgroundImage: _imageFile != null
                      ? FileImage(File(_imageFile!.path))
                      : AssetImage(
                      'images/default_profile_image.jpeg') as ImageProvider<
                      Object>, // Cast to ImageProvider
                  child: _imageFile == null
                      ? Icon(Icons.add_a_photo, size: 40.0)
                      : null,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            // Display user profile information here
            buildProfileField("First Name", dummyUserProfile.firstName),
            buildProfileField("Last Name", dummyUserProfile.lastName),
            buildProfileField("Age", dummyUserProfile.age.toString()),
            buildProfileField("Date of Birth", dummyUserProfile.dateOfBirth),
            buildProfileField("City", dummyUserProfile.city),
            buildProfileField("Country", dummyUserProfile.country),
            buildProfileField("Email", dummyUserProfile.email),
            buildProfileField("Number", dummyUserProfile.number),
          ],
        ),
      ),
    );
  }

  Widget buildProfileField(String label, String value) {
    return Container(
      padding: EdgeInsets.all(16.0),
      margin: EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8.0),
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
          Expanded( // Wrap the value in an Expanded widget
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
}
