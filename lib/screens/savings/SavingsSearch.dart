import 'package:flutter/material.dart';
import 'package:susu_gh/components/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:susu_gh/models/transactions.dart';
import 'package:susu_gh/services/database.dart';
import 'SavingsDetail.dart';
import 'package:susu_gh/models/customer.dart';
import 'package:susu_gh/screens/savings/AddSavings.dart';

class SavingsSearch extends StatefulWidget {
  @override
  _CustomersState createState() => _CustomersState();
}

class _CustomersState extends State<SavingsSearch> {
  String agent, userRole;

  navigateToDetail(DocumentSnapshot customer, newTransaction) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SavingsDetail(
                  customer: customer,
                  transaction: newTransaction,
                )));
  }

  TextEditingController _searchController = TextEditingController();

  List _allResults = [];
  Future resultsLoaded;
  List _resultsList = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    resultsLoaded = getCustomersSnapshots();
  }

  _onSearchChanged() {
    searchResultsList();
  }

  searchResultsList() {
    var showResults = [];
    if (_searchController.text != "") {
      for (var customerSnapshot in _allResults) {
        var firstName =
            Customer.fromSnapshot(customerSnapshot).firstName.toLowerCase();
        var lastName =
            Customer.fromSnapshot(customerSnapshot).lastName.toLowerCase();

        if (firstName.contains(_searchController.text.toLowerCase()) ||
            lastName.contains(_searchController.text.toLowerCase())) {
          showResults.add(customerSnapshot);
        }
      }
    } else {
      showResults = List.from(_allResults);
    }
    setState(() {
      _resultsList = showResults;
    });
  }

  getCustomersSnapshots() async {
    var data = await customers
        .where("account type", isEqualTo: "Savings Account")
        .orderBy("firstname")
        .get();
    setState(() {
      _allResults = data.docs;
    });
    searchResultsList();
    return "Done";
  }

  @override
  Widget build(BuildContext context) {
    Customer newCustomer = Customer(
        null, null, null, null, null, null, null, null, null, null, null);
    SavingsTransaction newTransaction = SavingsTransaction();
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "Savings Acounts",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        actions: [],
      ),
      body: Container(
        child: Column(
          children: [
            SizedBox(
              width: 300,
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.search,
                  ),
                  hintText: "Type customer's name here",
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _resultsList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    elevation: 5,
                    margin: EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 8,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      onTap: () {
                        navigateToDetail(_resultsList[index], newTransaction);
                      },
                      title: Text(_resultsList[index]['customer']),
                      subtitle: Text(
                          "Created by: ${_resultsList[index]['created by']}"),
                      trailing: Icon(Icons.arrow_forward_ios_outlined),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: customRed,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddSavings(customer: newCustomer)));
        },
        child: Icon(Icons.person_add),
      ),
    );
  }
}
