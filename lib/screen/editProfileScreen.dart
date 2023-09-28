import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io'; // Import the dart:io package

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  // Define variables for image selection
  XFile? _imageFile;
  final ImagePicker _picker = ImagePicker();

  // Define TextEditingController for text input fields
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController numberController = TextEditingController();

  // Placeholder function to save changes (you can implement your logic)
  void saveChanges() {
    // Implement your logic to save changes here
    // You can access the values entered by the user using the controllers.
  }

  // Define mapping of input labels to icons
  final Map<String, IconData> inputIcons = {
    "Name": Icons.person,
    "Last Name": Icons.person,
    "Age": Icons.calendar_today,
    "Date of Birth": Icons.date_range,
    "City": Icons.location_city,
    "Country": Icons.location_on,
    "Email": Icons.email,
    "Number": Icons.phone,
  };

  // Gender selection variables
  String? selectedGender;

  // Function to pick an image from the device's gallery
  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _imageFile = pickedFile;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile",
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Image selection feature
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Profile Image",
                  style: TextStyle(

                    fontFamily:  'Serif',
                    color: Colors.grey[500],
                    fontSize: 24.0,
                    fontWeight: FontWeight.w800,
                  ),),
                SizedBox(
                  width: 20,

                ),
        GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 50.0,
                backgroundImage: _imageFile != null ? FileImage(File(_imageFile!.path)) : null,
                child: _imageFile == null ? Icon(Icons.add_a_photo, size: 40.0) : null,
              ),
            ),
              ],
            // Center(
            //   child: GestureDetector(
            //     onTap: _pickImage,
            //     child: CircleAvatar(
            //       radius: 50.0,
            //       backgroundImage: _imageFile != null ? FileImage(File(_imageFile!.path)) : null,
            //       child: _imageFile == null ? Icon(Icons.add_a_photo, size: 40.0) : null,
            //     ),
            //   ),
            // ),
            ),
            SizedBox(height: 16.0), // Add spacing
            buildInputField("Name", firstNameController),
            // buildInputField("Last Name", lastNameController),
            buildInputField("Age", ageController, keyboardType: TextInputType.number),
            buildInputField("Date of Birth", dobController),
            buildInputField("City", cityController),
            buildInputField("Country", countryController),
            buildInputField("Email", emailController, keyboardType: TextInputType.emailAddress),
            buildInputField("Number", numberController, keyboardType: TextInputType.phone),
            SizedBox(height: 16), // Add spacing
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  saveChanges();
                  // Add your login logic here
                  // For example, check user credentials
                  // and navigate to the next screen if successful
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 18.0),
                  child: Text(
                    "Save Changes",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildInputField(String labelText, TextEditingController controller, {TextInputType? keyboardType}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: labelText,
          prefixIcon: Icon(inputIcons[labelText]), // Icon based on input label
          border: OutlineInputBorder(),
          filled: true,
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Dispose of the TextEditingController to free up resources
    firstNameController.dispose();
    lastNameController.dispose();
    ageController.dispose();
    dobController.dispose();
    cityController.dispose();
    countryController.dispose();
    emailController.dispose();
    numberController.dispose();
    super.dispose();
  }
}
