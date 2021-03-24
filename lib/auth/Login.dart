import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:susu_gh/components/constants.dart';
import 'package:susu_gh/services/auth.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  ProgressDialog progressDialog;
  GlobalKey<FormState> _formKey = GlobalKey();
  String email = '', password = '', error = '';
  final Authentication _auth = Authentication();

  @override
  Widget build(BuildContext context) {
    progressDialog = ProgressDialog(context, isDismissible: false);
    progressDialog.style(message: 'Logging in');
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Theme(
                  child: TextFormField(
                    validator: (value) =>
                        value.isEmpty ? 'Enter a valid email' : null,
                    onChanged: (value) {
                      setState(() => email = value);
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(50.0),
                        ),
                      ),
                      hintText: "Email",
                      prefixIcon: Icon(Icons.email),
                    ),
                  ),
                  data: Theme.of(context).copyWith(primaryColor: customRed),
                ),
                SizedBox(height: 20),
                Theme(
                    child: TextFormField(
                      obscureText: true,
                      validator: (value) =>
                          value.isEmpty ? 'Enter a valid password' : null,
                      onChanged: (value) {
                        setState(() => password = value);
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(50.0),
                          ),
                        ),
                        hintText: "Password",
                        prefixIcon: Icon(Icons.lock),
                      ),
                    ),
                    data: Theme.of(context).copyWith(primaryColor: customRed)),
                SizedBox(height: 20),
                ButtonTheme(
                  minWidth: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        progressDialog.show();
                        dynamic result =
                            await _auth.signInEmailAndPass(email, password);
                        if (result != null) {
                          progressDialog.hide();
                        }
                        if (result == null) {
                          setState(() => error = 'Invalid Credentials');
                          progressDialog.hide();
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: customRed,
                      onPrimary: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Login',
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
    );
  }
}
