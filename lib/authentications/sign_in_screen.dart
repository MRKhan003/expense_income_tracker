import 'package:expense_and_income_tracker/authentications/signup_screen.dart';
import 'package:expense_and_income_tracker/controllers/input_field_controller.dart';
import 'package:expense_and_income_tracker/screens/first_screen.dart';
import 'package:expense_and_income_tracker/widgets/inputFieldWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';

class UserLogin extends StatefulWidget {
  @override
  State<UserLogin> createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  Inputfieldcontroller controller = Inputfieldcontroller();
  RoundedLoadingButtonController buttonController =
      RoundedLoadingButtonController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Center(
            //   child: SvgPicture.asset(
            //     "assets/JACKPOTARENA.svg",
            //     height: 20,
            //   ),
            // ),
            // const SizedBox(
            //   height: 50,
            // ),
            Text(
              "LOGIN TO ACCOUNT",
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 25,
                right: 25,
                bottom: 10,
              ),
              child: InputFields(
                fieldText: "Email",
                textController: controller.emailController,
                keyboardType: TextInputType.emailAddress,
                hideText: false,
                fieldIcon: Icons.email_outlined,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 25,
                right: 25,
                bottom: 10,
              ),
              child: InputFields(
                fieldText: "Password",
                textController: controller.passwordController,
                keyboardType: TextInputType.visiblePassword,
                hideText: true,
                fieldIcon: Icons.visibility_off,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                right: 25,
              ),
              child: GestureDetector(
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => EmailScreen(),
                  //   ),
                  // );
                },
                child: Container(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Forgot Password?',
                    style: GoogleFonts.poppins(
                      color: const Color(0xffF8B31A),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            RoundedLoadingButton(
              controller: buttonController,
              resetAfterDuration: true,
              resetDuration: const Duration(seconds: 5),
              completionDuration: const Duration(seconds: 3),
              color: const Color(0xffF8B31A),
              onPressed: () {
                // if (controller.emailController.text.isEmpty &&
                //     controller.passwordController.text.isEmpty) {
                //   Fluttertoast.showToast(
                //       msg: "Fill all fields",
                //       toastLength: Toast.LENGTH_SHORT,
                //       gravity: ToastGravity.CENTER,
                //       timeInSecForIosWeb: 5,
                //       backgroundColor: Color(0xffF8F8F8),
                //       textColor: Colors.red,
                //       fontSize: 16.0);
                // } else {
                //   // Firebasefunctions().loggingIn(
                //   //   controller.emailController.text,
                //   //   controller.passwordController.text,
                //   //   context,
                //   // );
                // }
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FirstScreen(),
                  ),
                );
              },
              child: Text(
                'SIGN IN',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 30,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Dont have an account?",
                    style: GoogleFonts.poppins(
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AccountCreation(),
                        ),
                      );
                    },
                    child: Text(
                      "Sign up",
                      style: GoogleFonts.poppins(
                        color: const Color(0xffF8B31A),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
