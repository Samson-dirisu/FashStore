import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  static const  ID = 'uid';
  static const  NAME = 'name';
  static const  EMAIL = 'email';
  static const  STRIPE_ID = 'stripeId';

  String _id;
  String _name;
  String _email;
  String _stripeId;

  String get id => _id;
  String get name => _name;
  String get email => _email;
  String get stripeId => _stripeId;

  UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    Map data = snapshot.data();
    _id = data[ID];
    _name = data[NAME];
    _email = data[EMAIL];
    _stripeId = data[STRIPE_ID];
  }
}
