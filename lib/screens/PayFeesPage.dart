import 'package:flutter/material.dart';
import 'package:school_fees_ease/screens/PayFeesPage.dart';

class PayFeesPage extends StatefulWidget {
  @override
  _PayFeesPageState createState() => _PayFeesPageState();
}

class _PayFeesPageState extends State<PayFeesPage> {
  TextEditingController amountController = TextEditingController();
  TextEditingController purposeController = TextEditingController();
  TextEditingController studentNumberController = TextEditingController();

  String selectedPaymentMethod = 'Credit Card'; // Default payment method
  String selectedSchool = 'School A'; // Default school
  String studentName = 'John Doe'; // Placeholder student name
  String studentClass = 'Class X'; // Placeholder student class

  List<String> paymentMethods = [
    'Credit Card',
    'Mobile Money',
    'Bank Transfer (Different Banks)',
  ];

  List<String> schoolsInUganda = [
    'School A',
    'School B',
    'School C',
    'School D',
    // Add more schools as needed
  ];
  
  selectedMobileMoneyProvider() => null;

  // Function to simulate fetching student details based on entered student number
  void fetchStudentDetails(String studentNumber) {
    // Simulate fetching student details...
    // Replace this with actual logic to fetch student details from a database or API
    if (studentNumber == '12345') {
      setState(() {
        studentName = 'Jane Smith'; // Sample student name
        studentClass = 'Class XI'; // Sample student class
      });
    } else {
      setState(() {
        studentName = 'Student not found';
        studentClass = 'N/A';
      });
    }
  }
void processPayment() {
  String amount = amountController.text;
  String purpose = purposeController.text;
  String paymentMethod = selectedPaymentMethod;

  // Placeholder logic for each payment method
  if (paymentMethod == 'Credit Card') {
    // Placeholder for credit card payment processing
    print('Processing payment with Credit Card...');
    // Integrate with the payment gateway SDK/API here
  } else if (paymentMethod == 'Mobile Money') {
    // Placeholder for mobile money payment processing
    print('Processing payment with Mobile Money...');
    if (selectedSchool == 'School A') {
      // Integrate with Airtel Money API
      print('Using Airtel Money API for School A...');
    } else if (selectedSchool == 'School B') {
      // Integrate with MTN Mobile Money API
      print('Using MTN Mobile Money API for School B...');
    }
  } else if (paymentMethod == 'Bank Transfer (Stanbic)') {
    // Placeholder for Stanbic Bank transfer payment processing
    print('Processing payment with Stanbic Bank...');
    // Integrate with Stanbic Bank's API here
  } else if (paymentMethod == 'Bank Transfer (Equity)') {
    // Placeholder for Equity Bank transfer payment processing
    print('Processing payment with Equity Bank...');
    // Integrate with Equity Bank's API here
  } else if (paymentMethod == 'Bank Transfer (DFCU)') {
    // Placeholder for DFCU Bank transfer payment processing
    print('Processing payment with DFCU Bank...');
    // Integrate with DFCU Bank's API here
  } else if (paymentMethod == 'Bank Transfer (Centenary)') {
    // Placeholder for Centenary Bank transfer payment processing
    print('Processing payment with Centenary Bank...');
    // Integrate with Centenary Bank's API here
  }

  // Simulated success message (replace this with actual response handling)
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Payment Successful'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Amount: $amount'),
            Text('Purpose: $purpose'),
            Text('Payment Method: $paymentMethod'),
            SizedBox(height: 10),
            Text('Student Name: $studentName'),
            Text('Student Class: $studentClass'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close the dialog
            },
            child: Text('Close'),
          ),
        ],
      );
    },
  );
}

  // void processPayment() {
  //   String amount = amountController.text;
  //   String purpose = purposeController.text;
  //   String paymentMethod = selectedPaymentMethod;

  //   // Payment processing logic...
  //   // ...if (paymentMethod == 'Credit Card') {
  //   // Placeholder for credit card payment processing
  //   print('Processing payment with Credit Card...');
  //   // Integrate with the payment gateway SDK/API here
  // } else if (paymentMethod == 'Mobile Money') {
  //   // Placeholder for mobile money payment processing
  //   print('Processing payment with Mobile Money...');
  //   // Integrate with the mobile money provider's API here
  // } else if (paymentMethod == 'Bank Transfer (Different Banks)') {
  //   // Placeholder for bank transfer payment processing
  //   print('Processing payment with Bank Transfer...');
  //   // Integrate with the bank's API here
  // }


  //   // Simulate success message
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text('Payment Successful'),
  //         content: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Text('Amount: $amount'),
  //             Text('Purpose: $purpose'),
  //             Text('Payment Method: $paymentMethod'),
  //             SizedBox(height: 10),
  //             Text('Student Name: $studentName'),
  //             Text('Student Class: $studentClass'),
  //           ],
  //         ),
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               Navigator.pop(context); // Close the dialog
  //             },
  //             child: Text('Close'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  @override
  void dispose() {
    amountController.dispose();
    purposeController.dispose();
    studentNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var mobileMoneyProviders;
    var selectedBank;
    var banks;
    var children2 = [
              DropdownButtonFormField<String>(
                value: selectedSchool,
                onChanged: (String? value) {
                  setState(() {
                    selectedSchool = value!;
                  });
                },
                items: schoolsInUganda.map((String school) {
                  return DropdownMenuItem<String>(
                    value: school,
                    child: Text(school),
                  );
                }).toList(),
                decoration: InputDecoration(
                  labelText: 'Select School',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: studentNumberController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Student Number',
                  hintText: 'Enter student number',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  String studentNumber = studentNumberController.text;
                  fetchStudentDetails(studentNumber);
                },
                child: Text('Get Student Details'),
              ),
              SizedBox(height: 20),
              Text('Student Name: $studentName'),
              Text('Student Class: $studentClass'),
              SizedBox(height: 20),
              TextFormField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Amount',
                  hintText: 'Enter the amount',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: purposeController,
                decoration: InputDecoration(
                  labelText: 'Purpose',
                  hintText: 'Enter the purpose of payment',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              DropdownButtonFormField<String>( value: selectedPaymentMethod,
  onChanged: (String? value) {
    setState(() {
      selectedPaymentMethod = value!;
      // Reset selected bank or mobile money provider when payment method changes
    });
  },
  items: paymentMethods.map((String method) {
    return DropdownMenuItem<String>(
      value: method,
      child: Text(method),
    );
  }).toList(),
  decoration: InputDecoration(
    labelText: 'Payment Method',
    border: OutlineInputBorder(),
  ),
),
SizedBox(height: 20),
if (selectedPaymentMethod == 'Mobile Money')
  DropdownButtonFormField<String>(
    value: selectedMobileMoneyProvider(),
    onChanged: (String? value) {
      setState(() {
      });
    },
    items: mobileMoneyProviders.map((String provider) {
      return DropdownMenuItem<String>(
        value: provider,
        child: Text(provider),
      );
    }).toList(),
    decoration: InputDecoration(
      labelText: 'Select Mobile Money Provider',
      border: OutlineInputBorder(),
    ),
  ),
 if (selectedPaymentMethod == 'Bank Transfer (Different Banks)')
  DropdownButtonFormField<String>(
    value: selectedBank,
    onChanged: (String? value) {
      setState(() {
        selectedBank = value!;
      });
    },
    items: banks.map((String bank) {
      return DropdownMenuItem<String>(
        value: bank,
        child: Text(bank),
      );
    }).toList(),
    decoration: InputDecoration(
      labelText: 'Select Bank',
      border: OutlineInputBorder(),
    ),
  ),
                
              //   value: selectedPaymentMethod,
              //   onChanged: (String? value) {
              //     setState(() {
              //       selectedPaymentMethod = value!;
              //     });
              //   },
              //   items: paymentMethods.map((String method) {
              //     return DropdownMenuItem<String>(
              //       value: method,
              //       child: Text(method),
              //     );
              //   }).toList(),
              //   decoration: InputDecoration(
              //     labelText: 'Payment Method',
              //     border: OutlineInputBorder(),
              //   ),
              // ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: processPayment,
                child: Text('Make Payment'),
              ),
            ];
    return Scaffold(
      appBar: AppBar(
        title: Text('Pay Fees'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children2,
          ),
        ),
      ),
    );
  }
}

class selectedMobileMoneyProvider {
}
