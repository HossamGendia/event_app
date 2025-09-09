// import 'dart:developer';
//
// import 'package:event_app/core/services/snackbar_services.dart';
// import 'package:firebase_auth/firebase_auth.dart';
//
//
// abstract class FirebaseAuthenticationUtils{
//
//   static Future<bool> createUserWithEmailAndPassword({
//     required String emailAddress,
//     required String password,
// })async{
//     try {
//       final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
//         email: emailAddress,
//         password: password,
//       );
//
//
//       log(credential.user!.uid);
//
//       SnackBarService.showSuccessMessage("Account Created Successfully");
//       return Future.value(true);
//     } on FirebaseAuthException catch (e) {
//       if (e.code == 'weak-password') {
//         print('The password provided is too weak.');
//         SnackBarService.showErrorMessage(e.message ?? "Something went wrong");
//       } else if (e.code == 'email-already-in-use') {
//         print('The account already exists for that email.');
//         SnackBarService.showErrorMessage(e.message ?? "Something went wrong");
//       }
//       return Future.value(false);
//     } catch (e) {
//       print(e);
//       SnackBarService.showErrorMessage("Something went wrong");
//       return Future.value(false);
//     }
//   }
//
//
//   static Future<bool> signInWithEmailAndPassword({
//     required String emailAddress,
//     required String password,
//   })async{
//     try {
//       final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
//         email: emailAddress,
//         password: password,
//       );
//
//       SnackBarService.showSuccessMessage("Logged In Successfully");
//       return Future.value(true);
//     } on FirebaseAuthException catch (e) {
//       log(e.code);
//       if (e.code == 'weak-password') {
//         print('The password provided is too weak.');
//         SnackBarService.showErrorMessage(e.message ?? "Something went wrong");
//       } else if (e.code == 'invalid-credential') {
//         print('The account already exists for that email.');
//         SnackBarService.showErrorMessage(e.message ?? "Something went wrong");
//       }
//       return Future.value(false);
//     } catch (e) {
//       print(e);
//       SnackBarService.showErrorMessage("Something went wrong");
//       return Future.value(false);
//     }
//   }
// }
//

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../routes/page_routes_name.dart';
import '../services/snackbar_services.dart';

abstract class FirebaseAuthenticationUtils {
  static Future<bool> createUserWithEmailAndPassword({
    required String emailAddress,
    required String password,
  }) async {
    try {
      final _ = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      // log(credential.user!.uid);
      SnackBarService.showSuccessMessage("Created Successfully");
      return Future.value(true);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        SnackBarService.showErrorMessage(
          e.message ?? "Something Went Wrong",
        );
      } else if (e.code == 'email-already-in-use') {
        SnackBarService.showErrorMessage(
          e.message ?? "Something Went Wrong",
        );
      }
      return Future.value(false);
    } catch (e) {
      // SnackbarService.showErrorNotification("Something Went Wrong");
      return Future.value(false);
    }
  }
  static Future<bool> signInWithEmailAndPassword({
    required String emailAddress,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      SnackBarService.showSuccessMessage("Login Successfully");
      return true;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-email':
          SnackBarService.showErrorMessage("Invalid email format.");
          break;
        case 'user-disabled':
          SnackBarService.showErrorMessage("This account has been disabled.");
          break;
        case 'invalid-credential': // covers both user-not-found & wrong-password
          SnackBarService.showErrorMessage("Invalid email or password.");
          break;
        default:
          SnackBarService.showErrorMessage("Login failed. ${e.message}");
      }

      return false;
    } catch (e) {
      SnackBarService.showErrorMessage("Something went wrong.");
      return false;
    }
  }

  // static Future<bool> signInWithEmailAndPassword({
  //   required String emailAddress,
  //   required String password,
  // }) async {
  //   try {
  //     final _ = await FirebaseAuth.instance.signInWithEmailAndPassword(
  //       email: emailAddress,
  //       password: password,
  //     );
  //     SnackbarService.showSuccessNotification("Login Successfully");
  //     return Future.value(true);
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'user-not-found') {
  //       SnackbarService.showErrorNotification(
  //         e.message ?? "Something Went Wrong",
  //       );
  //     } else if (e.code == 'wrong-password') {
  //       SnackbarService.showErrorNotification(
  //         e.message ?? "Something Went Wrong",
  //       );
  //     }
  //     return Future.value(false);
  //   } catch (e) {
  //     // SnackbarService.showErrorNotification("Something Went Wrong");
  //     return Future.value(false);
  //   }
  // }
  // static Future<bool> signInWithGoogle() async {
  //   try {
  //     final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  //     if (googleUser == null) {
  //       return false; // user canceled
  //     }
  //
  //     final GoogleSignInAuthentication googleAuth =
  //     await googleUser.authentication;
  //
  //     final credential = GoogleAuthProvider.credential(
  //       accessToken: googleAuth.accessToken,
  //       idToken: googleAuth.idToken,
  //     );
  //
  //     await FirebaseAuth.instance.signInWithCredential(credential);
  //
  //     SnackBarService.showSuccessMessage("Login with Google Successfully");
  //     return true;
  //   } catch (e) {
  //     SnackBarService.showErrorMessage("Google Sign-In Failed");
  //     return false;
  //   }
  // }
}