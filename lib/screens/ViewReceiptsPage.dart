import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class ViewReceiptsPage extends StatelessWidget {
  final List<String> receipts = [
    'Receipt 1',
    'Receipt 2',
    'Receipt 3',
    // Add more receipts or replace with your receipt data
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Receipts'),
      ),
      body: ListView.builder(
        itemCount: receipts.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(receipts[index]),
            onTap: () {
              displayReceipt(context, receipts[index]);
            },
          );
        },
      ),
    );
  }

  void displayReceipt(BuildContext context, String receipt) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Receipt Details'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Receipt: $receipt'),
              SizedBox(height: 10),
              // Add specific details of the selected receipt
              Text('Amount: 100'),
              Text('Purpose: School Fees'),
              Text('Payment Method: Credit Card'),
              Text('Student Name: John Doe'),
              Text('Student Class: Class X'),
              // Add more receipt details as needed
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text('Close'),
            ),
            TextButton(
              onPressed: () async {
                await downloadReceipt(context, receipt);
              },
              child: Text('Download'),
            ),
          ],
        );
      },
    );
  }

  Future<void> downloadReceipt(BuildContext context, String receipt) async {
    // Generate the receipt content
    String receiptContent = generateReceiptContent(receipt);

    // Save the receipt content to a file
    String? filePath = await saveReceiptToFile(receipt, receiptContent);

    if (filePath != null) {
      // Show a message after downloading the receipt
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$receipt downloaded to $filePath'),
          action: SnackBarAction(
            label: 'Open',
            onPressed: () {
              // Open file on the device
              OpenFile.open(filePath);
            },
          ),
        ),
      );
    } else {
      // Show an error message if download failed
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to download $receipt'),
        ),
      );
    }
  }

  String generateReceiptContent(String receipt) {
    // Replace with logic to generate receipt content
    return 'Amount: 100\nPurpose: School Fees\nPayment Method: Credit Card\nStudent Name: John Doe\nStudent Class: Class X';
  }

  Future<String?> saveReceiptToFile(String receiptName, String receiptContent) async {
    try {
      Directory directory = await getApplicationDocumentsDirectory();
      String filePath = '${directory.path}/$receiptName.txt';

      File file = File(filePath);
      await file.writeAsString(receiptContent);

      return filePath;
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }
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
