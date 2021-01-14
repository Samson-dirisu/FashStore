import 'package:FashStore/screens/home_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'RegisterScreen.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final _formkey = GlobalKey<FormState>();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  SharedPreferences preferences;
  bool loading = false;
  bool isLogedIn = false;

  @override
  void initState() {
    super.initState();
    // isSignedIn();
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

  // FUNTION RESPONSIBLE FOR EMAIL AND PASSWORD LOGIN
  

  // FUNTION RESPONSIBLE FOR GOOGLE LOGIN
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

    // CREATE USER
    User user = userCredential.user;

    if (credential != null) {
      final QuerySnapshot result = await FirebaseFirestore.instance
          .collection("users")
          .where("id", isEqualTo: user.uid)
          .get();
      List<QueryDocumentSnapshot> documents = result.docs;

      // CHECK IF DOCUMENTS IS EMPTY
      if (documents.length == 0) {
        await FirebaseFirestore.instance
        .collection("users")
        .doc(user.uid)
        .set({
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
      // BODY
      body: Stack(
        children: [
          // BACKDROP IMAGE
          Container(
            child: Image.asset(
              "images/backdrop.jpg",
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          Container(
            color: Colors.black.withOpacity(0.4),
            width: double.infinity,
            height: double.infinity,
          ),

          // EMAIL AND PASSWORD FIELD
          Center(
            child: Form(
              key: _formkey,
              child: ListView(
                children: [
                  // EMAIL TEXT FORM FIELD
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 8.0,
                      right: 8.0,
                      top: 220.0,
                    ),
                    child: Material(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white.withOpacity(0.8),
                      elevation: 0.0,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: "Email",
                            border: InputBorder.none,
                            icon: Icon(
                              Icons.email,
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          controller: _emailTextController,
                          validator: (value) {
                            Pattern pattern =
                                r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
                            RegExp regex = new RegExp(pattern);
                            print(value);
                            if (value.isEmpty) {
                              return 'Please enter email';
                            } else {
                              if (!regex.hasMatch(value))
                                return 'Enter valid email';
                              else
                                return null;
                            }
                          },
                        ),
                      ),
                    ),
                  ),

                  // PASSWORD TEXT FORM FIELD
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 8.0,
                      right: 8.0,
                      top: 15.0,
                    ),
                    child: Material(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white.withOpacity(0.8),
                      elevation: 0.0,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: "Password",
                            icon: Icon(Icons.lock_outline),
                            border: InputBorder.none,
                          ),
                          keyboardType: TextInputType.emailAddress,
                          controller: _passwordTextController,
                          obscureText: true,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "The password field can not be empty";
                            } else if (value.length < 6) {
                              return "The password has to be at least 6 characters long";
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ),

                  // LOGING BUTTON
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 8.0,
                      right: 8.0,
                      top: 15.0,
                      bottom: 40.0,
                    ),
                    child: Material(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.pink,
                      elevation: 0.0,
                      child: MaterialButton(
                        minWidth: MediaQuery.of(context).size.width,
                        onPressed: () {},
                        child: Text(
                          "Login",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 22.0,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // SIGN IN WITH GOOGLE BUTTON
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Material(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.blue,
                      elevation: 0.0,
                      child: MaterialButton(
                        minWidth: MediaQuery.of(context).size.width,
                        onPressed: () {
                          handlingSignIn();
                        },
                        child: Text(
                          "Sign In with google",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 22.0,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // TEXT SUGGESTING YOU TO SIGN UP
                  Center(
                    child: RichText(
                      text: TextSpan(
                        text: "Don't have an account? click here to ",
                        children: <TextSpan>[
                          TextSpan(
                            text: "Sign up",
                            style: TextStyle(color: Colors.red),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (context, animation,
                                        secondaryAnimation) {
                                      return RegisterScreen();
                                    },
                                  ),
                                );
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
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
      ),
    );
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
