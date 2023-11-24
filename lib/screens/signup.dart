import 'package:flutter/material.dart';
import 'package:school_fees_ease/screens/authentication.dart';
import 'package:school_fees_ease/screens/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sign Up Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SignUpPage(),
    );
  }
}

class SignUpPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      
        body: Container(
        decoration: BoxDecoration(
          color: Color.fromRGBO(8, 8, 0, 0.5), // Transparent white (adjust the alpha value as needed)
        ),
        child:Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              buildTextFieldWithIcon(
                controller: usernameController,
                labelText: 'Username',
                icon: Icons.person,
                validatorMessage: 'Please enter your username',
              ),
              SizedBox(height: 16.0),
              buildTextFieldWithIcon(
                controller: contactController,
                labelText: 'Contact',
                icon: Icons.phone,
                keyboardType: TextInputType.phone,
                validatorMessage: 'Please enter your contact',
              ),
              SizedBox(height: 16.0),
              buildTextFieldWithIcon(
                controller: emailController,
                labelText: 'Email',
                icon: Icons.email,
                keyboardType: TextInputType.emailAddress,
                validatorMessage: 'Please enter your email',
              ),
              SizedBox(height: 16.0),
              buildTextFieldWithIcon(
                controller: passwordController,
                labelText: 'Password',
                icon: Icons.lock,
                obscureText: true,
                validatorMessage: 'Please enter your password',
              ),
              SizedBox(height: 16.0),
              buildTextFieldWithIcon(
                controller: confirmPasswordController,
                labelText: 'Confirm Password',
                icon: Icons.lock,
                obscureText: true,
                validatorMessage: 'Please confirm your password',
                confirmValidator: (value) {
                  if (value != passwordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
              SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    signUp(
                      emailController.text,
                      passwordController.text,
                      usernameController.text,
                      contactController.text,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Signup Successful!'),
                      ),
                    );
                    Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()), // Replace 'HomePage' with your actual home page widget
      );
                  }
                },
                child: Text('Sign Up'),
              ),


              SizedBox(
                height: 20,
              ),
               ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Authentication()),
                  );
                },
                child: Text('Already have an account?   \   Log In'),
              ),
            ],
          ),
        ),
      ),
    ),
    );
  }

  Widget buildTextFieldWithIcon({
    required TextEditingController controller,
    required String labelText,
    required IconData icon,
    bool obscureText = false,
    TextInputType? keyboardType,
    String? validatorMessage,
    String? Function(String?)? confirmValidator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(),
        prefixIcon: Icon(icon),
      ),
      obscureText: obscureText,
      keyboardType: keyboardType,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return validatorMessage ?? 'Please enter valid information';
        }
        if (confirmValidator != null) {
          return confirmValidator(value);
        }
        return null;
      },
    );
  }

  Future<void> signUp(
    String email,
    String password,
    String username,
    String contact,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', email);
    await prefs.setString('password', password);
    await prefs.setString('username', username);
    await prefs.setString('contact', contact);
  }
}
