import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:reselltopia/contants.dart';
import 'package:reselltopia/models/productsModel.dart';
import 'package:reselltopia/pages/product_detail.dart';

class GridList extends StatefulWidget {
  final String type;
  GridList({@required this.type});
  @override
  _GridListState createState() => _GridListState();
}

class _GridListState extends State<GridList> {
  final fireStore = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: StreamBuilder<QuerySnapshot>(
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: Text('No data available'),
          );
        }
        final messages = snapshot.data.documents;
        List<Text> widgets = [];
        List<ProductModel> productList = [];
        for (var message in messages) {
          ProductModel productModel = ProductModel();
          productModel.id = message.documentID;
          productModel.name =
              message.data[NAME] == null ? "" : message.data[NAME];
          productModel.type =
              message.data[TYPE] == null ? "" : message.data[TYPE];
          productModel.imageLocation =
              message.data[PICTURE] == null ? "" : message.data[PICTURE];

          productModel.price =
              message.data[PRICE] == null ? "" : message.data[PRICE];
          productModel.oldPrice =
              message.data[OLD_PRICE] == null ? "" : message.data[OLD_PRICE];
          productModel.description = message.data[DESCRIPTION] == null
              ? ""
              : message.data[DESCRIPTION];
          productModel.condition =
              message.data[CONDITION] == null ? "" : message.data[CONDITION];
          productModel.isFav = message.data[IS_FAVOURITE] == null
              ? ""
              : message.data[IS_FAVOURITE];
          //print(productModel.name);
          if (productModel.type == widget.type) {
            productList.add(productModel);
          }

          // print(productModel);
        }

        return GridView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: productList.length,
            gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemBuilder: (BuildContext cntxt, int index) {
              return SingleProduct(
                productModel: productList[index],
              );
            });
      },
      stream: fireStore.collection(PRODUCTS).snapshots(),
    ));
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
      height: 200.0,
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
                  color: Colors.white70,
                  child: ListTile(
                    leading: Text(
                      'Resell Price',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    title: Text(
                      "\$${productModel.price == null ? "" : productModel.price}",
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.w500),
                    ),
                    subtitle: Text(
                      "\$${productModel.oldPrice == null ? "" : productModel.oldPrice}",
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
