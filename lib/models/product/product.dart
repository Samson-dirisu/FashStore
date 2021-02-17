import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  static const ID = "id";
  static const NAME = "name";
  static const PRICE = "price";
  static const BRAND = "brand";
  static const COLORS = "colors";
  static const QUANTITY = "quantity";
  static const SIZES = "sizes";
  static const SALE = "sale";
  static const FEATURED = "featured";
  static const PICTURE = "picture";
  static const DESCRIPTION = "description";

  String _id;
  String _name;
  String _brand;
  String _description;
  int _price;
  int _quantity;
  List<String> _colors;
  List _sizes;
  List _picture;
  bool _sale;
  bool _featured;

  String get id => _id;
  String get name => _name;
  String get description => _description;
  String get brand => _brand;
  int get price => _price;
  int get quantity => _quantity;
  List<String> get colors => _colors;
  List get sizes => _sizes;
  List get picture => _picture;
  bool get onSale => _sale;
  bool get featured => _featured;

  ProductModel.fromSnapshot(DocumentSnapshot snapshot) {
    Map data = snapshot.data();
    _id = data[ID];
    _name = data[NAME];
    _price = data[PRICE];
    _quantity = data[QUANTITY];
    _description = data[DESCRIPTION];
    _picture = data[PICTURE];
    _brand = data[BRAND];
    _colors = data[COLORS];
    _sizes = data[SIZES];
    _sale = data[SALE];
    _featured = data[FEATURED];
  }
}
