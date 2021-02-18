import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  static const ID = "id";
  static const NAME = "name";
  static const PRICE = "price";
  static const BRAND = "brand";
  static const COLORS = "colors";
  static const QUANTITY = "quantity";
  static const SIZES = "sizes";
  static const FEATURED = "featured";
  static const IMAGES = "images";

  String _id;
  String _name;
  String _brand;
  int _price;
  int _quantity;
  List<String> _colors;
  List _sizes;
  List _images;
  bool _featured;

  String get id => _id;
  String get name => _name;
  String get brand => _brand;
  int get price => _price;
  int get quantity => _quantity;
  List<String> get colors => _colors;
  List get sizes => _sizes;
  List get images => _images;
  bool get featured => _featured;

  ProductModel.fromSnapshot(DocumentSnapshot snapshot) {
    Map data = snapshot.data();
    _id = data[ID];
    _name = data[NAME];
    _price = data[PRICE];
    _quantity = data[QUANTITY];
    _brand = data[BRAND];
    _colors = data[COLORS];
    _sizes = data[SIZES];
    _featured = data[FEATURED];
    _images = data[IMAGES];
  }
}
