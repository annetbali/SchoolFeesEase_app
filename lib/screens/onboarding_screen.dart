import 'package:flutter/material.dart';
import 'package:school_fees_ease/screens/login.dart';

// onboarding screen
class OnboardingScreenOne extends StatelessWidget {
  const OnboardingScreenOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("images/onboarding.png", height: 250,),
            const Text("Buy with Dynapharm"),
            ElevatedButton(onPressed: (){
                 Navigator.push(context,MaterialPageRoute(
                builder: (context) => const OnboardingScreenTwo()),);
              }, child: const Text("Get started")), 
          ],
        ),
      ),
    );
  }
}

class OnboardingScreenTwo extends StatelessWidget {
  const OnboardingScreenTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("images/2.png", height: 250,),
            const Text("Buy with Dynapharm"),
            const SizedBox (height: 20), // Add spacing between the text and buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => const OnboardingScreenOne(),
                    ));
                  },
                  child: const Text("Back"),
                ),
                const SizedBox (width: 20), // Add spacing between buttons
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => const OnboardingScreenThree(),
                    ));
                  },
                  child: const Text("Next"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


class OnboardingScreenThree extends StatelessWidget {
  const OnboardingScreenThree({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("images/3.png", height: 250,),
            const Text("Buy with Dynapharm"),
            const SizedBox(height: 20), // Add spacing between the text and buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => const OnboardingScreenTwo(),
                    ));
                  },
                  child: const Text("Back", ),
                ),
                const SizedBox(width: 20), // Add spacing between buttons
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => LoginScreen(),
                    ));
                  },
                  child: const Text("Done"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
