import 'package:flutter/material.dart';
import 'package:smartbus/screen/splashscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData(
      primaryColor: Color(0xFFFF5722), // Main color (red)
      scaffoldBackgroundColor: Color(0xFFFF4081), // Background color (pink)
      textTheme: TextTheme(
        bodyText2: TextStyle(
          color: Colors.white, // Set text color to white
        ),
      ),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme, // Apply the custom theme
      home: SplashScreen(),
    );
  }
}
