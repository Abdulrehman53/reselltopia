import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  String email;
  bool isShowing = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Forgot Password',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: ModalProgressHUD(
        inAsyncCall: isShowing,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Form(
                key: _formKey,
                child: Theme(
                  data: ThemeData(
                      primaryColor: Colors.black, hintColor: Colors.grey),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                          icon: Icon(
                            Icons.email,
                            color: Colors.black,
                          ),
                          filled: false,
                          hintText: 'Email'),
                      validator: (value) {
                        if (value.isEmpty) {
                          Pattern pattern =
                              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                          RegExp regex = new RegExp(pattern);
                          if (!regex.hasMatch(value))
                            return 'Please make sure your email address is valid';
                          else
                            return null;
                        }
                      },
                      onSaved: (value) {
                        email = value;
                        setState(() {});
                      },
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Material(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Color(0xffC9D300),
                  elevation: 5.0,
                  child: MaterialButton(
                    minWidth: MediaQuery.of(context).size.width,
                    onPressed: () async {
                      final formState = _formKey.currentState;
                      if (formState.validate()) {
                        formState.save();
                        try {
                          isShowing = true;
                          setState(() {});
                          await _auth.sendPasswordResetEmail(email: email);
                          Fluttertoast.showToast(
                              msg:
                                  "Reset Password link is sent to your email address");
                        } catch (e) {
                          Fluttertoast.showToast(msg: "Email doesn't Exist");
                        }
                        isShowing = false;
                        setState(() {});
                      }
                    },
                    child: Text(
                      "Reset Password",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
