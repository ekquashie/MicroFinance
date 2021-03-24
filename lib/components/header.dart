import 'package:flutter/material.dart';
import 'constants.dart';

Card header(String date) => Card(
      margin: EdgeInsets.all(10.0),
      elevation: 1.0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(50.0))),
      child: Container(
          decoration: BoxDecoration(
              gradient: RadialGradient(colors: [customRed, customRed])),
          padding: EdgeInsets.all(5.0),
          // color: Color(0xFF015FFF),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(""),
                  Text("Transactions",
                      style: TextStyle(color: Colors.white, fontSize: 25)),
                  Text(""),
                ],
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Text(date,
                      style: TextStyle(color: Colors.white, fontSize: 20.0)),
                ),
              ),
            ],
          )),
    );
