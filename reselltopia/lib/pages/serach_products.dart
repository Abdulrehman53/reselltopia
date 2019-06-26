import 'package:flutter/material.dart';
import 'package:reselltopia/utils/search_grid.dart';

class SearchProducts extends StatefulWidget {
  static final id = 'search_product';

  @override
  _SearchProductsState createState() => _SearchProductsState();
}

class _SearchProductsState extends State<SearchProducts> {
  String searchText = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Products'),
      ),
      body: new Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) {
                  print(value);
                  searchText = value;
                  setState(() {});
                },
                decoration: InputDecoration(
                  labelText: "Search",
                  hintText: "Search",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(25.0),
                    ),
                  ),
                ),
              ),
            ),
            GridList(searchText: searchText),
          ],
        ),
      ),
    );
  }
}
