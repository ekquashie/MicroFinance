import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:susu_gh/components/constants.dart';
import 'package:susu_gh/screens/agent/AddAgent.dart';
import 'package:susu_gh/services/database.dart';

class Checker extends StatefulWidget {
  @override
  _CheckerState createState() => _CheckerState();
}

class _CheckerState extends State<Checker> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<DocumentSnapshot>(
        stream: users.doc(uid).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          }
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Text("Loading...");
            default:
              return checkRole(snapshot.data);
          }
        },
      ),
    );
  }

  checkRole(DocumentSnapshot snapshot) {
    if (snapshot.data()['isAdmin'] == true) {
      return Agents();
    } else {
      return Center(child: Text("Admins only!"));
    }
  }
}

class Agents extends StatefulWidget {
  @override
  _AgentsState createState() => _AgentsState();
}

GlobalKey<FormState> _formKey = GlobalKey();
Stream getUsers = users.where("isAdmin", isEqualTo: false).snapshots();
String firstName, lastName, number, agentUid;

class _AgentsState extends State<Agents> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.black),
          title: Text(
            "Agents",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white),
      body: Column(
        children: [
          StreamBuilder<QuerySnapshot>(
            stream: getUsers,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text("Could not find agents");
              }
              if (!snapshot.hasData ||
                  snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.data.docs.length == 0) {
                return Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Registered Agents will appear here.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                );
              }
              return Expanded(
                child: SizedBox(
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    children:
                        snapshot.data.docs.map((DocumentSnapshot document) {
                      return Card(
                        elevation: 5,
                        margin: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 8,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: ListTile(
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                          title: Text("${document.data()['user']}"),
                          trailing: InkWell(
                            onTap: () {
                              agentUid = document.id;
                              agentInfo(context, document.data()['firstname'],
                                  document.data()['lastname'], agentUid);
                            },
                            child: Icon(
                              Icons.edit,
                              color: customBlue,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddAgent()));
        },
        child: Icon(Icons.person_add),
      ),
    );
  }

  agentInfo(BuildContext context, String firstName, String lastName,
      String agentUid) {
    return showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Update Agent Info"),
            content: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    TextFormField(
                      initialValue: firstName,
                      validator: (value) =>
                          value.isEmpty ? "This field is required" : null,
                      onChanged: (value) {
                        setState(() {
                          firstName = value;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: "Firstname",
                      ),
                    ),
                    TextFormField(
                      initialValue: lastName,
                      validator: (value) =>
                          value.isEmpty ? "This field is required" : null,
                      onChanged: (value) {
                        setState(() {
                          firstName = value;
                        });
                      },
                      decoration: InputDecoration(hintText: "LastName"),
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
                  child: Text("CANCEL", style: TextStyle(color: customRed))),
              TextButton(
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    users
                        .doc(agentUid)
                        .update({
                          'firstname': firstName,
                          'lastname': lastName,
                          'user': firstName + " " + lastName,
                        })
                        .then((info) {})
                        .catchError(
                            (error) => print("Failed to update agent info"));
                    Navigator.of(context).pop();
                  }
                },
                child: Text(
                  "UPDATE",
                ),
              ),
            ],
          );
        });
  }
}
