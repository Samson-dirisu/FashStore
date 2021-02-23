class CartItemModel {
  static const ID = "id";
  static const IMAGE = "image";
  static const NAME = "name";
  static const PRODUCT_ID = "productId";
  static const QUANTITY = "quantity";
  static const PRICE = "price";
  static const SIZE = "size";

  String _id;
  String _image;
  String _name;
  String _productId;
  String _size;
  int _quantity;
  int _price;

  String get id => _id;
  String get image => _image;
  String get name => _name;
  String get productId => _productId;
  String get size => _size;
  int get quantity => _quantity;
  int get price => _price;

  CartItemModel.fromMap(Map data) {
    _id = data[ID];
    _image = data[IMAGE];
    _name = data[NAME];
    _size = data[SIZE];
    _productId = data[PRODUCT_ID];
    _quantity = data[QUANTITY];
    _price = data[PRICE];
  }

  Map toMap() => {
        ID: _id,
        IMAGE: _image,
        NAME: _name,
        SIZE: _size,
        PRODUCT_ID: _productId,
        QUANTITY: _quantity,
        PRICE: _price
      };
}
