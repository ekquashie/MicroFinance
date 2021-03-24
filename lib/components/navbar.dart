import 'package:flutter/material.dart';
import 'package:susu_gh/screens/deposits/Deposits.dart';
import 'package:susu_gh/screens/investments/Investments.dart';
import 'package:susu_gh/screens/savings/Savings.dart';
import 'package:susu_gh/screens/loans/Loan.dart';

class NavBar extends StatefulWidget {
  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _currentIndex = 0;

  List<Widget> pages = [
    Savings(),
    Deposits(),
    Investments(),
    Loan(),
  ];

  void onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages.elementAt(_currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        iconSize: 30,
        selectedFontSize: 15,
        unselectedFontSize: 15,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.attach_money),
            label: "Savings",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.payments_sharp),
            label: "Deposits",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance),
            label: "Investments",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sentiment_very_satisfied),
            label: "Loans",
          ),
        ],
        currentIndex: _currentIndex,
        onTap: onItemTapped,
      ),
    );
  }
}
