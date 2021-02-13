
import 'package:FashStore/components/loading.dart';
import 'package:FashStore/provider/user_provider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formkey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _name = TextEditingController();
  TextEditingController _confirmPasswordTextController =
      TextEditingController();
  bool hidePassword = true;
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    return Scaffold(
      key: _key,
      // BODY
      body: user.status == Status.Authenticating ? Loading() : Stack(
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
            color: Colors.black.withOpacity(0.8),
            width: double.infinity,
            height: double.infinity,
          ),

          Center(
            child: Form(
              key: _formkey,
              child: ListView(
                children: [
                  // FULL NAME FORM FIELD
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 8.0,
                      right: 8.0,
                      top: 180.0,
                    ),
                    child: Material(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white.withOpacity(0.8),
                      elevation: 0.0,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: "Full name",
                            icon: Icon(Icons.person_outline),
                          ),
                          keyboardType: TextInputType.name,
                          controller: _name,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter Full name';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ),

                  // GENDER SELECTION
                  // Padding(
                  //   padding: const EdgeInsets.only(
                  //     left: 8.0,
                  //     right: 8.0,
                  //     top: 15.0,
                  //   ),
                  //   child: Container(
                  //     decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(10.0),
                  //       color: Colors.white.withOpacity(0.8),
                  //     ),
                  //     child: Row(
                  //       children: [
                  //         Expanded(
                  //           child: ListTile(
                  //             title: Text(
                  //               "male",
                  //               textAlign: TextAlign.end,
                  //               style: TextStyle(
                  //                 color: Color(0xff444444),
                  //               ),
                  //             ),
                  //             trailing: Radio(
                  //               value: "male",
                  //               groupValue: "male",
                  //               onChanged: (value) {},
                  //             ),
                  //           ),
                  //         ),
                  //         Expanded(
                  //           child: ListTile(
                  //             title: Text(
                  //               "female",
                  //               textAlign: TextAlign.end,
                  //               style: TextStyle(
                  //                 color: Color(0xff444444),
                  //               ),
                  //             ),
                  //             trailing: Radio(
                  //               value: "female",
                  //               groupValue: "female",
                  //               onChanged: (value) {},
                  //             ),
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  // EMAIL TEXT FORM FIELD
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
                              labelText: "Email",
                              icon: Icon(Icons.email),
                              border: InputBorder.none),
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
                        child: ListTile(
                          contentPadding: EdgeInsets.only(left: 0.0),
                          title: TextFormField(
                            decoration: InputDecoration(
                                labelText: "password",
                                icon: Icon(Icons.lock_open_outlined),
                                border: InputBorder.none),
                            keyboardType: TextInputType.emailAddress,
                            obscureText: hidePassword,
                            controller: _password,
                            validator: (value) {
                              if (value.isEmpty) {
                                return "The password field can not be empty";
                              } else if (value.length < 6) {
                                return "The password has to be at least 6 characters long";
                              }
                              return null;
                            },
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.remove_red_eye),
                            onPressed: () {
                              setState(() {
                                hidePassword = !hidePassword;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ),

                  // CONFIRM PASSWORD FIELD
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
                        child: ListTile(
                          contentPadding: EdgeInsets.only(left: 0.0),
                          title: TextFormField(
                            decoration: InputDecoration(
                                labelText: "Confirm Password",
                                icon: Icon(Icons.lock_open_outlined),
                                border: InputBorder.none),
                            keyboardType: TextInputType.emailAddress,
                            controller: _confirmPasswordTextController,
                            obscureText: hidePassword,
                            validator: (value) {
                              if (value != _password.text) {
                                return "Passwords entered don't match";
                              } else if (value.length < 6) {
                                return "The password has to be at least 6 characters long";
                              }
                              return null;
                            },
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.remove_red_eye),
                            onPressed: () {
                              setState(() {
                                hidePassword = !hidePassword;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ),

                  // SIGN UP BUTTON
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
                            if (!await user.signUp(
                                _name.text, _email.text, _password.text))
                              _key.currentState.showSnackBar(
                                  SnackBar(content: Text("Sign in failed")));
                          } else {
                            
                          }
                        },
                        child: Text(
                          "Sign up",
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
                          // handlingSignIn();
                        },
                        child: Text(
                          "Sign up with google",
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
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: RichText(
                        text: TextSpan(
                          text: "Already have an account? ",
                          children: <TextSpan>[
                            TextSpan(
                              text: "Login",
                              style: TextStyle(color: Colors.red),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pop(context);
                                },
                            ),
                          ],
                        ),
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

  // void validateForm() async {
  //   FormState formState = _formkey.currentState;

  //   // IF TRUE, WE ARE GOING TO CREATE OUR USER
  //   if (formState.validate()) {
  //     // CHECK IF THE USER EXIST
  //     User user = firebaseAuth.currentUser;
  //     if (user == null) {
  //       firebaseAuth
  //           .createUserWithEmailAndPassword(
  //               email: _emailTextController.text,
  //               password: _passwordTextController.text)
  //           .then(
  //             (user) => {
  //               _userServices.createUser(
  //                 {
  //                   "username": user.user.displayName,
  //                   "email": user.user.email,
  //                   "userId": user.user.uid
  //                 },
  //               )
  //             },
  //           );
  //     }
  //   }
  // }
}
