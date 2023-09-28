import 'package:sihproject/screen/login.dart';
import 'package:sihproject/screen/tabs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class SplashScreen extends StatefulWidget{
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState(){
    super.initState();
    _navigation();
  }
  void _navigation() async{
    await Future.delayed(Duration(milliseconds: 2500),(){});
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [

              Color.fromARGB(255, 246, 2, 2),
              Color.fromARGB(255, 255, 5, 5),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'images/logo1.webp',
              fit: BoxFit.cover,

            ),

            const SizedBox(
              height: 40,
            ),
        const SpinKitWave(
          color: Colors.white,
          size: 50.0,
        ),
            const SizedBox(
                height: 16,
            ),
            const Text('Smart Bus',style: TextStyle(color: Colors.white,fontSize: 45,fontFamily: 'Kablammo',fontWeight: FontWeight.bold),),
          ],
        ),
      ),
    );
  }
}