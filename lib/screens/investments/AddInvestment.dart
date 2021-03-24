import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:susu_gh/components/constants.dart';
import 'package:susu_gh/services/database.dart';

class AddInvestment extends StatefulWidget {
  @override
  _AddInvestmentState createState() => _AddInvestmentState();
}

class _AddInvestmentState extends State<AddInvestment> {
  GlobalKey<FormState> _formKey = GlobalKey();

  String date = formatDate(DateTime.now(), [d, '-', mm, '-', yyyy]);
  var user;
  int currentAmount = 0;

  List<String> gender = <String>["Male", "Female"];
  String genderType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                  Text("Add Customer", style: TextStyle(fontSize: 40)),
                  SizedBox(height: 10),
                  Theme(
                    child: TextFormField(
                      validator: (value) =>
                          value.isEmpty ? "This field is required" : null,
                      onChanged: (value) {},
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
                      onChanged: (value) {},
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
                      setState(() {});
                    },
                    isExpanded: false,
                    hint: Text("Select Gender"),
                  ),
                  SizedBox(height: 15),
                  Theme(
                    child: TextFormField(
                      validator: (value) =>
                          value.isEmpty ? "This field is required" : null,
                      onChanged: (value) {},
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
                      inputFormatters: [LengthLimitingTextInputFormatter(10)],
                      keyboardType: TextInputType.number,
                      validator: (value) =>
                          value.isEmpty ? "This field is required" : null,
                      onChanged: (value) {},
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
                      onChanged: (value) {},
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
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {}
                      },
                      style: ElevatedButton.styleFrom(
                        primary: customRed,
                        onPrimary: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          'Create Customer',
                          style: TextStyle(fontSize: 20),
                        ),
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
