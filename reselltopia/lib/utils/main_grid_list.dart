import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:reselltopia/contants.dart';
import 'package:reselltopia/models/productsModel.dart';
import 'package:reselltopia/pages/product_detail.dart';

class MainGridList extends StatefulWidget {
  String searchText = "";
  MainGridList({this.searchText});
  bool isFirst = false;
  @override
  _MainGridListState createState() => _MainGridListState();
}

class _MainGridListState extends State<MainGridList> {
  final fireStore = Firestore.instance;
  List<ProductModel> productList = [];
  List<ProductModel> oldList = [];

  void getData() async {
    List<ProductModel> productLists = [];

    QuerySnapshot documents =
        await fireStore.collection(PRODUCTS).getDocuments();
    productList = [];
    oldList = [];
    for (var message in documents.documents) {
      try {
        ProductModel productModel = ProductModel();
        productModel.id = message.documentID;
        //print(message.data);
        productModel.name =
            message.data[NAME] == null ? "" : message.data[NAME];
        productModel.imageLocation =
            message.data[PICTURE] == null ? "" : message.data[PICTURE];

        productModel.price =
            message.data[PRICE] == null ? "" : message.data[PRICE];
        productModel.oldPrice =
            message.data[OLD_PRICE] == null ? "" : message.data[OLD_PRICE];
        productModel.description =
            message.data[DESCRIPTION] == null ? "" : message.data[DESCRIPTION];
        productModel.condition =
            message.data[CONDITION] == null ? "" : message.data[CONDITION];
        productModel.isFav = message.data[IS_FAVOURITE] == null
            ? ""
            : message.data[IS_FAVOURITE];
        productModel.isSaved =
            message.data[IS_SAVED] == null ? "" : message.data[IS_SAVED];
        print(productModel.name);
        //print(widget.searchText);
        if (widget.searchText.length > 0) {
          if (productModel.name.contains(widget.searchText))
            productList.add(productModel);
        } else {
          oldList.add(productModel);
          productList.add(productModel);
        }
        //productLists.add(productModel);
        setState(() {});
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.isFirst = true;
    getData();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    productList = [];
    oldList = [];
  }

  void handleSearch(String searchText) {
    List<ProductModel> filterList = [];
    for (var product in productList) {
      if (product.name.contains(searchText)) filterList.add(product);
    }
    productList = filterList;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (widget.searchText.length > 0) {
      handleSearch(widget.searchText);
    } else {
      productList = [];
      productList.addAll(oldList);
      setState(() {});
    }

    return Container(
      child: GridView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: productList.length,
          gridDelegate:
              new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (BuildContext cntxt, int index) {
            return SingleProduct(
              productModel: productList[index],
            );
          }),
    );
    /*child: GridView.builder(
          itemCount: productList.length,
          gridDelegate:
              new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (BuildContext cntxt, int index) {
            return SingleProduct(
              productModel: productList[index],
            );
          }),
    );*/
  }
}

class SingleProduct extends StatelessWidget {
  ProductModel productModel;
  SingleProduct({this.productModel});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130.0,
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ProductDetail(
                        productModel: productModel,
                      )));
        },
        child: Card(
          child: Hero(
            tag: productModel.id,
            child: Material(
              color: Colors.white,
              child: GridTile(
                footer: Container(
                  child: ListTile(
                    leading: Text(
                      '',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    title: Text(
                      "",
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.w500),
                    ),
                    subtitle: Text(
                      "",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.lineThrough),
                    ),
                  ),
                ),
                child: Image.network(
                  productModel.imageLocation == null
                      ? ""
                      : productModel.imageLocation,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
