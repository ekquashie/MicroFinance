import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Dashboard",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Transactions Performed Today (12)",
              style: TextStyle(fontSize: 20),
            ),
            Text(
              "Registered Customers (32)",
              style: TextStyle(fontSize: 20),
            ),
            Text(
              "Registered Agents (8)",
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
