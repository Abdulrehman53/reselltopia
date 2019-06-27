import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:reselltopia/contants.dart';
import 'package:reselltopia/models/CategoryModel.dart';
import 'package:reselltopia/pages/category_products.dart';

class CategoriesList extends StatefulWidget {
  @override
  _CategoriesListState createState() => _CategoriesListState();
}

class _CategoriesListState extends State<CategoriesList> {
  final fireStore = Firestore.instance;
  @override
  Widget build(BuildContext context) {
    // List<CategoryModel> listItems = getData();
    return Container(
        child: StreamBuilder<QuerySnapshot>(
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: Text('No data available'),
          );
        }
        final messages = snapshot.data.documents;
        List<CategoryModel> productList = [];
        for (var message in messages) {
          print("data ${message.data}");
          CategoryModel productModel = CategoryModel();
          productModel.id = message.documentID;
          productModel.name =
              message.data[NAME] == null ? "" : message.data[NAME];
          productModel.type =
              message.data[TYPE] == null ? "" : message.data[TYPE];
          productModel.imageLocation =
              message.data[PICTURE] == null ? "" : message.data[PICTURE];
          productModel.quantity =
              message.data[QUANTITY] == null ? "" : message.data[QUANTITY];

          //print(productModel.name);
          productList.add(productModel);
          // print(productModel);
        }

        return GridView.builder(
            gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            scrollDirection: Axis.vertical,
            itemCount: productList.length,
            itemBuilder: (BuildContext cntxt, int index) {
              return ListItem(
                imageLocation: productList[index].imageLocation,
                title: productList[index].name,
                quantity: productList[index].quantity,
                type: productList[index].type,
              );
            });
      },
      stream: fireStore.collection(CATEGORIES).snapshots(),
    ));
  }
}

/* height: 130.0,
      child: new ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: listItems.length,
          itemBuilder: (BuildContext cntxt, int index) {
            return ListItem(
              imageLocation: listItems[index].imageLocation,
              title: listItems[index].imageCaption,
              quantity: listItems[index].quantity,
            );
          }),*/
//);
class ListItem extends StatelessWidget {
  String imageLocation;
  String title;
  String quantity;
  String type;
  ListItem(
      {@required this.imageLocation,
      @required this.title,
      @required this.quantity,
      this.type});
  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CategoryProducts(
                        type: type,
                      )));
        },
        child: Container(
          color: Colors.white,
          child: GridTile(
            child: Image.network(
              imageLocation,
              fit: BoxFit.fill,
            ),
            footer: Container(
              color: Colors.white70,
              child: ListTile(
                leading: Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                title: Text(
                  quantity,
                  style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.w500),
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
          ),
        ),
      ),
    );
  }
}
