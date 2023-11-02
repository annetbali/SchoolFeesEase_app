import 'package:flutter/material.dart';

class MakePaymentScreen extends StatefulWidget {
  @override
  _MakePaymentScreenState createState() => _MakePaymentScreenState();
}

class _MakePaymentScreenState extends State<MakePaymentScreen> {
  final TextEditingController recipientController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  void makePayment() {
    // Implement the payment processing logic here.
    // You may integrate with a payment gateway or service.
    // Example: Stripe, PayPal, etc.
    
    // Validate input data and process the payment.
    final recipient = recipientController.text;
    final amount = amountController.text;
    final description = descriptionController.text;

    // Perform payment processing actions, e.g., charge the user's credit card.

    // Show a confirmation dialog or navigate to a confirmation screen.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Make a Payment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Payment Details',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.0),
            TextFormField(
              controller: recipientController,
              decoration: InputDecoration(
                labelText: 'Recipient',
                prefixIcon: Icon(Icons.person),
              ),
            ),
            SizedBox(height: 10.0),
            TextFormField(
              controller: amountController,
              decoration: InputDecoration(
                labelText: 'Amount',
                prefixIcon: Icon(Icons.attach_money),
              ),
            ),
            SizedBox(height: 10.0),
            TextFormField(
              controller: descriptionController,
              decoration: InputDecoration(
                labelText: 'Description',
                prefixIcon: Icon(Icons.note),
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: makePayment,
              child: Text('Make Payment'),
            ),
          ],
        ),
      ),
    );
  }
}
