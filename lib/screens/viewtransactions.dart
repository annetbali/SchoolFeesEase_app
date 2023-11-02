import 'package:flutter/material.dart';

class ViewTransactionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Transactions'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Transaction History',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            // Implement the display of transaction history here.
            // You can use a ListView, DataTable, or other widgets to show transaction data.
          ],
        ),
      ),
    );
  }
}
