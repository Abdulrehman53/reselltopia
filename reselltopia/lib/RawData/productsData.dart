import 'package:reselltopia/models/productsModel.dart';

List<ProductModel> getData() {
  List<ProductModel> listItems = [];
  listItems.add(new ProductModel(
      name: 'Dress',
      imageLocation: 'images/products/dress1.jpeg',
      oldPrice: '54',
      price: '38'));
  listItems.add(new ProductModel(
      name: 'Hill',
      imageLocation: 'images/products/hills1.jpeg',
      oldPrice: '74',
      price: '58'));
  listItems.add(new ProductModel(
      name: 'Pant',
      imageLocation: 'images/products/pants1.jpg',
      oldPrice: '94',
      price: '68'));
  listItems.add(new ProductModel(
      name: 'Skt',
      imageLocation: 'images/products/skt1.jpeg',
      oldPrice: '84',
      price: '78'));

  return listItems;
}

List<ProductModel> getFavData() {
  List<ProductModel> listItems = [];
  listItems.add(new ProductModel(
      name: 'Dress',
      imageLocation: 'images/products/dress1.jpeg',
      oldPrice: '54',
      price: '38'));
  listItems.add(new ProductModel(
      name: 'Skt',
      imageLocation: 'images/products/skt1.jpeg',
      oldPrice: '84',
      price: '78'));

  return listItems;
}
