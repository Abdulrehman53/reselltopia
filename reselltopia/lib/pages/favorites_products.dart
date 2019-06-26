import 'package:flutter/material.dart';
import 'package:reselltopia/FavWidgets/FavProductGridList.dart';
import 'package:reselltopia/contants.dart';

class FavouriteProducts extends StatefulWidget {
  static final id = 'fav_product';
  @override
  _FavouriteProductsState createState() => _FavouriteProductsState();
}

class _FavouriteProductsState extends State<FavouriteProducts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: APP_COLOR,
        title: Text('Favourites'),
      ),
      body: GridList(
        searchText: "",
      ),
    );
  }
}
