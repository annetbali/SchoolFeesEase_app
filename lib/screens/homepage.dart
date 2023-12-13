import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:school_fees_ease/Controllers/user_controller.dart';
import 'package:school_fees_ease/main.dart';
import 'package:school_fees_ease/screens/help_page.dart';
import 'package:school_fees_ease/screens/splash_screen.dart';

import 'FeeBreakdownPage.dart';
import 'PayFeesPage.dart';
import 'PaymentMethodsPage.dart';
import 'ViewReceiptsPage.dart';
import 'schools.dart';
import 'students.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
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
                      Text(
                        ref.watch(userProvider).data!.name.toUpperCase(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ])),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text(
                'Home Page',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onTap: () async {
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
              leading: const Icon(Icons.school),
              title: const Text(
                'Schools',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
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
              title: const Text(
                'Students',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
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
              title: const Text(
                'Help',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
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
              leading: const Icon(Icons.power_settings_new_rounded,
                  color: Colors.red),
              title: const Text(
                'Logout',
                style:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              ),
              onTap: () async {
                await auth.signOut();
                // Navigate to the feed page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SplashScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          if (_showCloseButton)
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
                        style: const TextStyle(
                            color: Colors.white, fontSize: 18.0),
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
                    'Pay \nFees', Icons.payment, const PayFeesPage()),
                _buildCategoryCard(
                    'View \nReceipts', Icons.receipt, const ViewReceiptsPage()),
                _buildCategoryCard(
                    'Fee \nBreakdown', Icons.list_alt, FeeBreakdownPage()),
                _buildCategoryCard('Payment \nMethods', Icons.credit_card,
                    PaymentMethodsPage()),
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
            : Colors.orange, // Alternate colors
        surfaceTintColor: _showCloseButton
            ? Colors.lightBlue[200]
            : Colors.orange, // Alternate colors
        child: Padding(
          padding: const EdgeInsets.all(10.0),
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
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 20.0),
              ),
            ],
          ),
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

