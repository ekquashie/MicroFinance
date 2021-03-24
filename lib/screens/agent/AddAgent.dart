import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:susu_gh/components/constants.dart';
import 'package:susu_gh/services/database.dart';

class AddAgent extends StatefulWidget {
  @override
  _AddAgentState createState() => _AddAgentState();
}

class _AddAgentState extends State<AddAgent> {
  ProgressDialog progressDialog;
  GlobalKey<FormState> _formKey = GlobalKey();
  String email = '',
      password = '',
      error = '',
      firstName,
      lastName,
      phone,
      idType,
      idNumber;

  List<String> id = <String>["NHIS", "Voter's ID", "National ID"];

  @override
  Widget build(BuildContext context) {
    progressDialog = ProgressDialog(context, isDismissible: false);
    progressDialog.style(message: 'Registering agent');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
              child: Column(
                children: [
                  Text("New Agent", style: TextStyle(fontSize: 40)),
                  SizedBox(height: 10),
                  Theme(
                    child: TextFormField(
                      validator: (value) =>
                          value.isEmpty ? "This field is required" : null,
                      onChanged: (value) {
                        setState(() => firstName = value);
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
                        setState(() => lastName = value);
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
                  SizedBox(height: 15),
                  Theme(
                    child: TextFormField(
                      inputFormatters: [LengthLimitingTextInputFormatter(10)],
                      validator: (value) =>
                          value.isEmpty ? "This field is required" : null,
                      onChanged: (value) {
                        setState(() => phone = value);
                      },
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: customRed, width: 2)),
                        border: OutlineInputBorder(),
                        hintText: "Phone Number",
                        prefixIcon: Icon(
                          Icons.phone,
                        ),
                      ),
                    ),
                    data: Theme.of(context).copyWith(
                      primaryColor: customRed,
                    ),
                  ),
                  DropdownButtonFormField(
                    items: id
                        .map((value) => DropdownMenuItem(
                              child: Text(value),
                              value: value,
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        idType = value;
                      });
                    },
                    value: idType,
                    isExpanded: false,
                    hint: Text("ID Type"),
                  ),
                  SizedBox(height: 15),
                  Theme(
                    child: TextFormField(
                      validator: (value) =>
                          value.isEmpty ? "This field is required" : null,
                      onChanged: (value) {
                        setState(() => idNumber = value);
                      },
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: customRed, width: 2)),
                        border: OutlineInputBorder(),
                        hintText: "ID Number",
                        prefixIcon: Icon(Icons.badge),
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
                        setState(() => email = value);
                      },
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: customRed, width: 2)),
                        border: OutlineInputBorder(),
                        hintText: "Email",
                        prefixIcon: Icon(
                          Icons.email,
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
                      validator: (value) => value.length < 6
                          ? "Password must be 6 characters long"
                          : null,
                      onChanged: (value) {
                        setState(() => password = value);
                      },
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: customRed, width: 2)),
                        border: OutlineInputBorder(),
                        hintText: "Password",
                        prefixIcon: Icon(Icons.lock),
                      ),
                    ),
                    data: Theme.of(context).copyWith(primaryColor: customRed),
                  ),
                  SizedBox(height: 15),
                  ButtonTheme(
                    minWidth: double.infinity,
                    child: RaisedButton(
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                      onPressed: () async {
                        if (_formKey.currentState.validate() &&
                            idType != null) {
                          _formKey.currentState.reset();
                          dynamic result = registerAgent(email, password,
                              idType, firstName, lastName, phone, idNumber);
                          if (result == null) {
                            setState(() {
                              error = "Could not create agent";
                            });
                          }
                        }
                      },
                      child: Text(
                        'Create Agent',
                        style: TextStyle(fontSize: 20),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                      color: customRed,
                      textColor: Colors.white,
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

  agentAlert(BuildContext context) {
    return showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Agent created!"),
            actions: [
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Okay"))
            ],
          );
        });
  }
}
