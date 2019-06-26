import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:reselltopia/ProductDetailWidget/product_row_widget.dart';
import 'package:reselltopia/contants.dart';
import 'package:reselltopia/models/productsModel.dart';

class ProductDetail extends StatefulWidget {
  static final id = 'product_detail';
  final fireStore = Firestore.instance;
  ProductModel productModel;
  ProductDetail({this.productModel});
  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: APP_COLOR,
        title: Text('Product Detail'),
      ),
      body: new Container(
        child: ListView(
          children: <Widget>[
            Container(
              height: 300,
              child: GridTile(
                child: Hero(
                  tag: widget.productModel.id,
                  child: Container(
                    color: Colors.white,
                    child: Image.network(widget.productModel.imageLocation),
                  ),
                ),
                footer: Container(
                  color: Colors.white70,
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

                /*Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(
                        widget.productModel.name,
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        widget.productModel.price,
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        widget.productModel.oldPrice,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.lineThrough),
                      ),
                    ],
                  ),*/
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Padding(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: new RaisedButton(
                        child: new Text(
                          "Resell Price \$${widget.productModel.price}",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0),
                        ),
                        onPressed: () {},
                        color: APP_COLOR,
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0))),
                  ),
                  IconButton(
                    onPressed: () {
                      if (!widget.productModel.isFav) {
                        widget.productModel.isFav = true;
                        handleFAv(widget.productModel.isFav);
                      } else {
                        widget.productModel.isFav = false;
                        handleFAv(widget.productModel.isFav);
                      }
                      setState(() {});
                    },
                    icon: Icon(
                      widget.productModel.isFav
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: Colors.red,
                    ),
                  )
                ],
              ),
              padding: EdgeInsets.all(8.0),
            ),
            Divider(),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: ListTile(
                title: Text('Product Detail'),
                subtitle: Text(widget.productModel.description
                    // 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged'),
                    ),
              ),
            ),
            Divider(),
            ProductDetailRow(
              type: 'Product Name',
              name: widget.productModel.name,
            ),
            ProductDetailRow(
              type: 'Product Condition',
              name: widget.productModel.condition,
            ),
            Padding(
              padding: EdgeInsets.all(30.0),
              child: Container(
                width: 100.0,
                child: new RaisedButton(
                    child: new Text(
                      widget.productModel.isSaved ? "UnSave" : 'Save',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0),
                    ),
                    onPressed: () {
                      if (!widget.productModel.isSaved) {
                        widget.productModel.isSaved = true;
                        handleSav(widget.productModel.isSaved);
                      } else {
                        widget.productModel.isSaved = false;
                        handleSav(widget.productModel.isSaved);
                      }
                      setState(() {});
                    },
                    color: APP_COLOR,
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0))),
              ),
            )
          ],
        ),
      ),
    );
  }

  void handleFAv(bool isFav) {
    widget.fireStore
        .collection(PRODUCTS)
        .document(widget.productModel.id)
        .updateData({
      IS_FAVOURITE: isFav,
    });
  }

  void handleSav(bool isSave) {
    widget.fireStore
        .collection(PRODUCTS)
        .document(widget.productModel.id)
        .updateData({
      IS_SAVED: isSave,
    });
  }
}
