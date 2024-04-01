import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  get user => _auth.currentUser;
  var userName = FirebaseAuth.instance.currentUser?.email;

  //SIGN UP METHOD
  Future<UserCredential> signUp(
      {required String email, required String password}) async {
    try {
      var userCredintial = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredintial;
    } on FirebaseAuthException catch (e) {
      return throw Exception(e.message);
    }
  }

  //SIGN IN METHOD
  Future<UserCredential> signIn(
      {required String email, required String password}) async {
    try {
      var userCredintial = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      return userCredintial;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    }
  }

  //SIGN OUT METHOD
  Future signOut() async {
    await _auth.signOut();

    print('signout');
  }
}
