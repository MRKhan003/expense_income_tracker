import 'dart:io';

import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:expense_and_income_tracker/screens/expense_screen.dart';
import 'package:expense_and_income_tracker/screens/home_screen.dart';
import 'package:expense_and_income_tracker/screens/income_screen.dart';
import 'package:expense_and_income_tracker/widgets/drawerItems.dart';
import 'package:expense_and_income_tracker/widgets/expense_fields.dart';
import 'package:expense_and_income_tracker/widgets/income_fields.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';

class FirstScreen extends StatefulWidget {
  FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  String? profileImage;
  File? image;
  int running = 0;
  final ImagePicker _picker = ImagePicker();
  Future<void> _getImageFromGallery() async {
    //final picker = ImagePicker();
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
      });
    }
    setState(() {
      running = 1;
    });
    _updateProfileImage();
  }

  void deleteImage() async {
    try {
      final fileName = profileImage;
      //await widget._storage.ref().child(fileName).delete();
    } catch (e) {
      print(e);
    }
  }

  Future<String?> _uploadImage(File image) async {
    try {
      // final fileName = 'ProfileImage/${FirebaseAuth.instance.currentUser!.uid}';

      // final ref = widget._storage.ref().child(fileName);

      // final uploadTask = await ref.putFile(image);

      // final downloadUrl = await uploadTask.ref.getDownloadURL();

      // return downloadUrl;
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Failed to upload image",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: Color(0xffF8F8F8),
        textColor: Colors.red,
        fontSize: 16.0,
      );
      return null;
    }
  }

  Future<void> _updateProfileImage() async {
    if (image != null) {
      final imageUrl = await _uploadImage(image!);
      if (imageUrl != null) {
        // Update the user's Firestore document with the image URL
        //deleteImage();
        // await widget._firestore
        //     .collection('Users')
        //     .doc(
        //       widget.currentUser,
        //     ) // Replace with the current user's document ID
        //     .update({'ProfileImage': imageUrl});
        // getProfileImage();
        // setState(() {
        //   widget.running = 0;
        // });
      }
    } else {
      setState(() {
        running = 0;
      });
      Fluttertoast.showToast(
        msg: "Please select an image",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: Color(0xffF8F8F8),
        textColor: Colors.black,
        fontSize: 16.0,
      );
    }
  }

  void _selectDate1(BuildContext context) async {
    final DateTime? selector = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000, 1),
      lastDate: DateTime(2100),
    );
    if (selector != null && selector != DateTime.now()) {
      setState(() {
        selectedDate = selector;
      });
    }
  }

  DateTime selectedDate1 = DateTime.now();

  int selectedPage = 0;
  List<String> barTitle = [
    'My Wallet',
    'Expenses',
    'Income',
    'Add Expense',
  ];

  List<Widget> pagesList = [
    HomeScreen(),
    ExpenseScreen(),
    IncomeScreen(),
    //ExpenseFields(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          barTitle[selectedPage],
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: IconButton(
                onPressed: () => _selectDate1(context),
                icon: Icon(
                  Icons.calendar_month,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
        backgroundColor: Color(0xffF8B31A),
        surfaceTintColor: Colors.white,
      ),
      drawer: Drawer(
        child: Column(
          children: [
            Container(
              height: 150,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 50,
                  left: 10,
                  right: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () => _getImageFromGallery(),
                      child: CircleAvatar(
                        maxRadius: 40,
                        minRadius: 35,
                        foregroundImage: AssetImage(
                          'assets/dp.jpg',
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome',
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Roshaan',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Divider(),
            Expanded(
              //flex: 1,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ExpenseFields(),
                    ),
                  );
                },
                child: Draweritems(
                  title: 'Add Expense',
                  icon: Icons.monetization_on,
                  cardColor: Colors.lightBlue,
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => IncomeFields(),
                  ),
                ),
                child: Draweritems(
                  title: 'Add Income',
                  icon: Icons.money,
                  cardColor: Colors.lightGreenAccent,
                ),
              ),
            ),
            Expanded(
              child: Draweritems(
                title: 'Show Expense',
                icon: Icons.do_not_touch,
                cardColor: Colors.lightBlueAccent,
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 10,
              ),
              child: RoundedLoadingButton(
                controller: buttonController,
                onPressed: () {},
                child: Text(
                  'Logout',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                  ),
                ),
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
      body: DoubleBackToCloseApp(
        snackBar: SnackBar(
          content: Text(
            'Back again to leave.',
          ),
        ),
        child: pagesList[selectedPage],
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 1,
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedPage,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.monetization_on,
              ),
              label: 'Expense'),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.money,
            ),
            label: 'Income',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(
          //     Icons.money,
          //   ),
          //   label: 'Add',
          // ),
        ],
        onTap: (value) => setState(
          () {
            selectedPage = value;
          },
        ),
        selectedLabelStyle: GoogleFonts.poppins(
          color: Color(
            0xffF8B31A,
          ),
        ),
        selectedItemColor: Color(
          0xffF8B31A,
        ),
        unselectedLabelStyle: GoogleFonts.poppins(
          color: Colors.grey,
        ),
        showUnselectedLabels: true,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}
