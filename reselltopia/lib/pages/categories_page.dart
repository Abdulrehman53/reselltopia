import 'package:flutter/material.dart';
import 'package:reselltopia/HomeWidgets/categoriesList.dart';
import 'package:reselltopia/HomeWidgets/slidebar.dart';
import 'package:reselltopia/contants.dart';

class Categories extends StatefulWidget {
  static final id = 'categories';
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: APP_COLOR,
        title: Text('Categories'),
      ),
      body: new Column(
        children: <Widget>[
          SlideBar(),
          new Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Categories',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: new Container(child: CategoriesList())),
          /* new Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Latest Products'),
          ),*/
          /*new Container(
            child: GridList(),
          )*/
        ],
      ),
    );
  }
}
