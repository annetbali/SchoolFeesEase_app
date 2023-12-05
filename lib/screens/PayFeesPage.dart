import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:school_fees_ease/core/state.dart';
import 'package:school_fees_ease/utils/colors.dart';

import '../Controllers/schools_controller.dart';
import '../Controllers/students_controller.dart';
import 'widgets/text_field_widget.dart';

class PayFeesPage extends ConsumerStatefulWidget {
  const PayFeesPage({super.key});

  @override
  _PayFeesPageState createState() => _PayFeesPageState();
}

class _PayFeesPageState extends ConsumerState<PayFeesPage> {
  TextEditingController amountController = TextEditingController();
  TextEditingController purposeController = TextEditingController();
  TextEditingController studentNumberController = TextEditingController();

  String selectedPaymentMethod = 'Credit Card'; // Default payment method
  String? selectedSchool; // Default school
  String studentName = 'John Doe'; // Placeholder student name
  String studentClass = 'Class X'; // Placeholder student class

  List<String> paymentMethods = [
    'Credit Card',
    'Mobile Money',
    'Bank Transfer (Different Banks)',
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
          title: const Text('Payment Successful'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Amount: $amount'),
              Text('Purpose: $purpose'),
              Text('Payment Method: $paymentMethod'),
              const SizedBox(height: 10),
              Text('Student Name: $studentName'),
              Text('Student Class: $studentClass'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: const Text('Close'),
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

  var mobileMoneyProviders;
  String? selectedBank;
  var banks;

  @override
  Widget build(BuildContext context) {
    final allSchoolsState = ref.watch(allSchoolsProvider);
    final getStudentState = ref.watch(getStudentProvider);
    var children2 = [
      DropDownWidget<String>(
          value: selectedSchool,
          onChanged: (String? value) {
            setState(() {
              selectedSchool = value!;
            });
          },
          items: [
            const DropdownMenuItem<String>(
              child: Text('Select School'),
            ),
            ...allSchoolsState.data!.map((school) {
              return DropdownMenuItem<String>(
                value: school.id,
                child: Text(school.name),
              );
            }).toList()
          ]),
      const SizedBox(height: 20),
      TextFieldWidget(
        controller: studentNumberController,
        keyboardType: TextInputType.number,
        label: 'Student Number',
        hint: 'Enter student number',
      ),
      const SizedBox(height: 10),
      ElevatedButton(
        onPressed: () {
          String studentNumber = studentNumberController.text;
          ref.read(getStudentProvider.notifier).getStudent(studentNumber);
          // fetchStudentDetails(studentNumber);
        },
        child: const Text('Get Student Details'),
      ),
      const SizedBox(height: 20),
      switch (getStudentState.status) {
        Status.initial => Container(),
        Status.loading => const CircularProgressIndicator(color: primaryColor),
        Status.loaded => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Student Name: ${getStudentState.data!.name}'),
              Text('Student Class: ${getStudentState.data!.level}')
            ],
          ),
        Status.error => Text(
            getStudentState.message!,
            style: const TextStyle(color: Colors.red),
          ),
      },
      const SizedBox(height: 20),
      TextFieldWidget(
        controller: amountController,
        keyboardType: TextInputType.number,
        label: 'Amount',
        hint: 'Enter the amount',
      ),
      const SizedBox(height: 20),
      TextFieldWidget(
        controller: purposeController,
        label: 'Purpose',
        hint: 'Enter the purpose of payment',
      ),
      const SizedBox(height: 20),
      DropDownWidget<String>(
        value: selectedPaymentMethod,
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
        label: 'Payment Method',
      ),
      const SizedBox(height: 20),
      if (selectedPaymentMethod == 'Mobile Money')
        DropDownWidget<String>(
          value: selectedMobileMoneyProvider(),
          onChanged: (String? value) {
            setState(() {});
          },
          items: mobileMoneyProviders.map((String provider) {
            return DropdownMenuItem<String>(
              value: provider,
              child: Text(provider),
            );
          }).toList(),
          label: 'Select Mobile Money Provider',
        ),
      if (selectedPaymentMethod == 'Bank Transfer (Different Banks)')
        DropDownWidget<String>(
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
          label: 'Select Bank',
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
      const SizedBox(height: 20),
      ElevatedButton(
        onPressed: processPayment,
        child: const Text('Make Payment'),
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pay Fees'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
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
