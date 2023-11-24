import 'package:flutter/material.dart';

class School {
  final String name;
  final String bankName;
  final String accountNumber;

  School({
    required this.name,
    required this.bankName,
    required this.accountNumber,
  });
}

List<School> schoolsInUganda = [
  // Adding schools  
  School(
    name: 'School 1',
    bankName: 'Bank A',
    accountNumber: '1234567890',
  ),
  
  School(
    name: 'School 2',
    bankName: 'Bank B',
    accountNumber: '0987654321',
  ),
   School(
    name: 'School 3',
    bankName: 'Bank c',
    accountNumber: '09876543456',
  ),
   School(
    name: 'School 4',
    bankName: 'Bank A',
    accountNumber: '0987654376',
  ), 
   School(
    name: 'School 5',
    bankName: 'Bank B',
    accountNumber: '0887654321',
  ),
   School(
    name: 'School 6',
    bankName: 'Bank A',
    accountNumber: '0987654321',
  ),
   School(
    name: 'School 7 ',
    bankName: 'Bank B',
    accountNumber: '0987654321',
  ),

];

class SchoolListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Schools in Uganda'),
      ),
      body: ListView.builder(
        itemCount: schoolsInUganda.length,
        itemBuilder: (context, index) {
          final school = schoolsInUganda[index];
          return ListTile(
            title: Text(school.name),
            onTap: () {
              // Navigate to a new page showing account details
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SchoolDetailsPage(school: school),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class SchoolDetailsPage extends StatelessWidget {
  final School school;

  SchoolDetailsPage({required this.school});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(school.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Bank: ${school.bankName}'),
            Text('Account Number: ${school.accountNumber}'),
          ],
        ),
      ),
    );
  }
}


