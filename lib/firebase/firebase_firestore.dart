import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_and_income_tracker/firebase/user_details.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UserDatabase {
  Future<bool> sendUserData(UserDetails current_user) async {
    try {
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(current_user.userID)
          .set({
        'UserID': current_user.userID,
        'DisplayName': current_user.displayName,
        'UserName': current_user.userName,
        'UserEmail': current_user.email,
      });
      Fluttertoast.showToast(
        msg: "Account Created Successfully",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: Color(0xffF8F8F8),
        textColor: Colors.green,
        fontSize: 16.0,
      );
      return true;
    } on FirebaseException catch (e) {
      Fluttertoast.showToast(
        msg: e.message!,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: Color(0xffF8F8F8),
        textColor: Colors.red,
        fontSize: 16.0,
      );
      return false;
    }
  }
}
