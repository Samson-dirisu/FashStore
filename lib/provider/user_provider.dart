import 'package:FashStore/helper/navigator.dart';
import 'package:FashStore/models/cart_item.dart';
import 'package:FashStore/models/orders.dart';
import 'package:FashStore/models/product.dart';
import 'package:FashStore/models/user.dart';
import 'package:FashStore/models/wish_list.dart';
import 'package:FashStore/services/order_service.dart';
import 'package:FashStore/services/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class UserProvider with ChangeNotifier {
  FirebaseAuth _auth;
  GoogleSignIn googleSignIn = GoogleSignIn();
  User _user;
  Status _status = Status.Uninitialized;
  List<OrderModel> _orders = [];
  List<WishListModel> _wishListItems = [];
  UserServices _userService = UserServices();
  UserModel _userModel;
  OrderService _orderService = OrderService();
  bool toggleButton = false;

  // named constructor
  UserProvider.initialize() : _auth = FirebaseAuth.instance {
    _auth.authStateChanges().listen(_onStateChanged);
  }

  // getters
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
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        _userModel = await _userService.getUserById(value.user.uid);
        _status = Status.Authenticated;
        notifyListeners();
      });

      return true;
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      return false;
    }
  }

  // SIGN UP METHOD
  Future<bool> signUp(String name, String email, String password) async {
    try {
      _status = Status.Authenticating;
      notifyListeners();

      // create user with email and password
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        Map<String, dynamic> values = {
          "name": name,
          "email": email,
          "uId": value.user.uid,
          "stripeId": '',
        };
        _userService.createUser(values);
        _userModel = await _userService.getUserById(value.user.uid);
        _status = Status.Authenticated;
        notifyListeners();
      });
      return true;
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
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

  // function responsible for google sign in and sign up
  Future<bool> googleSignUp() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      GoogleSignInAccount googleUser = await googleSignIn.signIn();
      GoogleSignInAuthentication authentication =
          await googleUser.authentication;
      AuthCredential authCredential = GoogleAuthProvider.credential(
          idToken: authentication.idToken,
          accessToken: authentication.accessToken);
      UserCredential userCredential =
          await _auth.signInWithCredential(authCredential);
      User user = userCredential.user;

      // check if authcredential has value
      if (authCredential != null) {
        final QuerySnapshot result = await FirebaseFirestore.instance
            .collection('users')
            .where("uId", isEqualTo: user.uid)
            .get();
        List<QueryDocumentSnapshot> documents = result.docs;

        if (documents.length == 0) {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .set({
            "name": user.displayName,
            "email": user.email,
            "uId": user.uid,
            "stripeId": '',
          });

          // if documents is empty, i.e not user in firestore yet
          // so we save to local memory directly User
          preferences.setString("uId", user.uid);
          preferences.setString("name", user.displayName);
          preferences.setString("email", user.email);
        }
        // if firestore has user, we save directly from what is saved in
        // documents list from fire store
        else {
          preferences.setString("uId", documents[0]["uId"]);
          preferences.setString("email", documents[0]["email"]);
          preferences.setString("name", documents[0]["name"]);
        }
        Fluttertoast.showToast(msg: "Login Successful");
        _status = Status.Authenticated;
        notifyListeners();
        return true;
      } else {
        Fluttertoast.showToast(msg: "Login failed");
        _status = Status.Unauthenticated;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      return false;
    }
  }

  // function responsible for checking for auth changes.
  Future<void> _onStateChanged(User user) async {
    if (user == null) {
      _status = Status.Unauthenticated;
      notifyListeners();
    } else {
      _user = user;
      _userModel = await _userService.getUserById(user.uid);
      _status = Status.Authenticated;
      notifyListeners();
    }
  }

  // function responsible for getting user data from firestore
  Future<void> getUserOrder() async {
    _orders = await _orderService.getUserOrders(userId: _user.uid);
    notifyListeners();
  }

  // provider function responsible for adding product to cart list
  Future<bool> addToCart({ProductModel product, String size}) async {
    try {
      var uuid = Uuid();
      String cartItemId = uuid.v4();

      Map cartItem = {
        "id": cartItemId,
        "name": product.name,
        "image": product.images,
        "productId": product.id,
        "price": product.price,
        "size": size,
        "wish list": []
      };

      CartItemModel item = CartItemModel.fromMap(cartItem);
      _userService.addToCart(userId: _user.uid, cartItemModel: item);
      return true;
    } catch (e) {
      return false;
    }
  }

  // provider function responsible for removing product from cart list
  Future<bool> removeFromCart({CartItemModel cartItem}) async {
    try {
      _userService.removeFromCart(userId: _user.uid, cartItemModel: cartItem);
      return true;
    } catch (e) {
      return false;
    }
  }

  void clearCart() {
    _userService.clearCart(userId: _user.uid);
  }

  // provider function responsible for adding product to wish list
  Future<bool> addToWishList({ProductModel product, String size}) async {
    try {
      Map item = {
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
      return false;
    }
  }

  // provider function for removing product from wish list
  Future<bool> removeFromWishList({ProductModel product, String size}) async {
    try {
      Map item = {
        "images": product.images,
        "name": product.name,
        "price": product.price,
        "size": size,
        "productId": product.id
      };
      WishListModel wishItem = WishListModel.fromMap(item);
      _userService.removeFromWishList(userId: user.uid, wishListItem: wishItem);
      return true;
    } catch (e) {
      return false;
    }
  }

  // provider function responsible for getting wish list items from firebase
  Future<void> getWishList() async {
    _wishListItems = await _userService.getWishList(userId: _user.uid);
    notifyListeners();
  }

  void checkWishList(ProductModel product) {
    //getWishList();
    if (_wishListItems == null) {
      toggleButton = false;
      notifyListeners();
    } else {
      for (WishListModel item in _wishListItems) {
        if (item.productId == product.id) {
          toggleButton = true;
          notifyListeners();
        } else {
          toggleButton = false;
          notifyListeners();
        }
      }
    }
  }

  // function responsible for reloading the user model with latest data
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
//     }
//   }
