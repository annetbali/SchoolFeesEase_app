import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _PaymentHomePageState createState() => _PaymentHomePageState();
}

class _PaymentHomePageState extends State<HomePage> {
  double accountBalance = 1000.0; // Replace with the actual account balance

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Account Balance:',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              '\$$accountBalance',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Implement logic for making payments
              },
              child: Text('Make Payment'),
            ),
            ElevatedButton(
              onPressed: () {
                // Implement logic for viewing transaction history
              },
              child: Text('View Transactions'),
            ),
          ],
        ),
      ),
    );
  }
}
