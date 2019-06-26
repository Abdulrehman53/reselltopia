import 'package:flutter/material.dart';
import 'package:reselltopia/ProductsWidgets/ProductGridList.dart';

class LatestProducts extends StatefulWidget {
  static final id = 'latest_product';
  @override
  _LatestProductsState createState() => _LatestProductsState();
}

class _LatestProductsState extends State<LatestProducts> {
  @override
  Widget build(BuildContext context) {
    return new Container(
      child: GridList(),
    );
  }
}
