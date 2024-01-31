import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';

class User{
  final String email;
  final String uid;
  final String photoUrl;
  final String username;

  const User({
    required this.email,
    required this.uid,
    required this.photoUrl,
    required this.username

});
  Map<String,dynamic> toJson()=>{
    "username":username,
    "uid":uid,
    "email":email,
    "photourl":photoUrl
  };
  static User fromSnap(DocumentSnapshot snap){
    var snapshot=snap.data() as Map<String,dynamic>;

    return User(
      username:snapshot['username'],
      email: snapshot['email'],
      uid: snapshot['uid'],
      photoUrl: snapshot['photoUrl']

    );
  }
}
