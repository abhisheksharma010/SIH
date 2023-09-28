import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'tabs.dart';

// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Bus Login App',
//       home: LoginPage(),
//     );
//   }
// }

class LoginScreen extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginScreen> {
  final TextEditingController busNoController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String message = '';

  Future<void> loginUser() async {
    final String busNo = busNoController.text;
    final String password = passwordController.text;

    final response = await http.post(
      Uri.parse('https://temps-x4t0.onrender.com/android/busLogin'),
      body: {
        'BusNo': busNo,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      // Assuming the API returns a JSON object with 'obj' property.
      final obj = data['obj'];
      // Handle successful login here, e.g., navigate to a new screen.
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => AppState(),
        ),
      );
    } else if (response.statusCode == 404) {
      setState(() {
        message = 'Incorrect Bus Number or Password';
      });
    } else {
      setState(() {
        message = 'An error occurred, please try again later.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bus Login'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              message,
              style: TextStyle(color: Colors.red),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: TextField(
                controller: busNoController,
                decoration: InputDecoration(
                  labelText: 'Bus Number',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                ),
              ),
            ),
            ElevatedButton(
              onPressed: loginUser,
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
