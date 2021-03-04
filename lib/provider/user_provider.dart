import 'package:FashStore/models/cart_item.dart';
import 'package:FashStore/models/orders.dart';
import 'package:FashStore/models/product.dart';
import 'package:FashStore/models/user.dart';
import 'package:FashStore/models/wish_list.dart';
import 'package:FashStore/services/order_service.dart';
import 'package:FashStore/services/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class UserProvider with ChangeNotifier {
  FirebaseAuth _auth;
  User _user;
  Status _status = Status.Uninitialized;
  List<OrderModel> _orders = [];
  List<WishListModel> _wishListItems = [];
  UserServices _userService = UserServices();
  UserModel _userModel;
  OrderService _orderService = OrderService();
  bool val;

  UserProvider.initialize() : _auth = FirebaseAuth.instance {
    _auth.authStateChanges().listen(_onStateChanged);
  }

  Status get status => _status;
  User get user => _user;
  UserModel get userModel => _userModel;
  List<OrderModel> get orders => _orders;
  List<WishListModel> get wishListItems => _wishListItems;

  // SIGN IN METHOD
  Future<bool> signIn(String email, String password) async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      print(e.toString());
      return false;
    }
  }

  // SIGN UP METHOD
  Future<bool> signUp(String name, String email, String password) async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        Map<String, dynamic> values = {
          "name": name,
          "email": email,
          "uId": value.user.uid,
          "stripeId": '',
          "wish list": []
        };
        _userService.createUser(values);
      });
      return true;
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      print(e.toString());
      return false;
    }
  }

  // SIGN OUT METHOD
  Future signOut() {
    _auth.signOut();
    _status = Status.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  // ON STATE CHANGED METHOD
  Future<void> _onStateChanged(User user) async {
    if (user == null) {
      _status = Status.Unauthenticated;
    } else {
      _user = user;
      _userModel = await _userService.getUserById(user.uid);
      _wishListItems = await _userService.getWishList(userId: _user.uid);
      _status = Status.Authenticated;
    }
    notifyListeners();
  }

  Future<void> getUserOrder() async {
    _orders = await _orderService.getUserOrders(userId: _user.uid);
    notifyListeners();
  }

  Future<bool> addToCart({ProductModel product, String size}) async {
    try {
      var uuid = Uuid();
      String cartItemId = uuid.v4();
      // List<CartItemModel> cart = _userModel.cart;

      Map cartItem = {
        "id": cartItemId,
        "name": product.name,
        "image": product.images,
        "productId": product.id,
        "price": product.price,
        "size": size
      };

      CartItemModel item = CartItemModel.fromMap(cartItem);
      _userService.addToCart(userId: _user.uid, cartItemModel: item);
      return true;
    } catch (e) {
      print("unable to add item ${e.toString()}");
      return false;
    }
  }

  Future<bool> removeFromCart({CartItemModel cartItem}) async {
    try {
      _userService.removeFromCart(userId: _user.uid, cartItemModel: cartItem);
      return true;
    } catch (e) {
      print("unable to delete item ${e.toString()}");
      return false;
    }
  }

  Future<bool> addToWishList({ProductModel product, String size}) async {
    try {
      var uuid = Uuid();
      final id = uuid.v4();

      Map item = {
        "id": id,
        "images": product.images,
        "name": product.name,
        "price": product.price,
        "size": size,
        "productId": product.id
      };

      WishListModel wishListItem = WishListModel.fromMap(item);
      _userService.addToWishList(userId: _user.uid, wishListItem: wishListItem);
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> removeFromWishList({ProductModel product}) async {
    try {
      _userService.removeFromWishList();
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  // Future<void> getWishList(ProductModel productModel) async {
  //   _wishListItems = await _userService.getWishList(userId: _user.uid);
  //   notifyListeners();
  // }

  bool checkWishList(ProductModel product) {
    if (_wishListItems != null) {
      for (WishListModel item in _wishListItems) {
        if (item.productId == product.id) {
          val = true;
        } else{
           val = false;
        }
      }
    } else {
      val = false;
    }
    bool temp = val;
    return temp;
  }

  Future<void> reloadUserModel() async {
    _userModel = await _userService.getUserById(user.uid);
    notifyListeners();
  }
}

// void handlingSignIn() async {
//     preferences = await SharedPreferences.getInstance();

//     // SET LOADING STATE TO TRUE
//     setState(() {
//       loading = true;
//     });

//     // SIGN IN USER THROUGH GOOGLE
//     final GoogleSignInAccount googleUser = await googleSignIn.signIn();
//     final GoogleSignInAuthentication googleSignInAuthentication =
//         await googleUser.authentication;

//     // AUTHENTICATE USER WITH TOKENS
//     AuthCredential credential = GoogleAuthProvider.credential(
//         accessToken: googleSignInAuthentication.accessToken,
//         idToken: googleSignInAuthentication.idToken);

//     // USER CREDENTIAL FROM GOOGLE
//     UserCredential userCredential =
//         await firebaseAuth.signInWithCredential(credential);

//     // CREATE USER
//     User user = userCredential.user;

//     if (credential != null) {
//       final QuerySnapshot result = await FirebaseFirestore.instance
//           .collection("users")
//           .where("id", isEqualTo: user.uid)
//            .get();
//      List<QueryDocumentSnapshot> documents = result.docs;

//       // CHECK IF DOCUMENTS IS EMPTY
//       if (documents.length == 0) {
//         await FirebaseFirestore.instance.collection("users").doc(user.uid).set({
//           "id": user.uid,
//           "username": user.displayName,
//           "profilePicture": user.photoURL
//         });

//         // SAVE INFO TO LOCAL STORAGE
//         preferences.setString("id", user.uid);
//         preferences.setString("username", user.displayName);
//         preferences.setString("profilePicture", user.photoURL);
//       } else {
//         preferences.setString("id", documents[0]["id"]);
//         preferences.setString("username", documents[0]["username"]);
//         preferences.setString("profilePicture", documents[0]["profilePicture"]);
//       }
//       // FLUTTER TOAST MESSAGE
//       Fluttertoast.showToast(msg: "Login Successful");

//       // SET LOADING STATE TO FALSE
//       setState(() {
//         loading = false;
//       });
//         Navigator.pushReplacement(
//         context,
//         PageRouteBuilder(
//             pageBuilder: (context, animation, secondaryAnimation) {
//               return HomePage();
//             },
//             transitionsBuilder:
//                 (context, animation, secondaryAnimation, child) {
//               var begin = Offset(1.1, 0.0);
//               var end = Offset.zero;
//               var tween = Tween(begin: begin, end: end);
//               var offsetAnimation = animation.drive(tween);
//               return SlideTransition(
//                 position: offsetAnimation,
//                 child: child,
//               );
//             },
//             transitionDuration: Duration(milliseconds: 2000)),
//       );
//     } else {
//       Fluttertoast.showToast(msg: "Login failed");
//     }
//   }
