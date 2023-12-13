import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:school_fees_ease/Controllers/payments_controller.dart';

import '../core/state.dart';
import '../models/payment_model.dart';
import '../utils/colors.dart';

class ViewReceiptsPage extends ConsumerWidget {
  const ViewReceiptsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allPaymentsState = ref.watch(allPaymentsProvider);
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Receipts'),
        actions: [
          paymentCRUDState.status == Status.loading ||
                  allPaymentsState.status == Status.loading
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
      body: ListView.builder(
        itemCount: allPaymentsState.data!.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(allPaymentsState.data![index].student.name),
            subtitle: Text(
                '${allPaymentsState.data![index].amount} ${allPaymentsState.data![index].student.level}'),
            onTap: () {
              displayReceipt(context, allPaymentsState.data![index]);
            },
          );
        },
      ),
    );
  }

  void displayReceipt(BuildContext context, PaymentModel receipt) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Receipt Details'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Receipt: ${receipt.id}'),
              const SizedBox(height: 10),
              // Add specific details of the selected receipt
              Text('Amount: ${receipt.amount}'),
              Text('Purpose: ${receipt.purpose}'),
              Text('Payment Method: ${receipt.paymentMethod}'),
              Text('Payment Provider: ${receipt.paymentProvider}'),
              Text('Student Name: ${receipt.student.name}'),
              Text('School Name: ${receipt.school.name}'),
              Text('Student Class: ${receipt.student.level}'),
              // Add more receipt details as needed
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: const Text('Close'),
            ),
            TextButton(
              onPressed: () async {
                await downloadReceipt(context, receipt);
                Navigator.of(context).pop();
              },
              child: const Text('Download'),
            ),
          ],
        );
      },
    );
  }

  Future<void> downloadReceipt(
      BuildContext context, PaymentModel receipt) async {
    // Generate the receipt content
    // String receiptContent = generateReceiptContent(receipt);

    // // Save the receipt content to a file
    String? filePath = await generateReceiptPdf(receipt);
    // String? filePath = await saveReceiptToFile(receipt.id, receiptContent);
    // try {
    //   Directory? directory = await getExternalStorageDirectory();
    //   directory ??= await getApplicationDocumentsDirectory();
    //   String filePath = '${directory.path}/$receiptName.txt';
    //   print(directory);
    //   File file = File(filePath);
    //   await file.writeAsString(receiptContent.toString());

    //   return filePath;
    // } catch (e) {
    //   print('Error: $e');
    //   return null;
    // }

    // if (filePath != null) {
    // Show a message after downloading the receipt
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${receipt.id} downloaded to $filePath'),
        action: SnackBarAction(
          label: 'Open',
          onPressed: () {
            // Open file on the device
            OpenFile.open(filePath);
          },
        ),
      ),
    );
  }

  Future<String> generateReceiptPdf(PaymentModel receipt) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              'Receipt Information',
              style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 18),
            ),
            pw.SizedBox(height: 10),
            pw.Divider(),
            pw.SizedBox(height: 10),
            pw.Text(
              receipt.id,
              style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 15),
            ),
            pw.SizedBox(height: 10),
            _buildText('Amount: \$${receipt.amount}'),
            pw.SizedBox(height: 5),
            _buildText('Purpose: ${receipt.purpose}'),
            pw.SizedBox(height: 5),
            _buildText('Payment Method: ${receipt.paymentMethod}'),
            pw.SizedBox(height: 5),
            _buildText('Payment Provider: ${receipt.paymentProvider}'),
            pw.SizedBox(height: 5),
            _buildText('Student Name: ${receipt.student.name}'),
            pw.SizedBox(height: 5),
            _buildText('Student Class: ${receipt.student.level}'),
            pw.SizedBox(height: 5),
            _buildText(
                'Paid On ${DateFormat('dd-MM-yyyy').format(receipt.createdAt)} at ${DateFormat('HH:mma').format(receipt.createdAt)}'),
          ],
        ),
      ),
    );

    final pdfBytes = await pdf.save();
    Directory? directory = await getExternalStorageDirectory();
    directory ??= await getApplicationDocumentsDirectory();
    String filePath = '${directory.path}/${receipt.id}.pdf';
    print(directory);
    File file = File(filePath);
    // await file.writeAsString(receiptContent.toString());
    file.writeAsBytesSync(pdfBytes);

    return filePath;
  }

  pw.Widget _buildText(String text) {
    return pw.Text(text, style: const pw.TextStyle(fontSize: 14));
  }

  // String generateReceiptContent(PaymentModel receipt) {
  //   // Replace with logic to generate receipt content
  //   return 'Amount: ${receipt.amount}\nPurpose: ${receipt.purpose}\nPayment Method: ${receipt.paymentMethod}\nStudent Name: ${receipt.student.name}\nStudent Class: ${receipt.student.level}';
  // }

  // Future<String?> saveReceiptToFile(
  //     String receiptName, String receiptContent) async {
  //   try {
  //     Directory? directory = await getExternalStorageDirectory();
  //     directory ??= await getApplicationDocumentsDirectory();
  //     String filePath = '${directory.path}/$receiptName.txt';
  //     print(directory);
  //     File file = File(filePath);
  //     await file.writeAsString(receiptContent.toString());

  //     return filePath;
  //   } catch (e) {
  //     print('Error: $e');
  //     return null;
  //   }
  // }
}

// import 'package:flutter/material.dart';
// import 'package:path_provider/path_provider.dart';
// import 'dart:io';

// class ViewReceiptsPage extends StatelessWidget {
//   final List<String> receipts = [
//     'Receipt 1',
//     'Receipt 2',
//     'Receipt 3',
//     // Add more receipts or replace with your receipt data
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('View Receipts'),
//       ),
//       body: ListView.builder(
//         itemCount: receipts.length,
//         itemBuilder: (BuildContext context, int index) {
//           return ListTile(
//             title: Text(receipts[index]),
//             onTap: () {
//               displayReceipt(context, receipts[index]);
//             },
//           );
//         },
//       ),
//     );
//   }

//   void displayReceipt(BuildContext context, String receipt) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Receipt Details'),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text('Receipt: $receipt'),
//               SizedBox(height: 10),
//               // Add specific details of the selected receipt
//               Text('Amount: 100'),
//               Text('Purpose: School Fees'),
//               Text('Payment Method: Credit Card'),
//               Text('Student Name: John Doe'),
//               Text('Student Class: Class X'),
//               // Add more receipt details as needed
//             ],
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context); // Close the dialog
//               },
//               child: Text('Close'),
//             ),
//             TextButton(
//               onPressed: () {
//                 downloadReceipt(context, receipt);
//               },
//               child: Text('Download'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void downloadReceipt(BuildContext context, String receipt) async {
//     // Generate the receipt content
//     String receiptContent = generateReceiptContent(receipt);

//     // Save the receipt content to a file
//     await saveReceiptToFile(receipt, receiptContent);

//     // Show a message after downloading the receipt
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text('$receipt downloaded'),
//       ),
//     );
//   }

//   String generateReceiptContent(String receipt) {
//     // Replace with logic to generate receipt content
//     return 'Amount: 100\nPurpose: School Fees\nPayment Method: Credit Card\nStudent Name: John Doe\nStudent Class: Class X';
//   }

//   Future<void> saveReceiptToFile(String receiptName, String receiptContent) async {
//     Directory directory = await getApplicationDocumentsDirectory();
//     String filePath = '${directory.path}/$receiptName.txt';

//     File file = File(filePath);
//     await file.writeAsString(receiptContent);
//   }
// }

// // import 'package:flutter/material.dart';
// // import 'package:path_provider/path_provider.dart';
// // import 'dart:io';

// // class ViewReceiptsPage extends StatelessWidget {
// //   final List<String> receipts = [
// //     'Receipt 1',
// //     'Receipt 2',
// //     'Receipt 3',
// //     // Add more receipts or replace with your receipt data
// //   ];

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('View Receipts'),
// //       ),
// //       body: ListView.builder(
// //         itemCount: receipts.length,
// //         itemBuilder: (BuildContext context, int index) {
// //           return ListTile(
// //             title: Text(receipts[index]),
// //             onTap: () {
// //               displayReceipt(context, receipts[index]);
// //             },
// //           );
// //         },
// //       ),
// //     );
// //   }

// //   void displayReceipt(BuildContext context, String receipt) {
// //     showDialog(
// //       context: context,
// //       builder: (BuildContext context) {
// //         return AlertDialog(
// //           title: Text('Receipt Details'),
// //           content: Column(
// //             mainAxisSize: MainAxisSize.min,
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [
// //               Text('Receipt: $receipt'),
// //               SizedBox(height: 10),
// //               // Add specific details of the selected receipt
// //               Text('Amount: 100'),
// //               Text('Purpose: School Fees'),
// //               Text('Payment Method: Credit Card'),
// //               Text('Student Name: John Doe'),
// //               Text('Student Class: Class X'),
// //               // Add more receipt details as needed
// //             ],
// //           ),
// //           actions: [
// //             TextButton(
// //               onPressed: () {
// //                 Navigator.pop(context); // Close the dialog
// //               },
// //               child: Text('Close'),
// //             ),
// //             TextButton(
// //               onPressed: () {
// //                 downloadReceipt(context, receipt);
// //               },
// //               child: Text('Download'),
// //             ),
// //           ],
// //         );
// //       },
// //     );
// //   }

// //   void downloadReceipt(BuildContext context, String receipt) async {
// //     // Generate the receipt content
// //     String receiptContent = generateReceiptContent(receipt);

// //     // Save the receipt content to a file
// //     await saveReceiptToFile(receipt, receiptContent);

// //     // Show a message after downloading the receipt
// //     ScaffoldMessenger.of(context).showSnackBar(
// //       SnackBar(
// //         content: Text('$receipt downloaded'),
// //       ),
// //     );
// //   }

// //   String generateReceiptContent(String receipt) {
// //     // Replace with logic to generate receipt content
// //     return 'Amount: 100\nPurpose: School Fees\nPayment Method: Credit Card\nStudent Name: John Doe\nStudent Class: Class X';
// //   }

// //   Future<void> saveReceiptToFile(String receiptName, String receiptContent) async {
// //     Directory directory = await getApplicationDocumentsDirectory();
// //     String filePath = '${directory.path}/$receiptName.txt';

// //     File file = File(filePath);
// //     await file.writeAsString(receiptContent);
// //   }
// // }
