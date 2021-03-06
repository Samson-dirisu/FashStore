import 'package:FashStore/models/cart_item.dart';
import 'package:FashStore/models/product.dart';
import 'package:FashStore/models/user.dart';
import 'package:FashStore/models/wish_list.dart';
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

  // function resposible for creating users
  void createUser(Map data) {
    _firestore.collection(collection).doc(data['uId']).set(data);
  }

  // function resposible from getting users based on their id
  Future<UserModel> getUserById(String id) => _firestore
      .collection(collection)
      .doc(id)
      .get()
      .then((snapshot) => UserModel.fromSnapshot(snapshot));

  // function responsible for adding products to cart
  void addToCart({String userId, CartItemModel cartItemModel}) {
    _firestore.collection(collection).doc(userId).update({
      "cart": FieldValue.arrayUnion([cartItemModel.toMap()])
    });
  }

  // function responsible for removing product from cart
  void removeFromCart({String userId, CartItemModel cartItemModel}) {
    _firestore.collection(collection).doc(userId).update({
      "cart": FieldValue.arrayRemove([cartItemModel.toMap()])
    });
  }

  void clearCart({String userId}) {
    _firestore.collection(collection).doc(userId).update({
      'cart' : FieldValue.delete()
    });
  }

  // function responsible for adding product to wish list
  void addToWishList({String userId, WishListModel wishListItem}) {
    _firestore.collection(collection).doc(userId).update({
      "wish list": FieldValue.arrayUnion([wishListItem.toMap()])
    });
  }

  // function responsible for removing product from wish list
  void removeFromWishList({String userId, WishListModel wishListItem}) {
    _firestore.collection(collection).doc(userId).update({
      "wish list": FieldValue.arrayRemove([wishListItem.toMap()])
    });
  }

  // function responsible for getting product based on their id
  Future<List<WishListModel>> getWishList({String userId}) async {
    return _firestore.collection(collection).doc(userId).get().then((snapshot) {
      List<WishListModel> item = [];
      if (snapshot.get('wish list') == null) {
        item.add(WishListModel.fromMap({}));
      } else {
        for (Map snap in snapshot.get('wish list')) {
          item.add(WishListModel.fromMap(snap));
        }
      }
      return item;
    });
  }

  Future<bool> checkWishList({String userId, ProductModel product}) async {
    var item =
        _firestore.collection(collection).doc(userId).get().then((value) {
      for (int i = 0; i < value.get('wish list').length; i++) {
        if (value[i].get('wish list')['productId'] == product.id) {
          return true;
        } else
          return false;
      }
    });
    return item;
  }
}
