import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:expense_and_income_tracker/authentications/sign_in_screen.dart';
import 'package:expense_and_income_tracker/controllers/input_field_controller.dart';
import 'package:expense_and_income_tracker/firebase/firebase_functions.dart';
import 'package:expense_and_income_tracker/widgets/inputFieldWidget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';

class AccountCreation extends StatefulWidget {
  @override
  State<AccountCreation> createState() => _AccountCreationState();
}

class _AccountCreationState extends State<AccountCreation> {
  Inputfieldcontroller controller = Inputfieldcontroller();

  RoundedLoadingButtonController buttonController =
      RoundedLoadingButtonController();

  //FirebaseAuth auth = FirebaseAuth.instance;

  //UserDetails details = UserDetails();

  bool? validate;

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
              "CREATE NEW ACCOUNT",
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
                fieldText: "User Name",
                textController: controller.userNameController,
                keyboardType: TextInputType.name,
                hideText: false,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 25,
                right: 25,
                bottom: 10,
              ),
              child: InputFields(
                fieldText: "Display Name",
                textController: controller.nameController,
                keyboardType: TextInputType.name,
                hideText: false,
              ),
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
                left: 25,
                right: 25,
                bottom: 10,
              ),
              child: InputFields(
                fieldText: "Confirm Password",
                textController: controller.passwordConfirmController,
                keyboardType: TextInputType.visiblePassword,
                hideText: true,
                fieldIcon: Icons.visibility_off,
              ),
            ),
            RoundedLoadingButton(
              controller: buttonController,
              resetAfterDuration: true,
              completionDuration: const Duration(seconds: 3),
              resetDuration: const Duration(seconds: 5),
              color: const Color(0xffF8B31A),
              onPressed: () {
                if (controller.nameController.text.isNotEmpty &&
                    controller.emailController.text.isNotEmpty &&
                    controller.userNameController.text.isNotEmpty &&
                    controller.passwordController.text.isNotEmpty &&
                    controller.passwordConfirmController.text.isNotEmpty &&
                    controller.passwordController.text ==
                        controller.passwordConfirmController.text) {
                  FirebaseFunctions().createUser(
                    controller.userNameController.text,
                    controller.nameController.text,
                    controller.emailController.text,
                    controller.passwordController.text,
                    context,
                  );
                } else {
                  Fluttertoast.showToast(
                      msg: "Fill all fields",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 5,
                      backgroundColor: Color(0xffF8F8F8),
                      textColor: Colors.red,
                      fontSize: 16.0);
                }
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => UserLogin(),
                //   ),
                // );
              },
              child: Text(
                'SIGN UP',
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
                bottom: 10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "Already have an account?",
                    style: GoogleFonts.poppins(
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserLogin(),
                        ),
                      );
                    },
                    child: Text(
                      "Sign in",
                      style: GoogleFonts.poppins(
                        color: const Color(0xffF8B31A),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
