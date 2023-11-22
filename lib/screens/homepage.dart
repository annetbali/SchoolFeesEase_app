import 'package:flutter/material.dart';
import 'PayFeesPage.dart';
import 'ViewReceiptsPage.dart';
import 'FeeBreakdownPage.dart';



class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('School Fees Payment'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Drawer Header',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Item 1'),
              onTap: () {
                // Handle item 1 press
              },
            ),
            ListTile(
              title: Text('Item 2'),
              onTap: () {
                // Handle item 2 press
              },
            ),
          ],
        ),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: <Widget>[
          CategoryCard(
            title: 'Pay Fees',
            icon: Icons.payment,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PayFeesPage()),
              );
            },
          ),
          CategoryCard(
            title: 'View Receipts',
            icon: Icons.receipt,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ViewReceiptsPage()),
              );
            },
          ),
          CategoryCard(
            title: 'Fee Breakdown',
            icon: Icons.list_alt,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FeeBreakdownPage()),
              );
            },
          ),
          CategoryCard(
            title: 'Payment Methods',
            icon: Icons.credit_card,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PaymentMethodsPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function onTap;

  CategoryCard({required this.title, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap(); // This will navigate to the respective page when tapped
      },
      child: Card(
        margin: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              icon,
              size: 50.0,
            ),
            SizedBox(height: 5.0),
            Text(
              title,
              style: TextStyle(fontSize: 20.0),
            ),
          ],
        ),
      ),
    );
  }
}

// // Example pages for each category (replace with your actual pages)
// class PayFeesPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Pay Fees'),
//       ),
//       body: Center(
//         child: Text('Pay Fees Page'),
//       ),
//     );
//   }
// }

// class ViewReceiptsPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('View Receipts'),
//       ),
//       body: Center(
//         child: Text('View Receipts Page'),
//       ),
//     );
//   }
// }

// class FeeBreakdownPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Fee Breakdown'),
//       ),
//       body: Center(
//         child: Text('Fee Breakdown Page'),
//       ),
//     );
//   }
// }

class PaymentMethodsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Methods'),
      ),
      body: Center(
        child: Text('Payment Methods Page'),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'PayFeesPage.dart';


// class HomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('School Fees Payment'),
//       ),
//       body: GridView.count(
//         crossAxisCount: 2,
//         children: <Widget>[
//           CategoryCard(
//             title: 'Pay Fees',
//             icon: Icons.payment,
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => PayFeesPage()),
//               );
//             },
//           ),
//           CategoryCard(
//             title: 'View Receipts',
//             icon: Icons.receipt,
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => ViewReceiptsPage()),
//               );
//             },
//           ),
//           CategoryCard(
//             title: 'Fee Breakdown',
//             icon: Icons.list_alt,
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => FeeBreakdownPage()),
//               );
//             },
//           ),
//           CategoryCard(
//             title: 'Payment Methods',
//             icon: Icons.credit_card,
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => PaymentMethodsPage()),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }

// class CategoryCard extends StatelessWidget {
//   final String title;
//   final IconData icon;
//   final Function onTap;

//   CategoryCard({required this.title, required this.icon, required this.onTap});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         onTap();
//       },
//       child: Card(
//         margin: EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Icon(
//               icon,
//               size: 50.0,
//             ),
//             SizedBox(height: 5.0),
//             Text(
//               title,
//               style: TextStyle(fontSize: 20.0),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // Example pages for each category (replace with your actual pages)
// class PayFeesPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Pay Fees'),
//       ),
//       body: Center(
//         child: Text('Pay Fees Page'),
//       ),
//     );
//   }
// }

// class ViewReceiptsPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('View Receipts'),
//       ),
//       body: Center(
//         child: Text('View Receipts Page'),
//       ),
//     );
//   }
// }

// class FeeBreakdownPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Fee Breakdown'),
//       ),
//       body: Center(
//         child: Text('Fee Breakdown Page'),
//       ),
//     );
//   }
// }

// class PaymentMethodsPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Payment Methods'),
//       ),
//       body: Center(
//         child: Text('Payment Methods Page'),
//       ),
//     );
//   }
// }
