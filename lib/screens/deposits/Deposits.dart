import 'package:flutter/material.dart';
import 'package:susu_gh/components/constants.dart';
import 'package:susu_gh/components/drawer.dart';
import 'package:susu_gh/screens/deposits/AddDeposit.dart';
import 'package:susu_gh/components/header.dart';
import 'package:date_format/date_format.dart';

class Deposits extends StatefulWidget {
  @override
  _DepositsState createState() => _DepositsState();
}

class _DepositsState extends State<Deposits> {
  String date = formatDate(DateTime.now(), [dd, '-', mm, '-', yyyy]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "Deposits",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: Icon(Icons.calendar_today),
          )
        ],
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: [
            header(date),
          ],
        ),
      ),
      drawer: AppDrawer(),
      //  StreamBuilder<QuerySnapshot>(
      //   stream: customers.snapshots(),
      //   builder: (context, snapshot) {
      //     if (snapshot.hasError) {
      //       return Text("Could not find customers");
      //     }
      //     if (!snapshot.hasData ||
      //         snapshot.connectionState == ConnectionState.waiting) {
      //       return Center(child: CircularProgressIndicator());
      //     }
      //     if (snapshot.data.docs.length == 0) {
      //       customerLength = snapshot.data.docs.length;
      //       return Center(
      //         child: Column(
      //           mainAxisAlignment: MainAxisAlignment.center,
      //           children: [
      //             Text(
      //               "Customers will appear here.",
      //               style: TextStyle(
      //                 fontSize: 20,
      //               ),
      //             ),
      //           ],
      //         ),
      //       );
      //     }
      //     return ListView(
      //       children: snapshot.data.docs.map((DocumentSnapshot document) {
      //         return Card(
      //           elevation: 5,
      //           margin: EdgeInsets.symmetric(
      //             horizontal: 10,
      //             vertical: 8,
      //           ),
      //           shape: RoundedRectangleBorder(
      //             borderRadius: BorderRadius.circular(8),
      //           ),
      //           child: ListTile(
      //             title: Text(document.id),
      //             subtitle:
      //                 Text("Created by: " + document.data()['created by']),
      //             onTap: () {
      //               detailPage(document);
      //             },
      //           ),
      //         );
      //       }).toList(),
      //     );
      //   },
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddDeposit()));
        },
        child: Icon(Icons.receipt),
      ),
    );
  }
}
