import 'package:flutter/material.dart';
import 'package:school_fees_ease/screens/splash_screen.dart';
import 'package:school_fees_ease/screens/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}); // Correct the constructor

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:school_fees_ease/screens/splash_screen.dart';
// import 'package:school_fees_ease/screens/homepage.dart';
// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: const SplashScreen(),
//     );
//   }
// }

