import 'package:firebase_database/firebase_database.dart';

class UserServices {
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
