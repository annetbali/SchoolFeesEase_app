import 'package:flutter/material.dart';

class FeeCategory {
  final String className;
  final double tuition;
  final double books;

  FeeCategory({
    required this.className,
    required this.tuition,
    required this.books,
  });
}

class UgandaMartyrsFeeCategories {
  static List<FeeCategory> getFeeCategories() {
    return [
      FeeCategory(className: 'Senior 1', tuition: 1000, books: 300),
      FeeCategory(className: 'Senior 2', tuition: 1100, books: 350),
      FeeCategory(className: 'Senior 3', tuition: 1200, books: 400),
      FeeCategory(className: 'Senior 4', tuition: 1300, books: 450),
      FeeCategory(className: 'Senior 5', tuition: 1400, books: 500),
      FeeCategory(className: 'Senior 6', tuition: 1500, books: 550),
    ];
  }
}

class TablePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<FeeCategory> feeCategories = UgandaMartyrsFeeCategories.getFeeCategories();

    List<DataRow> rows = feeCategories.map((category) {
      return DataRow(cells: [
        DataCell(Text(category.className)),
        DataCell(Text('\$${category.tuition.toString()}')),
        DataCell(Text('\$${category.books.toString()}')),
      ]);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Fee Table'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: [
              DataColumn(label: Text('Class')),
              DataColumn(label: Text('Tuition (\$)')),
              DataColumn(label: Text('Books (\$)')),
            ],
            rows: rows,
          ),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';

// class FeeCategory {
//   final String className;
//   final double tuition;
//   final double books;

//   FeeCategory({
//     required this.className,
//     required this.tuition,
//     required this.books,
//   });
// }

// class UgandaMartyrsFeeCategories {
//   static List<FeeCategory> getFeeCategories() {
//     return [
//       FeeCategory(className: 'Senior 1', tuition: 1000, books: 300),
//       FeeCategory(className: 'Senior 2', tuition: 1100, books: 350),
//       FeeCategory(className: 'Senior 3', tuition: 1200, books: 400),
//       FeeCategory(className: 'Senior 4', tuition: 1300, books: 450),
//       FeeCategory(className: 'Senior 5', tuition: 1400, books: 500),
//       FeeCategory(className: 'Senior 6', tuition: 1500, books: 550),
//     ];
//   }
// }

// class TablePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     List<FeeCategory> feeCategories = UgandaMartyrsFeeCategories.getFeeCategories();

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Fee Table'),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Table(
//           border: TableBorder.all(), // Adds borders to the table
//           columnWidths: {
//             0: FlexColumnWidth(2), // Class column takes 2 times more space
//             1: FlexColumnWidth(1),
//             2: FlexColumnWidth(1),
//           },
//           children: [
//             TableRow(
//               children: [
//                 TableCell(child: Center(child: Text('Class'))),
//                 TableCell(child: Center(child: Text('Tuition (\$)'))),
//                 TableCell(child: Center(child: Text('Books (\$)'))),
//               ],
//             ),
//             for (var category in feeCategories)
//               TableRow(
//                 children: [
//                   TableCell(
//                     child: Center(
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Text(category.className),
//                       ),
//                     ),
//                   ),
//                   TableCell(
//                     child: Center(
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Text('\$${category.tuition.toString()}'),
//                       ),
//                     ),
//                   ),
//                   TableCell(
//                     child: Center(
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Text('\$${category.books.toString()}'),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // import 'package:flutter/material.dart';

// // class FeeCategory {
// //   final String className;
// //   final double tuition;
// //   final double books;

// //   FeeCategory({
// //     required this.className,
// //     required this.tuition,
// //     required this.books,
// //   });
// // }

// // class UgandaMartyrsFeeCategories {
// //   static List<FeeCategory> getFeeCategories() {
// //     return [
// //       FeeCategory(className: 'Senior 1', tuition: 1000, books: 300),
// //       FeeCategory(className: 'Senior 2', tuition: 1100, books: 350),
// //       FeeCategory(className: 'Senior 3', tuition: 1200, books: 400),
// //       FeeCategory(className: 'Senior 4', tuition: 1300, books: 450),
// //       FeeCategory(className: 'Senior 5', tuition: 1400, books: 500),
// //       FeeCategory(className: 'Senior 6', tuition: 1500, books: 550),
// //     ];
// //   }
// // }

// // class TablePage extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     List<FeeCategory> feeCategories = UgandaMartyrsFeeCategories.getFeeCategories();

// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Fee Table'),
// //       ),
// //       body: Padding(
// //         padding: EdgeInsets.all(16.0),
// //         child: Table(
// //           border: TableBorder.all(),
// //           columnWidths: {
// //             0: FlexColumnWidth(2), // Class column takes 2 times more space
// //             1: FlexColumnWidth(1),
// //             2: FlexColumnWidth(1),
// //           },
// //           children: [
// //             TableRow(
// //               children: [
// //                 TableCell(child: Center(child: Text('Class'))),
// //                 TableCell(child: Center(child: Text('Tuition (\$)'))),
// //                 TableCell(child: Center(child: Text('Books (\$)'))),
// //               ],
// //             ),
// //             for (var category in feeCategories)
// //               TableRow(
// //                 children: [
// //                   TableCell(
// //                     child: Center(
// //                       child: Padding(
// //                         padding: const EdgeInsets.all(8.0),
// //                         child: Text(category.className),
// //                       ),
// //                     ),
// //                   ),
// //                   TableCell(
// //                     child: Center(
// //                       child: Padding(
// //                         padding: const EdgeInsets.all(8.0),
// //                         child: Text('\$${category.tuition.toString()}'),
// //                       ),
// //                     ),
// //                   ),
// //                   TableCell(
// //                     child: Center(
// //                       child: Padding(
// //                         padding: const EdgeInsets.all(8.0),
// //                         child: Text('\$${category.books.toString()}'),
// //                       ),
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
