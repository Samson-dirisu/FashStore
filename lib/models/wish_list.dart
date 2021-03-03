class WishListModel {
  static const ID = "id";
  static const IMAGE = "image";
  static const NAME = "name";
  static const PRODUCT_ID = "productId";
  static const PRICE = "price";
  static const SIZE = "size";

  String _id;
  List _image;
  String _name;
  String _productId;
  int _price;
  String _size;

  String get id => _id;
  List get image => _image;
  String get name => _name;
  String get productId => _productId;
  int get price => _price;
  String get size => _size;

  WishListModel.fromMap(Map map) {
    _id = map[ID];
    _image = map[IMAGE];
    _name = map[NAME];
    _productId = map[PRODUCT_ID];
    _price = map[PRICE];
    _size = map[SIZE];
  }

  Map toMap() => {
        ID: _id,
        IMAGE: _image,
        NAME: _name,
        PRODUCT_ID: _productId,
        PRICE: _price,
        SIZE: _size,
      };
}
