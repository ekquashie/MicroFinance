import 'package:flutter/material.dart';
import 'package:susu_gh/screens/admin/reports/SavingsReports.dart';
import 'package:susu_gh/screens/admin/reports/InvestmentsReports.dart';
import 'package:susu_gh/screens/admin/reports/LoanReports.dart';
import 'package:susu_gh/screens/admin/reports/DepositReports.dart';

class Reports extends StatefulWidget {
  @override
  _ReportsState createState() => _ReportsState();
}

class _ReportsState extends State<Reports> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reports", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Column(
        children: [
          InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SavingsReports(),
                    ));
              },
              child: reportCard("Savings")),
          InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DepositsReports(),
                    ));
              },
              child: reportCard("Fixed Deposit")),
          InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => InvestmentsReports(),
                    ));
              },
              child: reportCard("Investments")),
          InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoanReports(),
                    ));
              },
              child: reportCard("Instant Loans")),
        ],
      ),
    );
  }

  Card reportCard(String title) => Card(
        margin: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
        child: ListTile(
          title: Text(
            title,
            style: TextStyle(fontSize: 20),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 20,
          ),
        ),
      );
}
