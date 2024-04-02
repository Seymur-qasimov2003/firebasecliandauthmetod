import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../pages/homepage.dart';
import '../pages/signinpage.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  get user => _auth.currentUser;
  var userName = FirebaseAuth.instance.currentUser?.email;
  var userId = FirebaseAuth.instance.currentUser?.uid;

  //SIGN UP METHOD
  Future<UserCredential> signUp(
      {required String email, required String password}) async {
    try {
      var userCredintial = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      _firestore.collection('users').doc(userCredintial.user!.uid).set({
        'email': email,
        'uid': userCredintial.user!.uid,
      });
      return userCredintial;
    } on FirebaseAuthException catch (e) {
      return throw Exception(e.message);
    }
  }

  //SIGN IN METHOD
  Future<UserCredential> signIn(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      var userCredintial = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      _firestore.collection('users').doc(userCredintial.user!.uid).set({
        'email': email,
        'uid': userCredintial.user!.uid,
      });
      Navigator.pushAndRemoveUntil(
          context,
          CupertinoPageRoute(builder: (context) => HomePage()),
          (route) => false);
      return userCredintial;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    }
  }

  //SIGN OUT METHOD
  Future signOut(BuildContext context) async {
    await _auth.signOut();
    Navigator.pushAndRemoveUntil(
        context,
        CupertinoPageRoute(builder: (context) => SigninPage()),
        (route) => false);

    print('signout');
  }
}
