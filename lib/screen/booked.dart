import 'package:flutter/material.dart';

class BookedScreen extends StatelessWidget{
  const BookedScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueGrey.shade800,Colors.black,Colors.black,Colors.black,Colors.black45],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )
      ),
    );
  }

}