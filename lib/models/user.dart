import 'package:FashStore/models/cart_item.dart';
import 'package:FashStore/models/wish_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  static const ID = 'uId';
  static const NAME = 'name';
  static const EMAIL = 'email';
  static const STRIPE_ID = 'stripeId';
  static const CART = "cart";
  static const WISH_LIST = "wish list";
  
  // private variables
  String _id;
  String _name;
  String _email;
  String _stripeId;
  int _priceSum = 0;
  
  // getters
  String get id => _id;
  String get name => _name;
  String get email => _email;
  String get stripeId => _stripeId;
  
  // public variables
  List<CartItemModel> cart;
  List<WishListModel> wishList;
  int totalCartPrice;
  
  // named constructor for converting DocumentSnapshot
  // from firebase to Dart object
  UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    Map data = snapshot.data();
    _id = data[ID];
    _name = data[NAME];
    _email = data[EMAIL];
    _stripeId = data[STRIPE_ID];
    cart = _convertCartItems(data[CART] ?? []);
    wishList = _convertedWishListItems(data[WISH_LIST] ?? []);
    totalCartPrice = data[CART] == null ? 0 : getTotalPrice(cart: data[CART]);
  }
  
  // converting an object map to CartItemModel
  List<CartItemModel> _convertCartItems(List cart) {
    List<CartItemModel> convertedCart = [];
    for (Map cartItem in cart) {
      convertedCart.add(CartItemModel.fromMap(cartItem));
    }
    return convertedCart;
  }
  
  // converting and object map to WishListModel
  List<WishListModel> _convertedWishListItems(List wishList) {
    List<WishListModel> convertedWishList = [];
    for (Map wishListitem in wishList) {
      convertedWishList.add(WishListModel.fromMap(wishListitem));
    }
    return convertedWishList;
  }
  

  // method to get total price
  int getTotalPrice({List cart}) {
    if (cart == null) {
      return 0;
    }
    for (Map cartItem in cart) {
      _priceSum += cartItem["price"];
    }
    int total = _priceSum;
    return total;
  }
}
