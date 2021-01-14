import 'package:FashStore/components/database/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final _formkey = GlobalKey<FormState>();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _nameTextController = TextEditingController();
  TextEditingController _confirmPasswordTextController =
      TextEditingController();
  UserServices _userServices = UserServices();
  String gender;
  String groupValue = "male";
  bool hidePassword = true;

  SharedPreferences preferences;
  bool loading = false;
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
                      color: Colors.white.withOpacity(0.5),
                      elevation: 0.0,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: "Full name",
                            icon: Icon(Icons.person_outline),
                          ),
                          keyboardType: TextInputType.name,
                          controller: _nameTextController,
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
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 8.0,
                      right: 8.0,
                      top: 15.0,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white.withOpacity(0.8),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: ListTile(
                              title: Text(
                                "male",
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                  color: Color(0xff444444),
                                ),
                              ),
                              trailing: Radio(
                                value: "male",
                                groupValue: groupValue,
                                onChanged: (value) {
                                  valueChanged(value);
                                },
                              ),
                            ),
                          ),
                          Expanded(
                            child: ListTile(
                              title: Text(
                                "female",
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                  color: Color(0xff444444),
                                ),
                              ),
                              trailing: Radio(
                                value: "female",
                                groupValue: groupValue,
                                onChanged: (value) {
                                  valueChanged(value);
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
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
                        child: ListTile(
                          contentPadding: EdgeInsets.only(left: 0.0),
                          title: TextFormField(
                            decoration: InputDecoration(
                                labelText: "password",
                                icon: Icon(Icons.lock_open_outlined),
                                border: InputBorder.none),
                            keyboardType: TextInputType.emailAddress,
                            obscureText: hidePassword,
                            controller: _passwordTextController,
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
                              if (value != _passwordTextController.text) {
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
                        onPressed: () {
                          validateForm();
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

  void valueChanged(value) {
    setState(() {
      if (value == "male") {
        groupValue = value;
        gender = value;
      } else if (value == "female") {
        groupValue = value;
        gender = value;
      }
    });
  }

  // VALIDATE FORM FUNCTION
  void validateForm() async {
    FormState formState = _formkey.currentState;

    // IF TRUE, WE ARE GOING TO CREATE OUR USER
    if (formState.validate()) {
      // CHECK IF THE USER EXIST
      User user = firebaseAuth.currentUser;
      if (user == null) {
        UserCredential createUser = await firebaseAuth
            .createUserWithEmailAndPassword(
          email: _emailTextController.text,
          password: _passwordTextController.text,
        )
            .then((user) {
          Map value = {};
          _userServices.createUser(value);
        });
      }
    }
  }
}
