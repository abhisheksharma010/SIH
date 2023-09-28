import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
import 'signup.dart';
import 'tabs.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isLoading = false;

  // Function to handle the "Register now" click event
  void openSignUpScreen() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => SignUpScreen(),
      ),
    );
  }

  // Function to handle the login button click event
  void loginUser() async {
    if (_usernameController.text.isEmpty || _passwordController.text.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please fill in all fields.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    final username = _usernameController.text;
    final password = _passwordController.text;

    try {
      final Map<String, String> data = {
        'username': username,
        'password': password,
      };

      // final response = await http.post(
      //   Uri.parse('https://anyy.onrender.com/api/login'), // Replace with your actual API URL
      //   headers: <String, String>{
      //     'Content-Type': 'application/json',
      //   },
      //   body: json.encode(data),
      // );
      final response = await http.post(
        Uri.parse('https://anyy.onrender.com/api/login'), // Replace with your server's API endpoint
        body: {
          'username': username,
          'password': password,
        },
      );
      print(" " + json.encode(data) + "rgt");

      if (response.statusCode == 200) {
        // Login successful, handle as needed
        // You can decode the response JSON if needed
        // For example: final data = json.decode(response.body);
        // Then, you can access the user's data like data['user']['username']

        // Navigate to the home screen or perform any desired actions
        // For example, you can use Navigator to navigate to the home screen:
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => AppState(),
          ),
        );
      } else {
        // Handle authentication failure
        Fluttertoast.showToast(
          msg: "Authentication failed. Please check your credentials.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      }
    } catch (error) {
      // Handle network errors or other exceptions here
      print('Error: $error');
      Fluttertoast.showToast(
        msg: "An error occurred. Please try again later.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => AppState(),
              ),
            );
          },
          child: Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width,
              maxHeight: MediaQuery.of(context).size.height,
            ),
            decoration: BoxDecoration(
              // gradient: LinearGradient(
              //   colors: [
              //     Colors.blue[800],
              //     Colors.blue[400],
              //   ],
              //   begin: Alignment.topLeft,
              //   end: Alignment.centerRight,
              // ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 36.0, horizontal: 24.0),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Smart Bus',
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 45,
                                fontFamily: 'Kablammo',
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            "Enter a Beautiful Place",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextField(
                            controller: _usernameController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              labelText: 'Username',
                              prefixIcon: Icon(Icons.person),
                              border: OutlineInputBorder(),
                              filled: true,
                              fillColor: Colors.grey[200],
                            ),
                          ),
                          SizedBox(height: 16.0),
                          TextField(
                            controller: _passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              prefixIcon: Icon(Icons.lock),
                              border: OutlineInputBorder(),
                              filled: true,
                              fillColor: Colors.grey[200],
                            ),
                          ),
                          SizedBox(height: 30.0),
                          // Loading indicator
                          isLoading
                              ? CircularProgressIndicator()
                              : Container(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                loginUser();
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.red,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(8.0),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 18.0),
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 80.0,
                          ),
                          GestureDetector(
                            onTap: () {
                              openSignUpScreen();
                            },
                            child: Text(
                              "Don't have an Account? Register now",
                              style: TextStyle(
                                color: Colors.red,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                          // Skip text
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 16.0),
                              child: Text(
                                "Skip >>",
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
