import 'package:flutter/material.dart';
import 'login.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;


class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // Define controllers for text fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  Future<void> _registerUser() async {
    try {
      final String apiUrl = 'https://anyy.onrender.com'; // Replace with your API URL

      final response = await http.post(
        Uri.parse('$apiUrl/api/signup'),
        body: {
          'username': _nameController.text,
          'email': _emailController.text,
          'password': _passwordController.text,
        },
      );

      if (response.statusCode == 201) {
        // User registered successfully
        final responseData = json.decode(response.body);
        final message = responseData['message'];
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(message),
        ));
      } else if (response.statusCode == 409) {
        // User already exists
        final responseData = json.decode(response.body);
        final message = responseData['message'];
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(message),
        ));
      } else {
        // Error registering user
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Error registering user'),
        ));
      }
    } catch (error) {
      print('Error registering user: $error');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error registering user'),
      ));
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Smart Bus',style: TextStyle(color: Colors.red,fontSize: 45,fontFamily: 'Kablammo',fontWeight: FontWeight.bold),),
            SizedBox(
              height: 60,
            ),
            // Name TextField with icon
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.grey[200], // Grayish effect
              ),
            ),
            SizedBox(height: 16.0),
            // Email TextField with icon
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email),
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.grey[200], // Grayish effect
              ),
            ),
            SizedBox(height: 16.0),
            // Password TextField with icon
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                prefixIcon: Icon(Icons.lock),
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.grey[200], // Grayish effect
              ),
            ),
            SizedBox(height: 30.0),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _registerUser,

                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 18.0),
                  child: Text(
                    "Sign Up",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            GestureDetector(
              onTap: () {
                // Navigate to the login screen when the text is tapped
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => LoginScreen(),
                ));
              },
              child: Text(
                'Already have an account? Login',
                style: TextStyle(
                  color: Colors.red,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Dispose of controllers when not needed to prevent memory leaks
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
