import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PasswordRecoveryPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Password Recovery'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email),
              ),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                // You can add more validation if needed
                return null;
              },
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                if (emailController.text.isNotEmpty) {
                  bool resetSuccessful = await resetPassword(emailController.text);
                  if (resetSuccessful) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Password reset email sent!'),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Password reset failed. Invalid email!'),
                      ),
                    );
                  }
                }
              },
              child: Text('Reset Password'),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> resetPassword(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedEmail = prefs.getString('email');

    // Check if the entered email matches the stored email
    if (email == storedEmail) {
      // Implement logic to send a password recovery email or reset the password
      // You can replace this with your password reset mechanism
      // For now, this example updates the stored password to a new one 'new_password'
      await prefs.setString('password', 'new_password');
      return true; // Password reset successful
    }
    return false; // Invalid email, password reset failed
  }
}
