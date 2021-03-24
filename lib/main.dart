import 'dart:async';
import 'package:flutter/material.dart';
import 'package:susu_gh/components/navbar.dart';
import 'components/constants.dart';
import 'auth/Login.dart';
import 'services/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'models/user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<SusuUser>.value(
      value: Authentication().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "SusuGH",
        theme: ThemeData(
          primaryColor: customRed,
          focusColor: customRed,
          accentColor: customRed,
          fontFamily: 'Nunito',
          backgroundColor: backgroundColor,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Splash(),
      ),
    );
  }
}

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Authenticate()));
    });
    return Scaffold(
      body: Container(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(""),
                Text(
                  "SusuGH",
                  style: TextStyle(fontSize: 50),
                ),
                CircularProgressIndicator()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<SusuUser>(context);
    if (user == null) {
      return Login();
    } else {
      return NavBar();
    }
  }
}
