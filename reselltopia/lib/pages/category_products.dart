import 'package:flutter/material.dart';
import 'package:reselltopia/utils/category_products_grid.dart';

class CategoryProducts extends StatefulWidget {
  static final id = 'search_product';
  String type;
  CategoryProducts({this.type});

  @override
  _CategoryProductsState createState() => _CategoryProductsState();
}

class _CategoryProductsState extends State<CategoryProducts> {
  String searchText = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
      ),
      body: new Container(
        child: Column(
          children: <Widget>[
            GridList(type: widget.type),
          ],
        ),
      ),
    );
  }
}
