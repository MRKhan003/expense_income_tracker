import 'dart:async';

import 'package:expense_and_income_tracker/authentications/signup_screen.dart';
import 'package:expense_and_income_tracker/screens/first_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void moveToIntro() {
    if (FirebaseAuth.instance.currentUser != null) {
      Timer(
        Duration(
          seconds: 3,
        ),
        () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => FirstScreen(),
            ),
          );
        },
      );
    } else {
      Timer(
        Duration(
          seconds: 3,
        ),
        () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => AccountCreation(),
            ),
          );
        },
      );
    }
  }

  @override
  void initState() {
    moveToIntro();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            Spacer(
              flex: 1,
            ),
            Text(
              'Expense Tracker',
            ),
            CircularProgressIndicator(
              color: Color(0xffFF6007),
            ),
            const Spacer(
              flex: 1,
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 30,
              ),
              child: Text(
                "Powered by Corise",
                textAlign: TextAlign.end,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
