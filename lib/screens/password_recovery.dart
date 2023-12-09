import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:school_fees_ease/screens/widgets/app_button_widget.dart';
import 'package:school_fees_ease/utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Controllers/user_controller.dart';
import '../core/state.dart';
import 'widgets/text_field_widget.dart';

class PasswordRecoveryPage extends ConsumerStatefulWidget {
  const PasswordRecoveryPage({super.key});

  @override
  ConsumerState<PasswordRecoveryPage> createState() =>
      _PasswordRecoveryPageState();
}

class _PasswordRecoveryPageState extends ConsumerState<PasswordRecoveryPage> {
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final userState = ref.watch(passwordRecoveryProvider);
    ref.listen(passwordRecoveryProvider, (previous, next) {
      if (next.status == Status.loaded) {
        Navigator.of(context).pop();
        Fluttertoast.showToast(
            msg: next.data ?? 'Recovery email sent successfully!!!',
            timeInSecForIosWeb: 6);
      }
      if (next.status == Status.error) {
        Fluttertoast.showToast(
            msg: next.message ?? 'An error occurred !', timeInSecForIosWeb: 6);
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text('Password Recovery'),
        actions: [
          userState.status == Status.loading
              ? const Padding(
                  padding: EdgeInsets.all(8.0),
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
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
                // You can add more validation if needed
                return null;
              },
            ),
            const SizedBox(height: 16.0),
            AppButtonWidget(
              borderRadius: 15,
              onTap: userState.status == Status.loading
                  ? null
                  : () async {
                      if (emailController.text.isNotEmpty) {
                        ref
                            .watch(passwordRecoveryProvider.notifier)
                            .login(emailController.text.trim());
                      }
                    },
              child: const Text('Reset Password',
                  style: TextStyle(color: whiteColor)),
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
