import 'package:expense_and_income_tracker/authentications/signup_screen.dart';
import 'package:expense_and_income_tracker/screens/expense_screen.dart';
import 'package:expense_and_income_tracker/screens/first_screen.dart';
import 'package:expense_and_income_tracker/screens/home_screen.dart';
import 'package:expense_and_income_tracker/screens/splash_screen.dart';
import 'package:expense_and_income_tracker/widgets/expense_fields.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SplashScreen(),
    );
  }
}
