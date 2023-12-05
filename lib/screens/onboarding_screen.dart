import 'package:flutter/material.dart';

import '../utils/colors.dart';
import 'signup.dart';
import 'widgets/app_button_widget.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  late AnimationController _controller;

  List<Map<String, String>> onboardingData = [
    {
      'title': 'Empowering Education',
      'description':
          'Unlock seamless school fee payments. Connect, manage, and pay for your children’s education effortlessly from anywhere',
      'imagePath': 'assets/images/image1.png', // Replace with your image path
    },
    {
      'title': 'Efficient Financial Management',
      'description':
          'Take control of finances. Securely handle school fees with intuitive payment tools and transparent transactions',
      'imagePath': 'assets/images/image2.png', // Replace with your image path
    },
    {
      'title': 'Global Connectivity',
      'description':
          'Bridging distances, connecting families. Experience global accessibility. Pay fees hassle-free, fostering education no matter the distance.',
      'imagePath': 'assets/images/image3.png', // Replace with your image path
    },
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: onboardingData.length,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              itemBuilder: (BuildContext context, int index) {
                return OnboardingPage(
                  title: onboardingData[index]['title']!,
                  description: onboardingData[index]['description']!,
                  imagePath: onboardingData[index]['imagePath']!,
                  isLast: index == onboardingData.length - 1,
                  controller: _controller,
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              if (_currentPage != 0)
                Expanded(
                  child: AppButtonWidget(
                    color: darkGreyColor,
                    onTap: () {
                      if (_currentPage > 0) {
                        _pageController.previousPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.ease,
                        );
                      }
                    },
                    child: const Text(
                      'Previous',
                      style: TextStyle(color: whiteColor),
                    ),
                  ),
                ),
              Expanded(
                child: AppButtonWidget(
                  onTap: () {
                    if (_currentPage < onboardingData.length - 1) {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.ease,
                      );
                    } else {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignUpPage(),
                        ),
                      );
                    }
                  },
                  child: Text(
                    _currentPage == onboardingData.length - 1
                        ? 'Get Started'
                        : 'Next',
                    style: const TextStyle(color: whiteColor),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;
  final bool isLast;
  final AnimationController controller;

  const OnboardingPage({
    super.key,
    required this.title,
    required this.description,
    required this.imagePath,
    required this.isLast,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const SizedBox(height: 20),
          AnimatedBuilder(
            animation: controller,
            builder: (BuildContext context, Widget? child) {
              return Transform.translate(
                offset: Offset(controller.value * 200, 0),
                child: Image.asset(
                  imagePath,
                  width: 300,
                  height: 300,
                  fit: BoxFit.contain,
                ),
              );
            },
          ),
          const SizedBox(height: 20),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            description,
            textAlign: TextAlign.center,
          ),
          if (isLast)
            const SizedBox(height: 100), // Add extra space for last slide
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:school_fees_ease/screens/signup.dart'; // Import your AuthenticationScreen

// class OnboardingScreen extends StatefulWidget {
//   @override
//   _OnboardingScreenState createState() => _OnboardingScreenState();
// }

// class _OnboardingScreenState extends State<OnboardingScreen> {
//   final PageController _pageController = PageController();
//   int _currentPage = 0;
//   List<Map<String, String>> onboardingData = [
//     {
//       'title': 'Empowering Education',
//       'description':
//           'Unlock seamless school fee payments. Connect, manage, and pay for your children’s education effortlessly from anywhere',
//       'imagePath': 'assets/images/image1.png', // Replace with your image path
//     },
//     {
//       'title': 'Efficient Financial Management',
//       'description':
//           'Take control of finances. Securely handle school fees with intuitive payment tools and transparent transactions',
//       'imagePath': 'assets/images/image2.png', // Replace with your image path
//     },
//     {
//       'title': 'Global Connectivity',
//       'description':
//           'Bridging distances, connecting families. Experience global accessibility. Pay fees hassle-free, fostering education no matter the distance.',
//       'imagePath': 'assets/images/image3.png', // Replace with your image path
//     },
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: <Widget>[
//           Expanded(
//             child: PageView.builder(
//               controller: _pageController,
//               itemCount: onboardingData.length,
//               onPageChanged: (int page) {
//                 setState(() {
//                   _currentPage = page;
//                 });
//               },
//               itemBuilder: (BuildContext context, int index) {
//                 return OnboardingPage(
//                   title: onboardingData[index]['title']!,
//                   description: onboardingData[index]['description']!,
//                   imagePath: onboardingData[index]['imagePath']!,
//                   isLast: index == onboardingData.length - 1,
//                 );
//               },
//             ),
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: <Widget>[
//               ElevatedButton(
//                 onPressed: () {
//                   if (_currentPage > 0) {
//                     _pageController.previousPage(
//                       duration: Duration(milliseconds: 500),
//                       curve: Curves.ease,
//                     );
//                   }
//                 },
//                 child: Text('Previous'),
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   if (_currentPage < onboardingData.length - 1) {
//                     _pageController.nextPage(
//                       duration: Duration(milliseconds: 500),
//                       curve: Curves.ease,
//                     );
//                   } else {
//                     Navigator.pushReplacement(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => SignUpApp(),
//                       ),
//                     );
//                   }
//                 },
//                 child: Text(_currentPage == onboardingData.length - 1
//                     ? 'Get Started'
//                     : 'Next'),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

// class OnboardingPage extends StatelessWidget {
//   final String title;
//   final String description;
//   final String imagePath;
//   final bool isLast;

//   const OnboardingPage({
//     required this.title,
//     required this.description,
//     required this.imagePath,
//     required this.isLast,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       padding: EdgeInsets.all(20.0),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           SizedBox(height: 20),
//           Image.asset(
//             imagePath,
//             width: 300,
//             height: 300,
//             fit: BoxFit.contain,
//           ),
//           SizedBox(height: 20),
//           Text(
//             title,
//             style: TextStyle(
//               fontSize: 24,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           SizedBox(height: 20),
//           Text(
//             description,
//             textAlign: TextAlign.center,
//           ),
//           if (isLast) SizedBox(height: 100), // Add extra space for last slide
//         ],
//       ),
//     );
//   }
// }
