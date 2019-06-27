import 'package:flutter/material.dart';
import 'package:reselltopia/RawData/productsData.dart';
import 'package:reselltopia/models/productsModel.dart';
import 'package:reselltopia/pages/product_detail.dart';

class GridList extends StatefulWidget {
  @override
  _GridListState createState() => _GridListState();
}

class _GridListState extends State<GridList> {
  List<ProductModel> productList = getProductData();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 320.0,
      child: GridView.builder(
          itemCount: productList.length,
          gridDelegate:
              new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (BuildContext cntxt, int index) {
            return SingleProduct(
              productModel: productList[index],
            );
          }),
    );
  }
}

class SingleProduct extends StatelessWidget {
  ProductModel productModel;
  SingleProduct({this.productModel});
  @override
  Widget build(BuildContext context) {
    return InkWell(
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
          tag: productModel.name,
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
                    "\$${productModel.price}",
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.w500),
                  ),
                  subtitle: Text(
                    "\$${productModel.oldPrice}",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.lineThrough),
                  ),
                ),
              ),
              child: Image.asset(
                productModel.imageLocation,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
