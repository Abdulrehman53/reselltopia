import 'package:flutter/material.dart';
import 'package:reselltopia/pages/categories_page.dart';
import 'package:reselltopia/pages/favorites_products.dart';
import 'package:reselltopia/pages/login_page.dart';
import 'package:reselltopia/pages/product_detail.dart';
import 'package:reselltopia/pages/saved_products.dart';
import 'package:reselltopia/pages/serach_products.dart';

void main() => runApp(new MaterialApp(
      // theme: ThemeData(primaryColor: APP_COLOR),
      debugShowCheckedModeBanner: false,
      initialRoute: 'home',
      home: LoginPage(),
      routes: {
        'home': (context) => LoginPage(),
        ProductDetail.id: (context) => ProductDetail(),
        FavouriteProducts.id: (context) => FavouriteProducts(),
        Categories.id: (context) => Categories(),
        SearchProducts.id: (context) => SearchProducts(),
        SavedProducts.id: (context) => SavedProducts(),
      },
    ));
