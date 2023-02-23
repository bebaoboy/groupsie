import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:groupsie/helper/helper_function.dart';
import 'package:groupsie/service/database_service.dart';
import 'package:groupsie/shared/strings.dart';

class AuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  // login
  Future login({required String email, required String password}) async {
    try {
      late final User? user;
      if (emailValidate(email) == "username") {
        final result = await DatabaseService.getUserData(username: email);
        if (result.docs.length != 0) {
          user = (await firebaseAuth.signInWithEmailAndPassword(
                  email: result.docs[0]['email'], password: password))
              .user;
        } else {
          return Strings.userNotFound;
        }
      } else {
        user = (await firebaseAuth.signInWithEmailAndPassword(
                email: email, password: password))
            .user;
      }

      if (user != null) {
        return "true";
      }
      return "false";
    } on FirebaseAuthException catch (error) {
      log(error.message!);
      return determineError(error);
    }
  }

  getEmail(username) async {
    var s = "";
    await DatabaseService.getUserData(username: username).then((result) => {
          if (result.docs.length != 0) {s = result.docs[0]['email']}
        });

    return s;
  }

  emailValidate(email) {
    // log("validated");
    if (RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$").hasMatch(email)) {
      return "email";
    } else {
      return "username";
    }
  }

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
            .createUserData(username: username, email: email);
        return "true";
      }
      return "false";
    } on FirebaseAuthException catch (error) {
      log(error.message!);
      return determineError(error);
    }
  }

  Future signOut() async {
    try {
      await HelperFunctions.saveUserLoggedInInfo(isLoggedIn: false);
      await firebaseAuth.signOut();
    } catch (error) {
      return null;
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
