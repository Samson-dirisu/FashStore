import 'package:FashStore/models/cart_item.dart';
import 'package:FashStore/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

class UserServicess {
  FirebaseDatabase _database = FirebaseDatabase.instance;
  String ref = "users";

  // CREATING A NEW NODE AND THE NAME OF THE NODE IS USERS. NODE ALSO CALLED TABLE IS SQL
  createUser(Map value) => {
        _database
            .reference()
            .child(ref)
            .push()
            .set(value)
            .catchError((e) => print(e.toString()))
      };
}

class UserServices {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String collection = "users";

  void createUser(Map data) {
    _firestore.collection(collection).doc(data['uid']).set(data);
  }

  Future<UserModel> getUserById(String id) => _firestore
      .collection(collection)
      .doc(id)
      .get()
      .then((snapshot) => UserModel.fromSnapshot(snapshot));

  void addToCart({String userId, CartItemModel cartItemModel}) {
    _firestore.collection(collection).doc(userId).update({
      "cart": FieldValue.arrayUnion([cartItemModel.toMap()])
    });
  }

  void removeFromCart({String userId, CartItemModel cartItemModel}) {
    _firestore.collection(collection).doc(userId).update({
      "cart": FieldValue.arrayRemove([cartItemModel.toMap()])
    });
  }
}
