import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:susu_gh/components/constants.dart';
import 'package:susu_gh/models/transactions.dart';
import 'package:susu_gh/services/database.dart';

class SavingsDetail extends StatefulWidget {
  final DocumentSnapshot customer;
  final SavingsTransaction transaction;
  SavingsDetail({Key key, @required this.customer, this.transaction})
      : super(key: key);

  @override
  _SavingsDetailState createState() => _SavingsDetailState();
}

class _SavingsDetailState extends State<SavingsDetail> {
  double balance;
  String today = formatDate(DateTime.now(), [dd, "-", mm, "-", yyyy]);
  String time = formatDate(DateTime.now(), [HH, ":", nn]);
  String user,
      customDate,
      phone,
      location,
      profession,
      createdBy,
      currentAmount;

  List<SavingsTransaction> transactions;
  //bool sort;

  @override
  void initState() {
    //sort = false;
    transactions =
        SavingsTransaction.getTransactions(widget.customer['customer']);
    super.initState();
  }

  // onsortColumn(int index, bool ascending) {
  //   if (index == 0) {
  //     if (ascending) {
  //       transactions.sort((a, b) => a.date.compareTo(b.date));
  //     } else {
  //       transactions.sort((a, b) => b.date.compareTo(a.date));
  //     }
  //   }
  // }

  DataTable savingsTable() {
    return DataTable(
      columns: [
        DataColumn(
          label: Text(
            "TYPE",
            style: TextStyle(
                fontSize: 15, fontWeight: FontWeight.bold, color: customRed),
          ),
          numeric: false,
        ),
        DataColumn(
          numeric: false,
          label: Text(
            "AMOUNT",
            style: TextStyle(
                fontSize: 15, fontWeight: FontWeight.bold, color: customRed),
          ),
        ),
        DataColumn(
          label: Text(
            "AGENT",
            style: TextStyle(
                fontSize: 15, fontWeight: FontWeight.bold, color: customRed),
          ),
          numeric: false,
        ),
        DataColumn(
          label: Text(
            "DATE",
            style: TextStyle(
                fontSize: 15, fontWeight: FontWeight.bold, color: customRed),
          ),
          numeric: false,
        ),
        DataColumn(
          label: Text(
            "TIME",
            style: TextStyle(
                fontSize: 15, fontWeight: FontWeight.bold, color: customRed),
          ),
          numeric: false,
        ),
      ],
      rows: transactions
          .map(
            (transaction) => DataRow(
              cells: [
                DataCell(
                  Text(transaction.transactionType),
                ),
                DataCell(
                  Text('GHS ' + transaction.amount.toString()),
                ),
                DataCell(
                  Text(transaction.agent),
                ),
                DataCell(
                  Text(transaction.date),
                ),
                DataCell(
                  Text(transaction.time),
                ),
              ],
            ),
          )
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    customers
        .doc(widget.customer.id)
        .get()
        .then((DocumentSnapshot documentSnapshot) async {
      setState(() {
        currentAmount = documentSnapshot.data()['current'].toString();
        phone = documentSnapshot.data()['phone'];
        location = documentSnapshot.data()['location'];
        profession = documentSnapshot.data()['profession'];
        createdBy = documentSnapshot.data()['created by'];
      });
    });

    users.doc(uid).get().then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        user = documentSnapshot.data()['user'];
      }
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(widget.customer['customer'],
            style: TextStyle(color: Colors.black)),
        actions: [],
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.only(left: 16, top: 15, right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(phone.toString(), style: TextStyle(fontSize: 20)),
              Text(location.toString(), style: TextStyle(fontSize: 20)),
              Text(profession.toString(), style: TextStyle(fontSize: 20)),
              Text("Created by: " + createdBy.toString(),
                  style: TextStyle(fontSize: 20)),
              Text("Balance: GHS " + currentAmount.toString(),
                  style: TextStyle(fontSize: 20)),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () {
                      depositDialog(
                          context,
                          user,
                          widget.customer['customer'],
                          double.parse(currentAmount),
                          widget.customer['account type']);
                    },
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 18),
                          child: Column(
                            children: [
                              Icon(
                                Icons.send,
                                size: 40,
                                color: customGreen,
                              ),
                            ],
                          ),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: customGreen,
                              width: 2,
                            ),
                          ),
                        ),
                        Text(
                          "Deposit",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 15),
                  InkWell(
                    onTap: () {
                      withdrawalDialog(
                          context,
                          user,
                          widget.customer['customer'],
                          double.parse(currentAmount),
                          phone);
                    },
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          child: Column(
                            children: [
                              Icon(
                                Icons.credit_card,
                                size: 40,
                                color: customRed,
                              ),
                            ],
                          ),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: customRed,
                              width: 2,
                            ),
                          ),
                        ),
                        Text(
                          "Withdraw",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 15),
                  InkWell(
                    onTap: () {
                      info(
                          context,
                          widget.customer['customer'],
                          widget.customer['firstname'],
                          widget.customer['lastname'],
                          phone,
                          location);
                    },
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          child: Icon(
                            Icons.edit,
                            size: 40,
                            color: customBlue,
                          ),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: customBlue,
                              width: 2,
                            ),
                          ),
                        ),
                        Text(
                          "Edit Info",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Text(
                "Transactions",
                style: TextStyle(fontSize: 20),
              ),
              Expanded(
                child: ListView(
                  scrollDirection: Axis.vertical,
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: savingsTable(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  depositDialog(BuildContext context, currentAgent, customerName,
      double currentAmount, accountType) {
    GlobalKey<FormState> _formKey = GlobalKey();
    double depositAmount;
    String transactionType = 'Deposit';

    return showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Deposit"),
            content: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    keyboardType: TextInputType.number,
                    validator: (value) =>
                        value.isEmpty ? "This field is required" : null,
                    onChanged: (value) {
                      setState(() => depositAmount = double.parse(value));
                    },
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(
                          borderSide: BorderSide(color: customOrange)),
                      hintText: 'Enter Amount',
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("CANCEL", style: TextStyle(color: customRed)),
              ),
              TextButton(
                onPressed: () async {
                  print(currentAmount);
                  if (_formKey.currentState.validate()) {
                    widget.transaction.agent = currentAgent;
                    widget.transaction.customer = customerName;
                    widget.transaction.amount = depositAmount;
                    widget.transaction.transactionType = transactionType;
                    widget.transaction.date = today;
                    widget.transaction.time = time;
                    await savings.add(widget.transaction.savingsJson());
                    customers
                        .doc(widget.customer.id)
                        .update({'current': currentAmount + depositAmount})
                        .then((value) => print("User Updated"))
                        .catchError((error) =>
                            print("Failed to update user data: $error"));
                  }

                  Navigator.of(context).pop();
                },
                child: Text("DEPOSIT"),
              ),
            ],
          );
        });
  }

  withdrawalDialog(BuildContext context, currentAgent, customerName,
      double currentAmount, phoneNumber) {
    GlobalKey<FormState> _formKey = GlobalKey();
    double withdrawalAmount;
    String transactionType = 'Withdrawal';

    return showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Withdrawal"),
            content: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    keyboardType: TextInputType.number,
                    validator: (value) =>
                        value.isEmpty ? "This field is required" : null,
                    onChanged: (value) {
                      setState(() => withdrawalAmount = double.parse(value));
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter Amount',
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  "CANCEL",
                  style: TextStyle(color: Colors.red),
                ),
              ),
              TextButton(
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    if (currentAmount >= withdrawalAmount) {
                      widget.transaction.agent = currentAgent;
                      widget.transaction.customer = customerName;
                      widget.transaction.amount = withdrawalAmount;
                      widget.transaction.transactionType = transactionType;
                      widget.transaction.date = today;
                      widget.transaction.time = time;
                      customers
                          .doc(widget.customer.id)
                          .update({'current': currentAmount - withdrawalAmount})
                          .then((value) => print("User Updated"))
                          .catchError((error) =>
                              print("Failed to update user data: $error"));
                      await savings.add(widget.transaction.savingsJson());
                    }
                    Navigator.of(context).pop();
                  }
                },
                child: Text("WITHDRAW"),
              ),
            ],
          );
        });
  }

  info(BuildContext context, String customer, String firstname, String lastname,
      String phone, String location) {
    GlobalKey<FormState> _formKey = GlobalKey();
    return showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Edit Customer Info"),
            content: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      initialValue: firstname,
                      validator: (value) =>
                          value.isEmpty ? "This field is required" : null,
                      onChanged: (value) {
                        setState(() => firstname = value);
                      },
                      decoration: InputDecoration(
                        hintText: firstname,
                      ),
                    ),
                    TextFormField(
                      initialValue: lastname,
                      validator: (value) =>
                          value.isEmpty ? "This field is required" : null,
                      onChanged: (value) {
                        setState(() => lastname = value);
                      },
                      decoration: InputDecoration(
                        hintText: lastname,
                      ),
                    ),
                    TextFormField(
                      inputFormatters: [LengthLimitingTextInputFormatter(10)],
                      initialValue: phone,
                      keyboardType: TextInputType.number,
                      validator: (value) =>
                          value.isEmpty ? "This field is required" : null,
                      onChanged: (value) {
                        setState(() => phone = value);
                      },
                      decoration: InputDecoration(
                        hintText: phone,
                      ),
                    ),
                    TextFormField(
                      initialValue: location,
                      validator: (value) =>
                          value.isEmpty ? "This field is required" : null,
                      onChanged: (value) {
                        setState(() => location = value);
                      },
                      decoration: InputDecoration(
                        hintText: location,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  "CANCEL",
                  style: TextStyle(color: Colors.red),
                ),
              ),
              TextButton(
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    customers.doc(widget.customer.id).update({
                      'firstname': firstname,
                      'lastname': lastname,
                      'location': location,
                      'phone': phone,
                      'customer': firstname + " " + lastname,
                    });
                    Navigator.of(context).pop();
                  }
                },
                child: Text("UPDATE"),
              ),
            ],
          );
        });
  }
}
