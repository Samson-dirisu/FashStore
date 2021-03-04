import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  static const ID = "id";
  static const NAME = "name";
  static const PRICE = "price";
  static const BRAND = "brand";
  static const SIZES = "sizes";
  static const IMAGES = "images";
  static const CATEGORY = "category";

  String _id;
  String _name;
  String _brand;
  String _category;
  int _price;
  List _sizes;
  List _images;

  String get id => _id;
  String get name => _name;
  String get brand => _brand;
  String get category => _category;
  int get price => _price;
  List get sizes => _sizes;
  List get images => _images;

  ProductModel.fromSnapshot(DocumentSnapshot snapshot) {
    Map data = snapshot.data();
    _id = data[ID];
    _name = data[NAME];
    _price = data[PRICE];
    _brand = data[BRAND];
    _category = data[CATEGORY];
    _sizes = data[SIZES];
    _images = data[IMAGES];
  }

  Map toMap() => {
        ID: _id,
        NAME: _name,
        PRICE: _price,
        BRAND: _brand,
        CATEGORY: _category,
        SIZES: _sizes,
        IMAGES: _images
      };
}
