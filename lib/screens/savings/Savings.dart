import 'package:flutter/material.dart';
import 'package:susu_gh/components/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:susu_gh/components/drawer.dart';
import 'package:susu_gh/screens/savings/SavingsSearch.dart';
import 'SavingsDetail.dart';
import 'package:date_format/date_format.dart';
import 'package:susu_gh/components/header.dart';
import 'package:susu_gh/services/database.dart';

class Savings extends StatefulWidget {
  @override
  _SavingsState createState() => _SavingsState();
}

class _SavingsState extends State<Savings> {
  String today = formatDate(DateTime.now(), [dd, '-', mm, '-', yyyy]);
  String time = formatDate(DateTime.now(), [HH, ":", nn]);
  String customDate;

  @override
  void initState() {
    customDate = formatDate(DateTime.now(), [dd, '-', mm, '-', yyyy]);
    super.initState();
  }

  detailPage(DocumentSnapshot customer) {
    print(customer.id);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SavingsDetail(customer: customer)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "Savings",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              DateTime date = await showDatePicker(
                context: context,
                firstDate: DateTime(2021),
                initialDate: DateTime.now(),
                lastDate: DateTime.now(),
              );

              if (date != null) {
                setState(() {
                  customDate = formatDate(date, [dd, "-", mm, "-", yyyy]);
                });
              }
            },
            child: Icon(Icons.calendar_today),
          )
        ],
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: [
            header(customDate),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream:
                    savings.where('date', isEqualTo: customDate).snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text("Could not find transactions");
                  }
                  if (!snapshot.hasData ||
                      snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.data.docs.length == 0) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Transactions will appear here.",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return ListView(
                    children:
                        snapshot.data.docs.map((DocumentSnapshot document) {
                      return Card(
                        margin: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 10,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                        child: ListTile(
                          title: Text(
                            document['customer'],
                            style: TextStyle(fontSize: 18),
                          ),
                          subtitle: Text(
                            document['transaction type'] +
                                " by: " +
                                document['agent'],
                            style: TextStyle(fontSize: 15),
                          ),
                          trailing: Text(
                            "GHS " + document['amount'].toString(),
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      drawer: AppDrawer(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: customRed,
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => SavingsSearch()));
        },
        child: Icon(Icons.receipt),
      ),
    );
  }
}
