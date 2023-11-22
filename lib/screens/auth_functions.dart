import 'package:shared_preferences/shared_preferences.dart';

Future<void> signUp(String email, String password) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('email', email);
  await prefs.setString('password', password);
}

Future<bool> login(String email, String password) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? savedEmail = prefs.getString('email');
  String? savedPassword = prefs.getString('password');
  if (savedEmail != null && savedPassword != null) {
    if (email == savedEmail && password == savedPassword) {
      return true; // User is authenticated
    }
  }
  return false; // Invalid credentials
}
