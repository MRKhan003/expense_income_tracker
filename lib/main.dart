import 'package:expense_and_income_tracker/authentications/signup_screen.dart';
import 'package:expense_and_income_tracker/firebase_options.dart';
import 'package:expense_and_income_tracker/provider/expence_provider.dart';
import 'package:expense_and_income_tracker/screens/expense_screen.dart';
import 'package:expense_and_income_tracker/screens/first_screen.dart';
import 'package:expense_and_income_tracker/screens/home_screen.dart';
import 'package:expense_and_income_tracker/screens/splash_screen.dart';
import 'package:expense_and_income_tracker/widgets/expense_fields.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ExpenceProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProfileImageProvider(),
        ),
      ],
      child: MyApp(),
    ),
  );
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
