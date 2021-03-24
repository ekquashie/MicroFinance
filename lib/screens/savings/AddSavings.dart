import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:susu_gh/components/constants.dart';
import 'package:susu_gh/services/database.dart';
import 'package:susu_gh/models/customer.dart';

class AddSavings extends StatefulWidget {
  final Customer customer;
  AddSavings({Key key, @required this.customer}) : super(key: key);
  @override
  _AddSavingsState createState() => _AddSavingsState();
}

class _AddSavingsState extends State<AddSavings> {
  GlobalKey<FormState> _formKey = GlobalKey();
  String date = formatDate(DateTime.now(), [dd, '-', mm, '-', yyyy]);
  var user;
  double currentAmount = 0.0;
  List<String> gender = <String>["Male", "Female"];
  String genderType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Add Savings Account",
              style: TextStyle(color: Colors.black)),
          centerTitle: true,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black)),
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              child: Column(
                children: [
                  StreamBuilder<DocumentSnapshot>(
                    stream: users.doc(uid).snapshots(),
                    builder: (context, snapshot) {
                      user = snapshot.data['user'];
                      return Text("");
                    },
                  ),
                  Theme(
                    child: TextFormField(
                      validator: (value) =>
                          value.isEmpty ? "This field is required" : null,
                      onChanged: (value) {
                        setState(() => widget.customer.firstName = value);
                      },
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: customRed, width: 2)),
                        border: OutlineInputBorder(),
                        hintText: "First Name",
                        prefixIcon: Icon(
                          Icons.person,
                        ),
                      ),
                    ),
                    data: Theme.of(context).copyWith(
                      primaryColor: customRed,
                    ),
                  ),
                  SizedBox(height: 15),
                  Theme(
                    child: TextFormField(
                      validator: (value) =>
                          value.isEmpty ? "This field is required" : null,
                      onChanged: (value) {
                        setState(() => widget.customer.lastName = value);
                      },
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: customRed, width: 2)),
                        border: OutlineInputBorder(),
                        hintText: "Last Name",
                        prefixIcon: Icon(
                          Icons.people,
                        ),
                      ),
                    ),
                    data: Theme.of(context).copyWith(
                      primaryColor: customRed,
                    ),
                  ),
                  DropdownButtonFormField(
                    items: gender
                        .map((value) => DropdownMenuItem(
                              child: Text(value),
                              value: value,
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        widget.customer.gender = value;
                      });
                    },
                    value: widget.customer.gender,
                    isExpanded: false,
                    hint: Text("Select Gender"),
                  ),
                  SizedBox(height: 15),
                  Theme(
                    child: TextFormField(
                      validator: (value) =>
                          value.isEmpty ? "This field is required" : null,
                      onChanged: (value) {
                        setState(() => widget.customer.profession = value);
                      },
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: customRed, width: 2)),
                        border: OutlineInputBorder(),
                        hintText: "Profession",
                        prefixIcon: Icon(Icons.person),
                      ),
                    ),
                    data: Theme.of(context).copyWith(primaryColor: customRed),
                  ),
                  SizedBox(height: 15),
                  Theme(
                    child: TextFormField(
                      validator: (value) =>
                          value.isEmpty ? "This field is required" : null,
                      onChanged: (value) {
                        setState(() => widget.customer.nationality = value);
                      },
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: customRed, width: 2)),
                        border: OutlineInputBorder(),
                        hintText: "Nationality",
                        prefixIcon: Icon(Icons.badge),
                      ),
                    ),
                    data: Theme.of(context).copyWith(primaryColor: customRed),
                  ),
                  SizedBox(height: 15),
                  Theme(
                    child: TextFormField(
                      inputFormatters: [LengthLimitingTextInputFormatter(10)],
                      keyboardType: TextInputType.number,
                      validator: (value) =>
                          value.isEmpty ? "This field is required" : null,
                      onChanged: (value) {
                        setState(() => widget.customer.phone = value);
                      },
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: customRed, width: 2)),
                        border: OutlineInputBorder(),
                        hintText: "Phone number",
                        prefixIcon: Icon(
                          Icons.phone,
                        ),
                      ),
                    ),
                    data: Theme.of(context).copyWith(
                      primaryColor: customRed,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Theme(
                    child: TextFormField(
                      validator: (value) =>
                          value.isEmpty ? "This field is required" : null,
                      onChanged: (value) {
                        setState(() => widget.customer.location = value);
                      },
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: customRed, width: 2)),
                        border: OutlineInputBorder(),
                        hintText: "Location",
                        prefixIcon: Icon(Icons.location_on),
                      ),
                    ),
                    data: Theme.of(context).copyWith(primaryColor: customRed),
                  ),
                  SizedBox(height: 15),
                  ButtonTheme(
                    minWidth: double.infinity,
                    // ignore: deprecated_member_use
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          widget.customer.currentAmount = currentAmount;
                          widget.customer.user = user;
                          widget.customer.date = date;
                          widget.customer.accountType = 'Savings Account';
                          await customers.add(widget.customer.customerJson());
                          _formKey.currentState.reset();
                          customerAlert(context);
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          'Create Account',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: customRed,
                        onPrimary: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  customerAlert(BuildContext context) {
    return showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Customer created!"),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("OKAY"))
            ],
          );
        });
  }
}
