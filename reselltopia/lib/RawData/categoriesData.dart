import 'package:reselltopia/models/CategoryModel.dart';

List<CategoryModel> getData() {
  List<CategoryModel> listItems = [];
  listItems.add(new CategoryModel(
      imageLocation: 'images/cats/dress.png',
      imageCaption: 'Dress',
      quantity: '5'));
  listItems.add(new CategoryModel(
      imageLocation: 'images/cats/formal.png',
      imageCaption: 'Formal',
      quantity: '6'));
  listItems.add(new CategoryModel(
      imageLocation: 'images/cats/jeans.png',
      imageCaption: 'Jeans',
      quantity: '12'));
  listItems.add(new CategoryModel(
      imageLocation: 'images/cats/shoe.png',
      imageCaption: 'Shoe',
      quantity: '15'));
  return listItems;
}
