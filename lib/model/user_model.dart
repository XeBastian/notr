import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String? name;
  String? email;
  int? age;
  Timestamp? timecreated;

  User({this.name, this.email, this.age, this.timecreated});
  // read a firestore document
  factory User.fromDocument(DocumentSnapshot doc) {
    return User(
      name: doc['name'],
      email: doc['email'],
      age: doc['age'],
      timecreated: doc['timecreated'],
    );
  }
// create a firestore document
  Map<String, dynamic> toDocument() {
    return {
      'name': name,
      'email': email,
      'age': age,
      'timecreated': timecreated,
    };
  }
}
