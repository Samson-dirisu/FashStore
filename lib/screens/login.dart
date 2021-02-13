import 'package:FashStore/components/loading.dart';
import 'package:FashStore/screens/home_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/user_provider.dart';

import 'RegisterScreen.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formkey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    return Scaffold(
      key: _key,
      // BODY
      body: user.status == Status.Authenticating ? Loading() :  Stack(
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
                          controller: _email,
                          validator: (value) {
                            if (value.isNotEmpty) {
                              Pattern pattern =
                                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                              RegExp regex = RegExp(pattern);

                              if (!regex.hasMatch(value)) {
                                return "Enter a valid email address";
                              } else {
                                return null;
                              }
                            } else
                              return "Enter an email";
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
                          controller: _password,
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
                        onPressed: () async {
                          if (_formkey.currentState.validate()) {
                            if (!await user.signIn(_email.text, _password.text))
                              _key.currentState.showSnackBar(
                                  SnackBar(content: Text("Sign in failed")));
                          }
                        },
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
                        onPressed: () {},
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
        ],
      ),
    );
  }
}
