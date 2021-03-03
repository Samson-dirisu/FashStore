import 'package:FashStore/models/cart_item.dart';
import 'package:FashStore/models/wish_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  static const ID = 'uid';
  static const NAME = 'name';
  static const EMAIL = 'email';
  static const STRIPE_ID = 'stripeId';
  static const CART = "cart";
  static const WISH_LIST = "wish list";

  String _id;
  String _name;
  String _email;
  String _stripeId;
  int _priceSum = 0;

  String get id => _id;
  String get name => _name;
  String get email => _email;
  String get stripeId => _stripeId;

  List<CartItemModel> cart;
  List<WishListModel> wishList;
  int totalCartPrice;

  UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    Map data = snapshot.data();
    _id = data[ID];
    _name = data[NAME];
    _email = data[EMAIL];
    _stripeId = data[STRIPE_ID];
    cart = _convertCartItems(data[CART] ?? []);
    totalCartPrice = data[CART] == null ? 0 : getTotalPrice(cart: data[CART]);
  }

  List<CartItemModel> _convertCartItems(List cart) {
    List<CartItemModel> convertedCart = [];
    for (Map cartItem in cart) {
      convertedCart.add(CartItemModel.fromMap(cartItem));
    }
    return convertedCart;
  }

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
