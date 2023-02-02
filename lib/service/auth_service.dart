import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  // login

  // register
  Future register(String email, String password, String username) async {
    try {
      final user = (await firebaseAuth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user;
      if (user != null) {
        return true;
      }
    } on FirebaseAuthException catch (error) {
      log(error.message!);
    }
  }
}
