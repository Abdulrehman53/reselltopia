import 'package:flutter/material.dart';

class ProductDetailRow extends StatelessWidget {
  String type, name;
  ProductDetailRow({this.type, this.name});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            type,
            style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            name,
            style: TextStyle(color: Colors.blue),
          ),
        )
      ],
    );
  }
}
