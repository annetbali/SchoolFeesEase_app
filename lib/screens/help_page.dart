import 'package:flutter/material.dart';

class HelpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Help'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text(
              'About SchoolFeeEase',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            title: Text('About'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              // Navigate to about section
            },
          ),
          ListTile(
            title: Text('Services'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              // Navigate to services section
            },
          ),
          ListTile(
            title: Text('FAQ'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              // Navigate to FAQ section
            },
          ),
          ListTile(
            title: Text('Privacy Policy'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              // Navigate to privacy policy section
            },
          ),
          Divider(), // Add a divider between sections
          ListTile(
            title: Text(
              'Settings',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            title: Text('Languages'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              // Navigate to language settings
            },
          ),
        ],
      ),
    );
  }
}
