import 'package:FashStore/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  SharedPreferences preferences;
  bool loading = false;
  bool isLogedIn = false;

  @override
  void initState() {
    super.initState();
    isSignedIn();
  }

  void isSignedIn() async {
    // CHANGE LOADING STATE TO TRUE
    setState(() {
      loading = true;
    });

    preferences = await SharedPreferences.getInstance();
    isLogedIn = await googleSignIn.isSignedIn();

    // CHECK WETHER USER IS LOGED IN
    if (isLogedIn) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return HomePage();
      }));
    }

    // CHANGE LOADING STATE BACK TO FALSE
    setState(() {
      loading = false;
    });
  }

  void handlingSignIn() async {
    preferences = await SharedPreferences.getInstance();

    // SET LOADING STATE TO TRUE
    setState(() {
      loading = true;
    });

    // SIGN IN USER THROUGH GOOGLE
    final GoogleSignInAccount googleUser = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleUser.authentication;

    // AUTHENTICATE USER WITH TOKENS
    AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken);

    // USER CREDENTIAL FROM GOOGLE
    UserCredential userCredential =
        await firebaseAuth.signInWithCredential(credential);

    // GET USER
    User user = userCredential.user;

    if (credential != null) {
      final QuerySnapshot result = await FirebaseFirestore.instance
          .collection("users")
          .where("id", isEqualTo: user.uid)
          .get();
      List<QueryDocumentSnapshot> documents = result.docs;

      // CHECK IF DOCUMENTS IS EMPTY
      if (documents.length == 0) {
        await FirebaseFirestore.instance.collection("users").doc(user.uid).set({
          "id": user.uid,
          "username": user.displayName,
          "profilePicture": user.photoURL
        });

        // SAVE INFO TO LOCAL STORAGE
        preferences.setString("id", user.uid);
        preferences.setString("username", user.displayName);
        preferences.setString("profilePicture", user.photoURL);
      } else {
        preferences.setString("id", documents[0]["id"]);
        preferences.setString("username", documents[0]["username"]);
        preferences.setString("profilePicture", documents[0]["profilePicture"]);
      }
    } else {}

    // SET LOADING STATE TO FALSE
    setState(() {
      loading = false;
    });

    // FLUTTER TOAST MESSAGE
    Fluttertoast.showToast(msg: "Login Successful");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            'Login',
            style: TextStyle(color: Colors.pink),
          ),
          elevation: 0.1,
        ),

        // BODY
        body: Stack(
          children: [
            Center(
              child: FlatButton(
                onPressed: () {
                  handlingSignIn();
                },
                color: Colors.pink,
                child: Text(
                  "Sign in/ Sign up with google",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),

            // VISIBILITY WIDGET
            Visibility(
              visible: loading ?? true,
              child: Container(
                alignment: Alignment.center,
                color: Colors.white.withOpacity(0.7),
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                ),
              ),
            ),
          ],
        ));
  }
}

// Future handleSignIn() async {
//     preferences = await SharedPreferences.getInstance();

//     setState(() {
//       loading = true;
//     });

//     GoogleSignInAccount googleUser = await googleSignIn.signIn();
//     GoogleSignInAuthentication googleSignInAuthentication =
//         await googleUser.authentication;
//     final AuthCredential credential = GoogleAuthProvider.credential(
//         accessToken: googleSignInAuthentication.accessToken,
//         idToken: googleSignInAuthentication.idToken);

//     UserCredential userCredential =
//         await firebaseAuth.signInWithCredential(credential);
//     final User firebaseUser = userCredential.user;

//     if (credential != null) {
//       // CHECK IF FIREBASEUSER HAS SIGNED UP
//       final QuerySnapshot result = await FirebaseFirestore.instance
//           .collection("users")
//           .where("id", isEqualTo: firebaseUser.uid)
//           .get();
//       final List<DocumentSnapshot> documents = result.docs;

//       // IF FIREBASE USER IS NOT INCLUDED WE SIGN IT UP
//       if (documents.length == 0) {
//         // INSERT THE USER TO OUR COLLECTION
//         FirebaseFirestore.instance
//             .collection("users")
//             .doc(firebaseUser.uid)
//             .set({
//           "id": firebaseUser.uid,
//           "username": firebaseUser.displayName,
//           "profilePicture": firebaseUser.photoURL
//         });

//         await preferences.setString("id", firebaseUser.uid);
//         await preferences.setString("username", firebaseUser.displayName);
//         await preferences.setString("photoUrl", firebaseUser.photoURL);
//       } else {
//         await preferences.setString("id", documents[0]["id"]);
//         await preferences.setString("username", documents[0]["username"]);
//         await preferences.setString("photoUrl", documents[0]["photoUrl"]);
//       }

//       Fluttertoast.showToast(msg: "Login was successful");
//       setState(() {
//         loading = false;
//       });
//     } else {}
//   }
