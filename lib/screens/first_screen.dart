import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:expense_and_income_tracker/authentications/signup_screen.dart';
import 'package:expense_and_income_tracker/provider/expence_provider.dart';
import 'package:expense_and_income_tracker/screens/expense_screen.dart';
import 'package:expense_and_income_tracker/screens/home_screen.dart';
import 'package:expense_and_income_tracker/screens/income_screen.dart';
import 'package:expense_and_income_tracker/widgets/drawerItems.dart';
import 'package:expense_and_income_tracker/widgets/expense_fields.dart';
import 'package:expense_and_income_tracker/widgets/income_fields.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';

class FirstScreen extends StatefulWidget {
  FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  @override
  void initState() {
    getUserName();
    super.initState();
  }

  final FirebaseStorage _storage = FirebaseStorage.instance;
  bool loaded = false;
  String? profileImage;
  File? image;
  int running = 0;
  String? userName;
  final ImagePicker _picker = ImagePicker();
  Future<bool> getUserName() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('Users')
          .where(
            'UserID',
            isEqualTo: FirebaseAuth.instance.currentUser!.uid,
          )
          .get();
      snapshot.docs.forEach((doc) {
        setState(() {
          userName = doc['DisplayName'];
        });
      });
      return true;
    } catch (e) {
      return false;
    }
  }

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
      //final fileName = profileImage;
      await _storage
          .ref()
          .child(FirebaseAuth.instance.currentUser!.uid)
          .delete();
    } on FirebaseException catch (e) {
      Fluttertoast.showToast(
        msg: e.message!,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: const Color(0xffF8F8F8),
        textColor: Colors.red,
        fontSize: 16.0,
      );
    }
  }

  Future<String?> _uploadImage(File image) async {
    try {
      final fileName =
          'ProfileImages/${FirebaseAuth.instance.currentUser!.uid}';

      final ref = _storage.ref().child(fileName);

      final uploadTask = await ref.putFile(image);

      final downloadUrl = await uploadTask.ref.getDownloadURL();

      return downloadUrl;
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Failed to upload image",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: const Color(0xffF8F8F8),
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
        //Update the user's Firestore document with the image URL
        deleteImage();
        await FirebaseFirestore.instance
            .collection('Users')
            .doc(FirebaseAuth.instance.currentUser!
                .uid) // Replace with the current user's document ID
            .update({'ProfileImage': imageUrl});
        //getProfileImage();
        setState(() {
          running = 0;
        });
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
        backgroundColor: const Color(0xffF8F8F8),
        textColor: Colors.black,
        fontSize: 16.0,
      );
    }
  }

  int selectedPage = 0;
  List<String> barTitle = [
    'My Wallet',
    'Expenses',
    'Income',
  ];

  List<Widget> pagesList = [
    HomeScreen(),
    ExpenseScreen(),
    IncomeScreen(),
  ];
  providerFunction() {
    if (loaded == false) {
      var expenseProvider = Provider.of<ExpenceProvider>(context, listen: true);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        expenseProvider.totalExpense();
        expenseProvider.totalIncome();
      });
      var imageProvider =
          Provider.of<ProfileImageProvider>(context, listen: true);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        imageProvider.getProfileImage();
      });
    }
    setState(() {
      loaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    providerFunction();
    var getImage = Provider.of<ProfileImageProvider>(context);
    //var getList = Provider.of<ExpenceProvider>(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: selectedPage == 1 || selectedPage == 2 ? 70 : 50,
        title: Text(
          selectedPage == 1
              ? '${barTitle[selectedPage]} \n ${DateFormat('EEE M-d-y').format(
                  selectedDate,
                )}'
              : selectedPage == 2
                  ? '${barTitle[selectedPage]} \n ${DateFormat('EEE M-d-y').format(
                      selectedDate1,
                    )}'
                  : barTitle[selectedPage],
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            fontSize: selectedPage == 1 || selectedPage == 2 ? 18 : 20,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: IconButton(
                onPressed: () async {
                  //_selectDate1(context);
                  DateTime? selector = await showDatePicker(
                    context: context,
                    initialDate: selectedDate,
                    firstDate: DateTime(2000, 1),
                    lastDate: DateTime(2100),
                  );
                  setState(() {
                    selectedPage == 1
                        ? selectedDate = selector!
                        : selectedDate1 = selector!;
                  });
                  if (selector != null) {
                    selectedPage == 1
                        ? Provider.of<ExpenceProvider>(context, listen: false)
                            .updateSelectedDate(selectedDate)
                        : Provider.of<ExpenceProvider>(context, listen: false)
                            .updateSelectedIncomeDate(selectedDate1);
                  }
                  //getList.updateSelectedDate(selectedDate);
                },
                icon: const Icon(
                  Icons.calendar_month,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
        backgroundColor: const Color(0xffF8B31A),
        surfaceTintColor: Colors.white,
      ),
      drawer: AbsorbPointer(
        absorbing: running == 1 ? true : false,
        child: Drawer(
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
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      running == 1
                          ? const CircularProgressIndicator(
                              color: Color(0xffF8B31A),
                            )
                          : GestureDetector(
                              onTap: () => _getImageFromGallery(),
                              child: CircleAvatar(
                                maxRadius: 40,
                                minRadius: 35,
                                foregroundImage: getImage.thisProfileImage ==
                                        null
                                    ? const AssetImage(
                                        'assets/dp.jpg',
                                      )
                                    : NetworkImage(getImage.thisProfileImage),
                              ),
                            ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
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
                            userName ?? 'user',
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
              const Divider(),
              Expanded(
                //flex: 1,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ExpenseFields(),
                      ),
                    );
                  },
                  child: Draweritems(
                    title: 'Add Expense',
                    icon: Icons.monetization_on,
                    cardColor: Colors.white70,
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const IncomeFields(),
                    ),
                  ),
                  child: Draweritems(
                    title: 'Add Income',
                    icon: Icons.money,
                    cardColor: Colors.white70,
                  ),
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 10,
                  left: 10,
                  right: 10,
                ),
                child: RoundedLoadingButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AccountCreation(),
                      ),
                    );
                  },
                  color: Colors.red,
                  controller: buttonController,
                  child: Text(
                    'Logout',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: DoubleBackToCloseApp(
        snackBar: const SnackBar(
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
        items: const [
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
          color: const Color(
            0xffF8B31A,
          ),
        ),
        selectedItemColor: const Color(
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
