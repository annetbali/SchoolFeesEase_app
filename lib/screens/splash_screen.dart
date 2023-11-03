import 'dart:async';
import 'package:flutter/material.dart';
import 'package:school_fees_ease/screens/onboarding_screen.dart';

// splash screen
class SplashScreen extends StatefulWidget{
  const SplashScreen({Key? key}) : super(key: key);

 @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 2), () {
      Navigator.push(
        context, MaterialPageRoute(builder: (context) => const OnboardingScreenOne()));
    });
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 250, 251, 252),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("images/logo.png", height: 180,),
          ],
        ),
      ),
    );
  }
}