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
  List<CategoryModel> productList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  void getData() async {
    QuerySnapshot documents =
        await fireStore.collection(CATEGORIES).getDocuments();
    productList = [];
    for (var message in documents.documents) {
      print(message.documentID);
      // print("data ${message.data}");
      CategoryModel productModel = CategoryModel();
      productModel.id = message.documentID;
      productModel.name = message.data[NAME] == null ? "" : message.data[NAME];
      productModel.type = message.data[TYPE] == null ? "" : message.data[TYPE];
      productModel.imageLocation =
          message.data[PICTURE] == null ? "" : message.data[PICTURE];
      productModel.quantity =
          message.data[QUANTITY] == null ? "" : message.data[QUANTITY];

      //print(productModel.name);
      productList.add(productModel);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    // List<CategoryModel> listItems = getData();

    return Container(
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: productList.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext cntxt, int index) {
            return ListItem(
              imageLocation: productList[index].imageLocation,
              title: productList[index].name,
              quantity: productList[index].quantity,
              type: productList[index].type,
            );
          }),
    );
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
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
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
              height: 150.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 90.0,
                    height: 90.0,
                    decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                        fit: BoxFit.fill,
                        image: new NetworkImage(imageLocation),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 2.0,
                  ),
                  Text(
                    title,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                ],
              )
              /* GridTile(
              child: Image.network(
                imageLocation,
                width: 80.0,
                height: 80.0,
              ),
              footer: Container(
                height: 40.0,
                color: Colors.black.withOpacity(0.5),
                child: ListTile(
                  leading: Text(
                    title,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  title: Text(
                    quantity,
                    style:
                        TextStyle(color: APP_COLOR, fontWeight: FontWeight.w500),
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
            ),*/
              ),
        ),
      ),
    );
  }
}
