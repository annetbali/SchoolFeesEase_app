import 'package:flutter/material.dart';
import 'package:school_fees_ease/screens/help_page.dart';

import 'FeeBreakdownPage.dart';
import 'PayFeesPage.dart';
import 'PaymentMethodsPage.dart';
import 'ViewReceiptsPage.dart';
import 'account.dart';
import 'schools.dart';
import 'students.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String notificationMessage = '';

  bool _showCloseButton = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('School Fees Payment'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              _showNotification(context);
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
                decoration: const BoxDecoration(
                  color: Colors.blue,
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        'assets/images/logo.png', // Replace with your logo asset path
                        width: 80, // Adjust width as needed
                        height: 80, // Adjust height as needed
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'school_fees_ease',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ])),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home Page'),
              onTap: () {
                //Navigate to the home page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomePage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Account'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const UserAccountPage(
                      userName: 'christine', // Replace with actual user data
                      userEmail:
                          'christinenalubwama4@gmail.com', // Replace with actual user data
                    ),
                  ),
                );
                // Navigate to the account page
              },
            ),
            ListTile(
              leading: const Icon(Icons.school),
              title: const Text('Schools'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SchoolListPage(),
                  ),
                );
                // Navigate to schools with fees and requirements page
              },
            ),
            ListTile(
              leading: const Icon(Icons.school),
              title: const Text('Students'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const StudentListPage(),
                  ),
                );
                // Navigate to schools with fees and requirements page
              },
            ),
            ListTile(
              leading: const Icon(Icons.help),
              title: const Text('Help'),
              onTap: () {
                // Navigate to the help page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HelpPage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.feedback),
              title: const Text('Feed'),
              onTap: () {
                // Navigate to the feed page
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.blue, // Replace with your preferred color
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      notificationMessage,
                      style:
                          const TextStyle(color: Colors.white, fontSize: 18.0),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                _showCloseButton
                    ? IconButton(
                        icon: const Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          _hideNotification();
                        },
                      )
                    : const SizedBox(),
              ],
            ),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              children: <Widget>[
                _buildCategoryCard(
                    'Pay Fees', Icons.payment, const PayFeesPage()),
                _buildCategoryCard(
                    'View Receipts', Icons.receipt, ViewReceiptsPage()),
                _buildCategoryCard(
                    'Fee Breakdown', Icons.list_alt, FeeBreakdownPage()),
                _buildCategoryCard(
                    'Payment Methods', Icons.credit_card, PaymentMethodsPage()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(String title, IconData icon, Widget page) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      child: Card(
        margin: const EdgeInsets.all(16.0),
        color: _showCloseButton
            ? Colors.lightBlue[200]
            : Colors.white, // Alternate colors
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              icon,
              size: 50.0,
            ),
            const SizedBox(height: 5.0),
            Text(
              title,
              style: const TextStyle(fontSize: 20.0),
            ),
          ],
        ),
      ),
    );
  }

  void _showNotification(BuildContext context) {
    setState(() {
      notificationMessage =
          'This is a notification!'; // Replace with your notification content
      _showCloseButton = true;
    });
  }

  void _hideNotification() {
    setState(() {
      notificationMessage = '';
      _showCloseButton = false;
    });
  }
}

// class PaymentMethodsPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Payment Methods'),
//       ),
//       body: Center(
//         child: Text('Payment Methods Page'),
//       ),
//     );
//   }
// }


