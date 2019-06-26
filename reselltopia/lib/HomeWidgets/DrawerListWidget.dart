import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  final String title;
  final Icon icon;
  ListItem({@required this.title, @required this.icon});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: ListTile(title: Text(title), leading: icon),
    );
  }
}
