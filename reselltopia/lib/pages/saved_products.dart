import 'package:flutter/material.dart';
import 'package:reselltopia/contants.dart';
import 'package:reselltopia/utils/saved_grid.dart';

class SavedProducts extends StatefulWidget {
  static final id = 'sav_product';
  @override
  _SavedProductsState createState() => _SavedProductsState();
}

class _SavedProductsState extends State<SavedProducts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: APP_COLOR,
        title: Text('My Saved'),
      ),
      body: GridList(
        searchText: "",
      ),
    );
  }
}
