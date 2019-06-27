import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:reselltopia/contants.dart';
import 'package:reselltopia/pages/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'SignUpPage.dart';
import 'forgot_password.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GoogleSignIn googleSignIn = new GoogleSignIn();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  SharedPreferences sharedPreferences;
  bool isLoading, isLoggedIn;
  String email, password;
  AnimationController controller;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isSignedIn();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height / 3;
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Stack(
          children: <Widget>[
            Image.asset(
              'images/login_bg.jpeg',
              fit: BoxFit.fill,
              width: double.infinity,
              height: double.infinity,
            ),
//TODO:: make the logo show

            Container(
              color: Colors.black.withOpacity(0.7),
              width: double.infinity,
              height: double.infinity,
            ),

            Container(
                alignment: Alignment.topCenter,
                child: Image.asset(
                  'images/lg.png',
                  width: 280.0,
                  height: 240.0,
                )),
            Padding(
              padding: const EdgeInsets.only(top: 200),
              child: SizedBox(
                width: double.infinity,
                height: 160.0,
                child: Text(
                  'Reselltopia',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 50.0,
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.italic),
                  textAlign: TextAlign.center,
                  // or Alignment.topLeft
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 270.0),
                child: Center(
                  child: Form(
                      key: _formKey,
                      child: ListView(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 12.0),
                              child: Theme(
                                data: ThemeData(
                                    primaryColor: Colors.white,
                                    hintColor: Colors.white),
                                child: TextFormField(
                                  style: TextStyle(color: Colors.white),
                                  controller: _emailTextController,
                                  decoration: InputDecoration(
                                    filled: false,
                                    hintText: "Email",
                                    icon: Icon(
                                      Icons.email,
                                      color: Colors.white,
                                    ),
                                  ),
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
                                  onSaved: (val) {
                                    setState(() {
                                      email = val;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 12.0),
                              child: Theme(
                                data: ThemeData(
                                    primaryColor: Colors.white,
                                    hintColor: Colors.white),
                                child: TextFormField(
                                  style: TextStyle(color: Colors.white),
                                  obscureText: true,
                                  controller: _passwordTextController,
                                  decoration: InputDecoration(
                                    hintText: "Password",
                                    icon: Icon(
                                      Icons.lock_outline,
                                      color: Colors.white,
                                    ),
                                  ),
                                  onSaved: (value) {
                                    setState(() {
                                      password = value;
                                    });
                                  },
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return "The password field cannot be empty";
                                    } else if (value.length < 6) {
                                      return "the password has to be at least 6 characters long";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Material(
                                borderRadius: BorderRadius.circular(20.0),
                                color: Colors.white,
                                elevation: 0.0,
                                child: MaterialButton(
                                  onPressed: () async {
                                    final form = _formKey.currentState;
                                    if (form.validate()) {
                                      form.save();
                                      setState(() {
                                        isLoading = true;
                                      });
                                      try {
                                        final user = await firebaseAuth
                                            .signInWithEmailAndPassword(
                                                email: email,
                                                password: password);
                                        if (user != null) {
                                          Fluttertoast.showToast(
                                              msg: 'Logged in Successfully');
                                          await sharedPreferences.setString(
                                              id, user.uid);
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      HomePage()));
                                        } else {
                                          Fluttertoast.showToast(
                                              msg: 'Incorrect email/Password');
                                        }
                                      } catch (e) {
                                        Fluttertoast.showToast(
                                            msg: 'Incorrect email/Password');
                                      }
                                    }
                                    setState(() {
                                      isLoading = false;
                                    });
                                  },
                                  minWidth: MediaQuery.of(context).size.width,
                                  child: Text(
                                    "Login",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: APP_COLOR,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0),
                                  ),
                                )),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ForgotPasswordPage()));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Forgot Password ?",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
//                          Expanded(child: Container()),

                          Center(
                            child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SignUpPage()));
                                  },
                                  child: RichText(
                                      text: TextSpan(
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16.0),
                                          children: [
                                        TextSpan(
                                            style: TextStyle(fontSize: 16.0),
                                            text:
                                                "Don't have an account? Click here to"),
                                        TextSpan(
                                            text: " sign up!",
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold,
                                                color: const Color(0xffC9D300)))
                                      ])),
                                )
//                            Text("Dont't have an accout? click here to sign up!",textAlign: TextAlign.end, style: TextStyle(color: Colors.white,  fontWeight: FontWeight.w400, fontSize: 16.0),),
                                ),
                          ),
                        ],
                      )),
                ),
              ),
            ),

            Visibility(
              visible: isLoading ?? true,
              child: Center(
                child: Container(
                  alignment: Alignment.center,
                  color: Colors.white.withOpacity(0.9),
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void isSignedIn() async {
    setState(() {
      isLoading = true;
    });
    sharedPreferences = await SharedPreferences.getInstance();
    //isLoggedIn = await googleSignIn.isSignedIn();
    if (sharedPreferences.get(id) != null &&
        sharedPreferences.get(id).toString().length > 0) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  void handleLogin() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      isLoading = true;
    });
    GoogleSignInAccount signInAccount = await googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await signInAccount.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final FirebaseUser user =
        await firebaseAuth.signInWithCredential(credential);
    if (user != null) {
      final QuerySnapshot querySnapshot = await Firestore.instance
          .collection("user")
          .where("id", isEqualTo: user.uid)
          .getDocuments();
      final List<DocumentSnapshot> userList = querySnapshot.documents;
      if (userList.length == 0) {
        Firestore.instance.collection("user").document(user.uid).setData({
          id: user.uid,
          name: user.displayName,
          picture: user.photoUrl,
        });
        await sharedPreferences.setString(id, user.uid);
        await sharedPreferences.setString(id, user.displayName);
        await sharedPreferences.setString(id, user.photoUrl);
        Fluttertoast.showToast(msg: 'Logged in successfully');
        setState(() {
          isLoading = false;
        });
      } else {
        await sharedPreferences.setString(id, userList[0][id]);
        await sharedPreferences.setString(id, userList[0][name]);
        await sharedPreferences.setString(id, userList[0][picture]);
      }
    }
  }
}
