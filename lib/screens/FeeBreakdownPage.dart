import 'package:flutter/material.dart';
import 'package:school_fees_ease/models/fee_category.dart'; // Import your FeeCategory model

class FeeBreakdownPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<FeeCategory> feeCategories = UgandaMartyrsFeeCategories.getFeeCategories();

    return Scaffold(
      appBar: AppBar(
        title: Text('Fee Breakdown'),
      ),
      body: ListView.builder(
        itemCount: feeCategories.length,
        itemBuilder: (context, index) {
          var className = feeCategories[index].className;
          var tuition = feeCategories[index].tuition.toStringAsFixed(2);
          var books = feeCategories[index].books.toStringAsFixed(2);

          return ListTile(
            title: Text('$className'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Tuition: \$ $tuition'),
                Text('Books: \$ $books'),
              ],
            ),
          );
        },
      ),
    );
  }
}
