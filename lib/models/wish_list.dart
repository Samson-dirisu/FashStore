class WishListModel {
  static const ID = "id";
  static const IMAGE = "images";
  static const NAME = "name";
  static const PRODUCT_ID = "productId";
  static const PRICE = "price";
  static const SIZE = "size";
  
  // private variables
  String _id;
  List _images;
  String _name;
  String _productId;
  int _price;
  String _size;
  
  // getters
  String get id => _id;
  List get images => _images;
  String get name => _name;
  String get productId => _productId;
  int get price => _price;
  String get size => _size;
  
  // named constructor for converting an object of type Map
  // to dart object
  WishListModel.fromMap(Map map) {
    _id = map[ID];
    _images = map[IMAGE];
    _name = map[NAME];
    _productId = map[PRODUCT_ID];
    _price = map[PRICE];
    _size = map[SIZE];
  }
  
  // method responsible for converting dart object to an object of type map
  Map toMap() => {
        ID: _id,
        IMAGE: _images,
        NAME: _name,
        PRODUCT_ID: _productId,
        PRICE: _price,
        SIZE: _size,
      };
}
