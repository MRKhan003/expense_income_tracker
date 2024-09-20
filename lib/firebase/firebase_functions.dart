import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_and_income_tracker/authentications/sign_in_screen.dart';
import 'package:expense_and_income_tracker/firebase/firebase_firestore.dart';
import 'package:expense_and_income_tracker/firebase/user_details.dart';
import 'package:expense_and_income_tracker/screens/first_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FirebaseFunctions with ChangeNotifier {
  UserDetails userDetails = UserDetails();
  Future<bool> isDisplayNameTaken(String? displayName) async {
    final nameResult = await FirebaseFirestore.instance
        .collection('Users')
        .where('DisplayName', isEqualTo: displayName)
        .get();
    print('User name check');
    return nameResult.docs.isNotEmpty;
  }

  Future<bool> createUser(String userName, String displayName, String email,
      String password, BuildContext context) async {
    bool isTakenName;
    isTakenName = await isDisplayNameTaken(displayName);
    if (isTakenName) {
      Fluttertoast.showToast(
        msg: 'Display name already in use',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: Color(0xffF8F8F8),
        textColor: Colors.red,
        fontSize: 16.0,
      );
      return false;
    } else {
      try {
        UserCredential credential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        if (credential.user != null) {
          userDetails.userID = credential.user!.uid;
          userDetails.displayName = displayName;
          userDetails.userName = userName;
          userDetails.email = credential.user!.email;
        }
        UserDatabase().sendUserData(userDetails);
        navigateToNextScreenAfterSignup(context);
        return true;
      } on FirebaseException catch (e) {
        if (e.code == 'weak-password') {
          Fluttertoast.showToast(
            msg: 'Use a strong password',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 3,
            backgroundColor: Color(0xffF8F8F8),
            textColor: Colors.red,
            fontSize: 16.0,
          );
          return false;
        } else if (e.code == 'email-already-in-use') {
          Fluttertoast.showToast(
            msg: 'Email already in use',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 5,
            backgroundColor: Color(0xffF8F8F8),
            textColor: Colors.red,
            fontSize: 16.0,
          );
          return false;
        } else if (e.code == 'network-request-failed') {
          Fluttertoast.showToast(
            msg: 'Internet Connection Failed',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 5,
            backgroundColor: Color(0xffF8F8F8),
            textColor: Colors.red,
            fontSize: 16.0,
          );
          return false;
        }
        return false;
      } catch (e) {
        Fluttertoast.showToast(
          msg: e.toString(),
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 5,
          backgroundColor: Color(0xffF8F8F8),
          textColor: Colors.red,
          fontSize: 16.0,
        );
        return false;
      }
    }
  }

  Future<bool> userLogin(
      String email, String password, BuildContext context) async {
    try {
      UserCredential credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (credential.user != null) {
        Fluttertoast.showToast(
          msg: "Welcome back " +
              await FirebaseFirestore.instance
                  .collection('Users')
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .get()
                  .then((DocumentSnapshot doc) {
                return doc['DisplayName'];
              }),
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Color(0xffF8F8F8),
          textColor: Colors.green,
          fontSize: 16.0,
        );
        navigateToNextScreenAfterLogin(context);
        return true;
      } else {
        print('Error');
        return false;
      }
    } on FirebaseException catch (e) {
      Fluttertoast.showToast(
        msg: e.message!,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: Color(0xffF8F8F8),
        textColor: Colors.red,
        fontSize: 16.0,
      );
      return false;
    }
  }

  Future<bool> logout(BuildContext context) async {
    try {
      FirebaseAuth.instance.signOut();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => UserLogin(),
        ),
      );
      return true;
    } on FirebaseException catch (e) {
      Fluttertoast.showToast(
        msg: e.message!,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: Color(0xffF8F8F8),
        textColor: Colors.red,
        fontSize: 16.0,
      );
      return false;
    }
  }
}

void navigateToNextScreenAfterSignup(BuildContext context) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => UserLogin(),
    ),
  );
}

void navigateToNextScreenAfterLogin(BuildContext context) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => FirstScreen(),
    ),
  );
}
