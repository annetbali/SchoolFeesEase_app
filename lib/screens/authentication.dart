import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:school_fees_ease/screens/widgets/app_button_widget.dart';
import 'package:school_fees_ease/screens/widgets/text_field_widget.dart';
import 'package:school_fees_ease/utils/colors.dart';

import '../Controllers/user_controller.dart';
import '../core/state.dart';
import '../utils/helpers.dart';
import 'password_recovery.dart';
import 'signup.dart'; // Import your SignUpPage

class Authentication extends ConsumerStatefulWidget {
  const Authentication({super.key});

  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends ConsumerState<Authentication> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    final userState = ref.watch(userProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        actions: [
          userState.status == Status.loading
              ? const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: SizedBox(
                      width: 30,
                      height: 30,
                      child: CircularProgressIndicator(
                        color: primaryColor,
                      )),
                )
              : Container()
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFieldWidget(
                controller: emailController,
                prefixIcon: const Icon(Icons.email),
                label: 'Email',
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!Helpers.emailValidator(value)) {
                    return 'The Entered email is not valid';
                  }
                  // You can add more validation if needed
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFieldWidget(
                controller: passwordController,
                label: 'Password',
                prefixIcon: const Icon(Icons.lock),
                suffixIcon: InkWell(
                  child: Icon(
                      _isObscure ? Icons.visibility : Icons.visibility_off),
                  onTap: () {
                    // Toggle password visibility
                    setState(() {
                      _isObscure = !_isObscure;
                    });
                  },
                ),
                obscureText: _isObscure,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  // You can add more validation if needed
                  return null;
                },
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.topRight,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PasswordRecoveryPage()),
                    );
                    // Placeholder for "Forgot Password?" functionality
                    // You can implement password recovery logic here
                    // For instance, navigate to a password recovery page
                  },
                  child: const Text('Forgot Password?'),
                ),
              ),
              const SizedBox(height: 24.0),
              AppButtonWidget(
                  borderRadius: 15,
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      ref.read(userProvider.notifier).login(
                            emailController.text,
                            passwordController.text,
                          );
                    }
                  },
                  child: const Text('Log In',
                      style: TextStyle(color: whiteColor))),
              const SizedBox(height: 30),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SignUpPage()),
                  );
                },
                child: const Text(' Go back to Sign Up?'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
