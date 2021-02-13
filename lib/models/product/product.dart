import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  static const NAME = "name";
  static const PRICE = "price";
  static const BRAND = "brand";
  static const COLORS = "colors";
  static const QUANTITY = "quantity";
  static const SIZES = "sizes";
  static const ON_SALE = "Onsale";
  static const FEATURED = "featured";

  String _name;
  double _price;
  int _quantity;
  String _brand;
  List<String> _colors;
  List _sizes;
  bool _onSale;
  bool _featured;

  String get name => _name;
  double get price => _price;
  int get quantity => _quantity;
  String get brand => _brand;
  List<String> get colors => _colors;
  List get sizes => _sizes;
  bool get onSale => _onSale;
  bool get featured => _featured;

  Product.fromSnapshot(DocumentSnapshot snapshot) {
    Map data = snapshot.data();
    _name = data[NAME];
    _price = data[PRICE];
    _quantity = data[QUANTITY];
    _brand = data[BRAND];
    _colors = data[COLORS];
    _sizes = data[SIZES];
    _onSale = data[ON_SALE];
    _featured = data[FEATURED];
  }
}
