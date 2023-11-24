import 'package:flutter/material.dart';

class PaymentMethodsPage extends StatefulWidget {
  @override
  _PaymentMethodsPageState createState() => _PaymentMethodsPageState();
}

class _PaymentMethodsPageState extends State<PaymentMethodsPage> {
  String selectedBank = 'Centenary Bank';
  String selectedMobileMoney = 'MTN';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Methods'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.credit_card,
              size: 100.0,
              color: Colors.blue,
            ),
            SizedBox(height: 20.0),
            Text(
              'Choose a payment method:',
              style: TextStyle(fontSize: 24.0, color: Colors.black),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Functionality for selecting credit card
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
              ),
              child: Text(
                'Credit Card',
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: () {
                // Functionality for selecting PayPal
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
              ),
              child: Text(
                'PayPal',
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: 20.0),
            Column(
              children: [
                Text(
                  'Select Bank:',
                  style: TextStyle(fontSize: 20.0, color: Colors.black),
                ),
                DropdownButton<String>(
                  value: selectedBank,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedBank = newValue!;
                    });
                  },
                  items: <String>[
                    'Centenary Bank',
                    'Stanbic Bank',
                    'Equity Bank',
                    'DFU Bank',
                    'ABSA Bank',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(color: Colors.black),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            Column(
              children: [
                Text(
                  'Select Mobile Money Provider:',
                  style: TextStyle(fontSize: 20.0, color: Colors.black),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedMobileMoney = 'MTN';
                        });
                      },
                      child: Image.asset(
                        'assets/images/mtn_logo.png', // Replace with your MTN logo asset path
                        height: 50, // Adjust height as needed
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedMobileMoney = 'Airtel';
                        });
                      },
                      child: Image.asset(
                        'assets/images/airtel_logo.png', // Replace with your Airtel logo asset path
                        height: 50, // Adjust height as needed
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
