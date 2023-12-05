import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:school_fees_ease/Controllers/user_controller.dart';
import 'package:school_fees_ease/screens/authentication.dart';
import 'package:school_fees_ease/screens/homepage.dart';
import 'package:school_fees_ease/screens/widgets/app_button_widget.dart';
import 'package:school_fees_ease/utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/state.dart';
import '../utils/helpers.dart';
import 'widgets/text_field_widget.dart';

class SignUpPage extends ConsumerStatefulWidget {
  const SignUpPage({super.key});

  @override
  ConsumerState<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends ConsumerState<SignUpPage> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();

  final TextEditingController usernameController = TextEditingController();

  final TextEditingController contactController = TextEditingController();

  bool showPassword = true;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final userState = ref.watch(userProvider);
    ref.listen(userProvider, (previous, next) {
      if (next.status == Status.loaded) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    HomePage()) // Replace 'HomePage' with your actual home page widget
            );
      }
      if (next.status == Status.error) {
        Fluttertoast.showToast(
            msg: next.message ?? 'An error occurred !', timeInSecForIosWeb: 6);
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
        actions: [
          userState.status == Status.loading
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 30,
                    height: 30,
                    child: CircularProgressIndicator(
                      color: primaryColor,
                    ),
                  ),
                )
              : Container()
        ],
      ),
      body: Container(
        // decoration: BoxDecoration(
        //   color: Color.fromRGBO(8, 8, 0,
        //       0.5), // Transparent white (adjust the alpha value as needed)
        // ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  TextFieldWidget(
                    controller: usernameController,
                    label: 'Username',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your username';
                      }
                      return null;
                    },
                    prefixIcon: Icon(Icons.person),
                  ),
                  SizedBox(height: 16.0),
                  TextFieldWidget(
                    controller: contactController,
                    label: 'Contact',
                    prefixIcon: Icon(Icons.phone),
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your contact';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.0),
                  TextFieldWidget(
                    controller: emailController,
                    label: 'Email',
                    prefixIcon: Icon(Icons.email),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!Helpers.emailValidator(value)) {
                        return 'The Entered email is not valid';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.0),
                  TextFieldWidget(
                    controller: passwordController,
                    label: 'Password',
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: InkWell(
                      onTap: () {
                        setState(() {
                          showPassword = !showPassword;
                        });
                      },
                      child: Icon(showPassword
                          ? Icons.visibility_sharp
                          : Icons.visibility_off_rounded),
                    ),
                    obscureText: showPassword,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.0),
                  TextFieldWidget(
                    controller: confirmPasswordController,
                    label: 'Confirm Password',
                    prefixIcon: Icon(Icons.lock),
                    obscureText: showPassword,
                    suffixIcon: InkWell(
                      onTap: () {
                        setState(() {
                          showPassword = !showPassword;
                        });
                      },
                      child: Icon(showPassword
                          ? Icons.visibility_sharp
                          : Icons.visibility_off_rounded),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please confirm your password';
                      }
                      if (value != passwordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 24.0),
                  AppButtonWidget(
                      borderRadius: 15,
                      onTap: userState.status == Status.loading
                          ? null
                          : () {
                              if (_formKey.currentState!.validate()) {
                                // signUp(
                                //   emailController.text,
                                //   passwordController.text,
                                //   usernameController.text,
                                //   contactController.text,
                                // );
                                ref.read(userProvider.notifier).register(
                                    email: emailController.text,
                                    password: passwordController.text,
                                    contact: contactController.text,
                                    username: usernameController.text);
                              }
                            },
                      child:
                          Text('Sign Up', style: TextStyle(color: whiteColor))),
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: userState.status == Status.loading
                        ? null
                        : () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Authentication()),
                            );
                          },
                    child: Text('Already have an account?   \   Log In'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
