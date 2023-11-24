import 'package:flutter/material.dart';
import 'package:school_fees_ease/screens/help_page.dart';
import 'homepage.dart';



class UserAccountPage extends StatelessWidget {
  final String userName;
  final String userEmail;

  UserAccountPage({required this.userName, required this.userEmail});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome, $userName'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Implement search functionality
            },
          ),
        ],
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: <Widget>[
          // Categories here (similar to your homepage categories)
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.home, size: 30), // Adjust size here
                  onPressed: () {
                    Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ),
                );
                    // Navigator.pushNamed(context, '/home');
                  },
                ),
                Text('Home'),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.rss_feed, size: 30), // Adjust size here
                  onPressed: () {
                //     Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => (),
                //   ),
                // );
                    Navigator.pushNamed(context, '/feed');
                  },
                ),
                Text('Feed'),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.account_circle, size: 30), // Adjust size here
                  onPressed: () {
                    Navigator.pushNamed(context, '/account');
                  },
                ),
                Text('Account'),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.help, size: 30), // Adjust size here
                  onPressed: () {
                  
                    // Navigator.pushNamed(context, '/help');
                    Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HelpPage(),
                  ),
                );
                  },
                ),
                Text('Help'),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.logout, size: 30), // Adjust size here
                  onPressed: () {
                    // Implement logout functionality
                  },
                ),
                Text('Logout'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
