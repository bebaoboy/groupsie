import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:groupsie/service/database_service.dart';
import 'package:groupsie/shared/strings.dart';

class AuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  // login

  // register
  Future register(
      {required String email,
      required String password,
      required String username}) async {
    try {
      final user = (await firebaseAuth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user;
      if (user != null) {
        await DatabaseService(uid: user.uid)
            .updateUserData(username: username, email: email);
        return "true";
      }
      return "false";
    } on FirebaseAuthException catch (error) {
      log(error.message!);
      return determineError(error);
    }
  }

  String determineError(FirebaseAuthException exception) {
    switch (exception.code) {
      case 'invalid-email':
        return Strings.invalidEmail;
      case 'user-disabled':
        return Strings.userDisabled;
      case 'user-not-found':
        return Strings.userNotFound;
      case 'wrong-password':
        return Strings.wrongPassword;
      case 'email-already-in-use':
      case 'account-exists-with-different-credential':
        return Strings.emailAlreadyInUse;
      case 'weak-password':
        return Strings.weakPassword;
      case 'invalid-credential':
      case 'operation-not-allowed':
      case 'ERROR_MISSING_GOOGLE_AUTH_TOKEN':
      default:
        return Strings.error;
    }
  }
}
