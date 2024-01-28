import 'dart:html';
import 'dart:typed_data';

import 'package:cleanuppp/resources/storage_methods.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //signUp user
  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required Uint8List file,
  }) async {
    String res = "Some error occurred";
    try {
      if (email.isNotEmpty || password.isNotEmpty || username.isNotEmpty) {
        // register user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        print(cred.user!.uid);

        String photoUrl =
            await StorageMethods().uploadImageToStorage('profilePics', file, false);

        //add user to the database
        await _firestore.collection('users').doc(cred.user!.uid).set({
          'Username': username,
          'uid': cred.user!.uid,
          'email': email,
          'photoUrl':photoUrl,
        });
        res = "Success";
      }
    } on FirebaseAuthException catch(err){
      if(err.code=='invalid-email'){
        res="The email is nt correct";
      } else if(err.code=='weak-password'){
        res='Password should be of min 6 characters';
      }
    }

    catch (err) {
      res = err.toString();
    }
    return res;

  }
  //logging in the user
  Future<String> loginUser({
    required String email,
    required String password
})async{
    String res='Some error occurred';

    try{
      if(email.isNotEmpty||password.isNotEmpty){
        await _auth.signInWithEmailAndPassword(email: email, password: password);
        res='success';
      }
      else{
        res='Please enter all the fields';
      }
    }catch(err){
      res=err.toString();
    }
    return res;
    }
  }

