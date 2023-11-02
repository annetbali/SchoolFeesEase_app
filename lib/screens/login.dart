import 'package:flutter/material.dart';
import 'package:school_fees_ease/screens/homepage.dart';
import 'package:school_fees_ease/screens/register_screen.dart';
import 'package:school_fees_ease/screens/reset_password_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10),
            child: const Text(
              'Login here',
              style: TextStyle(fontSize: 20),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: emailController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email Address',
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: TextField(
              obscureText: true,
              controller: passwordController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              // Navigate to the Reset Password Screen (make sure this class exists)
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ResetPasswordScreen(), // Use the correct class here
                ),
              );
            },
            child: const Text('Forgot Password'),
          ),
          Container(
            height: 50,
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: ElevatedButton(
              onPressed: () {
                // Implement the login functionality
                // You can validate user credentials and handle authentication.
                // Example: if (isValidCredentials(emailController.text, passwordController.text)) { ... }
                
                // For this example, we'll assume the login is successful.
                // You should replace this with your authentication logic.
                // If login is successful, navigate to the homepage.
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ),
                );
              },
              child: const Text('Login'),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text('Do not have an account?'),
              TextButton(
                child: const Text(
                  'SignUp',
                  style: TextStyle(fontSize: 20),
                ),
                onPressed: () {
                  // Navigate to the Register Screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegisterScreen(),
                    ),
                  );
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:school_fees_ease/screens/register_screen.dart';
// import 'package:school_fees_ease/screens/reset_password_screen.dart';
// import 'package:school_fees_ease/screens/homepage.dart';
// class LoginScreen extends StatefulWidget {
//   const LoginScreen({Key? key}) : super(key: key);

//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   TextEditingController emailController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ListView(
//         children: <Widget>[
//           Container(
//             alignment: Alignment.center,
//             padding: const EdgeInsets.all(10),
//             child: const Text(
//               'Login here',
//               style: TextStyle(fontSize: 20),
//             ),
//           ),
//           Container(
//             padding: const EdgeInsets.all(10),
//             child: TextField(
//               controller: emailController,
//               decoration: const InputDecoration(
//                 border: OutlineInputBorder(),
//                 labelText: 'Email Address',
//               ),
//             ),
//           ),
//           Container(
//             padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
//             child: TextField(
//               obscureText: true,
//               controller: passwordController,
//               decoration: const InputDecoration(
//                 border: OutlineInputBorder(),
//                 labelText: 'Password',
//               ),
//             ),
//           ),
//           TextButton(
//             onPressed: () {
//               // Navigate to the Reset Password Screen (make sure this class exists)
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => ResetPasswordScreen(), // Use the correct class here
//                 ),
//               );
//             },
//             child: const Text('Forgot Password'),
//           ),
//           Container(
//             height: 50,
//             padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
//             child: ElevatedButton(
//               onPressed: () {
//                 // Implement the login functionality
//                 // You can validate user credentials and handle authentication.
//                 // Example: if (isValidCredentials(emailController.text, passwordController.text)) { ... }
//               },
//               child: const Text('Login'),
//             ),
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               const Text('Do not have an account?'),
//               TextButton(
//                 child: const Text(
//                   'SignUp',
//                   style: TextStyle(fontSize: 20),
//                 ),
//                 onPressed: () {
//                   // Navigate to the Register Screen
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => RegisterScreen(),
//                     ),
//                   );
//                 },
//               )
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }


