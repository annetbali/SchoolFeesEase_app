import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:school_fees_ease/core/state.dart';
import 'package:school_fees_ease/models/payment_model.dart';
import 'package:school_fees_ease/screens/widgets/app_button_widget.dart';
import 'package:school_fees_ease/utils/colors.dart';

import '../Controllers/payments_controller.dart';
import '../Controllers/schools_controller.dart';
import '../Controllers/students_controller.dart';
import '../models/school_model.dart';
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
  String schoolName = 'Class X'; // Placeholder school name

  List<String> paymentMethods = [
    'Credit Card',
    'Mobile Money',
    'Bank Transfer (Different Banks)',
  ];

  String? selectedMobileMoneyProvider;

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
              Text('School Name: $schoolName'),
            ],
          ),
          actions: [
            TextButton(
            onPressed: () {
              Navigator.pop(context); // Close the dialog
              _navigateToViewReceipt(context); // Navigate after 3 seconds
            },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
void _navigateToViewReceipt(BuildContext context) {
  Future.delayed(const Duration(seconds: 3), () {
    Navigator.pushReplacementNamed(context, '/view_receipt_page'); // Replace with your view receipt page route
  });
}

  @override
  void dispose() {
    amountController.dispose();
    purposeController.dispose();
    studentNumberController.dispose();
    super.dispose();
  }

  SchoolModel? schoolModel;

  var mobileMoneyProviders = ['MTN', 'AIRTEL'];
  String? selectedBank;
  var banks = ['Centenary Bank', 'Equity', 'Post Bank'];
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final allSchoolsState = ref.watch(allSchoolsProvider);
    final getStudentState = ref.watch(getStudentProvider);
    final paymentCRUDState = ref.watch(paymentCRUDProvider);
    ref.listen(paymentCRUDProvider, (previous, next) async {
      if (next.status == Status.loaded) {
        ref.invalidate(allPaymentsProvider);
      }
      if (next.status == Status.error) {
        Fluttertoast.cancel();
        Fluttertoast.showToast(
            msg: next.message ?? 'An error occurred !', timeInSecForIosWeb: 6);
      }
    });
    var children2 = [
      DropDownWidget<SchoolModel>(
          value: schoolModel,
          validator: (value) {
            if (value == null) {
              return 'Select School to continue';
            }
            return null;
          },
          onChanged: (SchoolModel? value) {
            setState(() {
              schoolModel = value!;
            });
          },
          items: [
            const DropdownMenuItem(
              child: Text('Select School'),
            ),
            ...allSchoolsState.data!.map((school) {
              return DropdownMenuItem(
                value: school,
                child: Text(school.name),
              );
            }).toList()
          ]),
      const SizedBox(height: 20),
      TextFieldWidget(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Enter student number here';
          }
          return null;
        },
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
        Status.loading => const CircularProgressIndicator(
            color: primaryColor, strokeWidth: 1.5),
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
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Enter amount to be paid';
          }
          return null;
        },
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
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Select payment method';
          }
          return null;
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
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Select mobile money provider';
            }
            return null;
          },
          onChanged: (String? value) {
            selectedMobileMoneyProvider = value;
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
          onChanged: (String? value) {
            setState(() {
              selectedMobileMoneyProvider = value!;
            });
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Select bank';
            }
            return null;
          },
          items: banks.map((String bank) {
            return DropdownMenuItem<String>(
              value: bank,
              child: Text(bank),
            );
          }).toList(),
          label: 'Select Bank',
        ),
      const SizedBox(height: 20),
      AppButtonWidget(
          borderRadius: 15,
          onTap: paymentCRUDState.status == Status.loading
              ? null
              : () async {
                  if (_formKey.currentState!.validate()) {
                    if (getStudentState.data == null) {
                      await Fluttertoast.cancel();
                      Fluttertoast.showToast(msg: 'No student found');
                      return;
                    }
                    ref.read(paymentCRUDProvider.notifier).addPayment(
                        PaymentModel(
                            id: DateTime.now()
                                .millisecondsSinceEpoch
                                .toString(),
                            amount: amountController.text,
                            paymentMethod: selectedPaymentMethod,
                            purpose: purposeController.text,
                            paymentProvider: selectedMobileMoneyProvider!,
                            school: schoolModel!,
                            student: getStudentState.data!,
                            createdAt: DateTime.now(),
                            updatedAt: DateTime.now()));
                    setState(() {
          // Clearing input fields after successful payment
          amountController.clear();
          purposeController.clear();
          studentNumberController.clear();
          // Displaying a success message
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Processing Payment...'),
                content: Text('Please wait while we process your payment.'),
              );
            },
          );
        });
        // processPayment(context); // Triggering the payment process
                  }
                },
          child: const Text('Make Payment',
              style: TextStyle(color: whiteColor, fontWeight: FontWeight.bold)))
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pay Fees'),
        actions: [
          paymentCRUDState.status == Status.loading
              ? const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 30,
                    height: 30,
                    child: CircularProgressIndicator(
                      color: primaryColor,
                    ),
                  ),
                )
              : Container()
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children2,
            ),
          ),
        ),
      ),
    );
  }
}
