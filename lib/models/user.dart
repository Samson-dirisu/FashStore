import 'package:FashStore/models/cart_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  static const ID = 'uid';
  static const NAME = 'name';
  static const EMAIL = 'email';
  static const STRIPE_ID = 'stripeId';
  static const CART = "cart";

  String _id;
  String _name;
  String _email;
  String _stripeId;

  String get id => _id;
  String get name => _name;
  String get email => _email;
  String get stripeId => _stripeId;

  List<CartItemModel> cart;

  UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    Map data = snapshot.data();
    _id = data[ID];
    _name = data[NAME];
    _email = data[EMAIL];
    _stripeId = data[STRIPE_ID];
    cart = _convertCartItems(data[CART] ?? []);
  }

  List<CartItemModel> _convertCartItems(List cart) {
    List<CartItemModel> convertedCart = [];
    for (Map cartItem in cart) {
      convertedCart.add(CartItemModel.fromMap(cartItem));
    }
    return convertedCart;
  }
}
