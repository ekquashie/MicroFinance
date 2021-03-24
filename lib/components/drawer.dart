import 'package:flutter/material.dart';
import 'constants.dart';
import 'package:susu_gh/services/auth.dart';
import 'package:susu_gh/screens/agent/Agents.dart';
import 'package:susu_gh/screens/admin/Dashboard.dart';
import 'package:susu_gh/screens/admin/reports/Reports.dart';
import 'package:susu_gh/screens/admin/Settings.dart';

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  Authentication _auth = Authentication();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160.0,
      child: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 20.0),
            ),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Dashboard()));
              },
              child: buildMenuItem(Icons.bar_chart, "DASHBOARD",
                  opacity: 1.0, color: customRed),
            ),
            Divider(),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Reports()));
              },
              child: buildMenuItem(Icons.receipt, "REPORTS",
                  opacity: 1.0, color: customRed),
            ),
            Divider(),
            InkWell(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Agents()));
              },
              child: buildMenuItem(Icons.people, "AGENTS",
                  opacity: 1.0, color: customRed),
            ),
            Divider(),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Settings()));
              },
              child: buildMenuItem(Icons.settings, "SETTINGS",
                  opacity: 1.0, color: customRed),
            ),
            Divider(),
            InkWell(
              onTap: () {
                return showDialog(
                    barrierDismissible: true,
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text("Logout?"),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                "CANCEL",
                                style: TextStyle(color: Colors.red),
                              )),
                          TextButton(
                              onPressed: () {
                                _auth.signOut();
                              },
                              child: Text("YES")),
                        ],
                      );
                    });
              },
              child: buildMenuItem(Icons.power_settings_new_rounded, "LOGOUT",
                  opacity: 1.0, color: customRed),
            ),
          ],
        ),
      ),
    );
  }

  Opacity buildMenuItem(IconData icon, String title,
      {double opacity = 0.3, Color color = Colors.black}) {
    return Opacity(
      opacity: opacity,
      child: Center(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20.0,
            ),
            Icon(
              icon,
              size: 50.0,
              color: color,
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(title,
                style: TextStyle(
                    fontWeight: FontWeight.w500, fontSize: 15.0, color: color)),
            SizedBox(
              height: 10.0,
            ),
          ],
        ),
      ),
    );
  }
}
