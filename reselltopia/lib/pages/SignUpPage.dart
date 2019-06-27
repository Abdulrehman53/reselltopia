import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:reselltopia/contants.dart';
import 'package:reselltopia/models/UserModel.dart';
import 'package:reselltopia/pages/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login_page.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GoogleSignIn googleSignIn = new GoogleSignIn();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final _auth = FirebaseAuth.instance;
  String email;
  String password, fullName, mobile;
  SharedPreferences sharedPreferences;
  final _firestoreInstance = Firestore.instance;
  bool isLoading = false, isLoggedIn;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  User user = User();
  File _image;
  String picture;

  void _pickSaveImage(String userId) async {
    if (_image != null) {
      final String fileName = Random().nextInt(10000).toString() + '.png';
      final StorageReference storageRef =
          FirebaseStorage.instance.ref().child(fileName);
      final StorageUploadTask uploadTask = storageRef.putFile(
        File(_image.path),
        StorageMetadata(
          contentType: 'image' + '/' + '.png',
        ),
      );
      picture = await (await uploadTask.onComplete).ref.getDownloadURL();
    }
    await sharedPreferences.setString(id, userId);
    _firestoreInstance.collection(USER_KEY).document(userId).setData({
      EMAIL: email,
      FULL_NAME: fullName,
      PHONE: mobile,
      USER_ID: userId,
      PICTURE: picture,
    });
  }

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
    });
  }
  /* Future<void> retrieveLostData() async {
    final RetrieveLostDataResponse response =
    await ImagePicker.retrieveLostData();
    if (response == null) {
      return;
    }
    if (response.file != null) {
      setState(() {
        if (response.type == RetrieveType.video) {
          _handleVideo(response.file);
        } else {
          _handleImage(response.file);
        }
      });
    } else {
      _handleError(response.exception);
    }
  }*/

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  void init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height / 3;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Text(
          'SignUp',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Stack(
          children: <Widget>[
            Image.asset(
              'images/girl.jpeg',
              fit: BoxFit.fill,
              width: double.infinity,
              height: double.infinity,
            ),
//TODO:: make the logo show

            Container(
              color: Colors.white,
              width: double.infinity,
              height: double.infinity,
            ),

            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: SizedBox(
                width: double.infinity,
                height: 100.0,
                child: Container(
                  child: Center(
                    child: InkWell(
                      onTap: () {
                        getImage();
                      },
                      child: Container(
                          height: 100.0,
                          width: 100.0,
                          child: Container(
                              alignment: Alignment.center,
                              decoration: new BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: new DecorationImage(
                                    fit: BoxFit.fill,
                                    image: _image == null
                                        ? AssetImage(
                                            'images/signup_page_9_profile.png',
                                          )
                                        : FileImage(
                                            _image,
                                          ),
                                  )))),
                    ),
                  ),
                ),
              ),
            ),

            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 140.0),
                child: Center(
                  child: Form(
                      key: _formKey,
                      child: ListView(
                        children: <Widget>[
                          /*InkWell(
                            onTap: () {
                              //print("image");
                              //getImage();
                              getImage();
                            },
                            child: new Container(
                                width: 190.0,
                                height: 190.0,
                                decoration: new BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: new DecorationImage(
                                      fit: BoxFit.fill,
                                      image:
                                          new AssetImage('images/chris.png'),
                                    ))),

                            */ /*new CircleAvatar(
                                radius: 20.0,
                                child: _image == null
                                    ? Image.asset(
                                        'images/signup_page_9_profile.png',
                                        height: 100.0,
                                        width: 100.0,
                                      )
                                    : Image.file(
                                        _image,
                                        height: 100.0,
                                        width: 100.0,
                                        fit: BoxFit.cover,
                                      ),
                              )*/ /*
                            */ /*new Container(
                              width: 120.0,
                              height: 150.0,
                              alignment: Alignment.center,
                              decoration: new BoxDecoration(
                                shape: BoxShape.circle,
                                image: new DecorationImage(
                                    fit: BoxFit.fitHeight,
                                    image: _image == null
                                        ? new AssetImage(
                                            'images/signup_page_9_profile.png')
                                        : new FileImage(_image)),
                              ),
                            ),*/ /*
                          ),*/
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 12.0),
                              child: Theme(
                                data: ThemeData(
                                    primaryColor: Colors.black,
                                    hintColor: Colors.grey),
                                child: TextFormField(
                                  style: TextStyle(color: Colors.black),
                                  //controller: _passwordTextController,
                                  decoration: InputDecoration(
                                    hintText: "Full Name",
                                    icon: Icon(
                                      Icons.person,
                                      color: Colors.black,
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return "The Full Name field cannot be empty";
                                    }
                                  },
                                  onSaved: (val) {
                                    setState(() {
                                      fullName = val;
                                      // user.setName = val;
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
                                    primaryColor: Colors.black,
                                    hintColor: Colors.grey),
                                child: TextFormField(
                                  keyboardType: TextInputType.phone,
                                  style: TextStyle(color: Colors.black),
                                  //controller: _passwordTextController,
                                  decoration: InputDecoration(
                                    hintText: "Mobile",
                                    icon: Icon(
                                      Icons.phone,
                                      color: Colors.black,
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return "The Mobile field cannot be empty";
                                    }
                                  },
                                  onSaved: (val) {
                                    setState(() {
                                      mobile = val;
                                      //user.phone = val;
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
                                    primaryColor: Colors.black,
                                    hintColor: Colors.grey),
                                child: TextFormField(
                                  style: TextStyle(color: Colors.black),
                                  controller: _emailTextController,
                                  decoration: InputDecoration(
                                    filled: false,
                                    hintText: "Email",
                                    icon: Icon(
                                      Icons.email,
                                      color: Colors.black,
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
                                      // user.email = val;
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
                                    primaryColor: Colors.black,
                                    hintColor: Colors.grey),
                                child: TextFormField(
                                  style: TextStyle(color: Colors.black),
                                  obscureText: true,
                                  controller: _passwordTextController,
                                  decoration: InputDecoration(
                                    hintText: "Password",
                                    icon: Icon(
                                      Icons.lock_outline,
                                      color: Colors.black,
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return "The password field cannot be empty";
                                    } else if (value.length < 6) {
                                      return "the password has to be at least 6 characters long";
                                    }
                                    return null;
                                  },
                                  onSaved: (val) {
                                    setState(() {
                                      password = val;
                                      //user.password = val;
                                      print(val);
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
                                    primaryColor: Colors.black,
                                    hintColor: Colors.grey),
                                child: TextFormField(
                                  style: TextStyle(color: Colors.black),
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    hintText: "Confirm Password",
                                    icon: Icon(
                                      Icons.lock_outline,
                                      color: Colors.black,
                                    ),
                                  ),
                                  onSaved: (val) {
                                    setState(() {});
                                  },
                                  validator: (value) {
                                    //print("abdul" + user.password);
                                    // print("djfhdsjgkjhg");
                                    if (value.isEmpty) {
                                      return "The password field cannot be empty";
                                    }
                                    /*else if (!identical(
                                        value.toString(), password)) {
                                      return "Password and Confirm Password Mismatched";
                                    }*/
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
                                color: Color(0xffC9D300),
                                elevation: 5.0,
                                child: MaterialButton(
                                  onPressed: () async {
                                    final form = _formKey.currentState;
                                    if (form.validate()) {
                                      form.save();

                                      setState(() {
                                        isLoading = true;
                                      });
                                      print(email);
                                      print(password);
                                      try {
                                        final newUser = await _auth
                                            .createUserWithEmailAndPassword(
                                                email: email,
                                                password: password);

                                        if (newUser != null) {
                                          _pickSaveImage(newUser.uid);
                                          Fluttertoast.showToast(
                                              msg: 'Sign up Successfully');

                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      HomePage()));
                                        } else {
                                          Fluttertoast.showToast(
                                              msg: 'Email Already Exist');
                                        }
                                      } catch (e) {
                                        Fluttertoast.showToast(
                                            msg: 'Email Already Exist');
                                        print(e);
                                      }
                                      setState(() {
                                        isLoading = false;
                                      });
                                    }
                                  },
                                  minWidth: MediaQuery.of(context).size.width,
                                  child: Text(
                                    "Create",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0),
                                  ),
                                )),
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
                                            builder: (context) => LoginPage()));
                                  },
                                  child: RichText(
                                      text: TextSpan(
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16.0),
                                          children: [
                                        TextSpan(
                                            style: TextStyle(fontSize: 16.0),
                                            text: "Already a member"),
                                        TextSpan(
                                            text: " sign in!",
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold,
                                                color: const Color(0xffC9D300)))
                                      ])),
                                )
//                            Text("Dont't have an accout? click here to sign up!",textAlign: TextAlign.end, style: TextStyle(color: Colors.black,  fontWeight: FontWeight.w400, fontSize: 16.0),),
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
                  color: Colors.black.withOpacity(0.9),
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
}
