import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reselltopia/contants.dart';
import 'package:reselltopia/models/UserModel.dart';
import 'package:reselltopia/pages/categories_page.dart';
import 'package:reselltopia/pages/favorites_products.dart';
import 'package:reselltopia/pages/login_page.dart';
import 'package:reselltopia/pages/main_page.dart';
import 'package:reselltopia/pages/saved_products.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'serach_products.dart';

class HomePage extends StatefulWidget {
  static final id = 'categories';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String fullName, email;
  final firestore = Firestore.instance;
  final firebaseAuth = FirebaseAuth.instance;
  SharedPreferences sharedPreferences;
  User user = User();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //getDate();
  }

  void getDate() async {
    sharedPreferences = await SharedPreferences.getInstance();
    final QuerySnapshot querySnapshot = await firestore
        .collection(USER_KEY)
        .where(USER_ID, isEqualTo: sharedPreferences.get(id))
        .getDocuments();
    final List<DocumentSnapshot> userList = querySnapshot.documents;
    if (userList.length > 0) {
      for (var document in userList) {
        email = document.data[EMAIL].toString();
        fullName = document.data[FULL_NAME].toString();
        //print(email);
        //print(fullName);
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    getDate();
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: APP_COLOR,
        title: Text('Reselltopia'),
        /*actions: <Widget>[
          new IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: null)
        ],*/
      ),
      drawer: new Drawer(
        elevation: 16.0,
        child: ListView(
          children: <Widget>[
            //header
            new UserAccountsDrawerHeader(
              accountName: Text(fullName == null ? "" : fullName),
              accountEmail: Text(email == null ? "" : email),
              currentAccountPicture: new GestureDetector(
                child: new Container(
                    width: 190.0,
                    height: 190.0,
                    decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        image: new DecorationImage(
                          fit: BoxFit.fill,
                          image: new AssetImage('images/chris.png'),
                        ))),
              ),
              decoration: new BoxDecoration(color: APP_COLOR),
            ),

            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: ListTile(
                title: Text(latest),
                leading: Icon(
                  Icons.home,
                  color: APP_COLOR,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, Categories.id);
              },
              child: ListTile(
                title: Text(categories),
                leading: Icon(
                  Icons.category,
                  color: APP_COLOR,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, FavouriteProducts.id);
              },
              child: ListTile(
                title: Text(favourits),
                leading: Icon(
                  Icons.favorite,
                  color: APP_COLOR,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, SavedProducts.id);
              },
              child: ListTile(
                title: Text(saved),
                leading: Icon(
                  Icons.save,
                  color: APP_COLOR,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, SearchProducts.id);
              },
              child: ListTile(
                title: Text('Search'),
                leading: Icon(
                  Icons.search,
                  color: APP_COLOR,
                ),
              ),
            ),
            Divider(),

            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text(about),
                leading: Icon(
                  Icons.help,
                  color: Colors.red,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                sharedPreferences.setString(id, '');
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              },
              child: ListTile(
                title: Text(logout),
                leading: Icon(
                  Icons.power_settings_new,
                  color: Colors.red,
                ),
              ),
            ),
          ],
        ),
      ),
      body: MainPage(),
    );
  }
}
