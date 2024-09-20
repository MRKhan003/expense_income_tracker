import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_and_income_tracker/expense_controller/my_expense.dart';
import 'package:expense_and_income_tracker/expense_controller/my_income.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ExpenceProvider with ChangeNotifier {
  List<Expense> expenses = [];
  DateTime selectedDate = DateTime.now();
  List<Expense> filteredExpense = [];
  List<Expense> get myExpense => expenses;
  List<Expense> get thisFilterExpense {
    return filteredExpense.where((expense) {
      return expense.date.year == thisDate.year &&
          expense.date.month == thisDate.month &&
          expense.date.day == thisDate.day;
    }).toList();
  }

  DateTime get thisDate => selectedDate;
  List<MyIncome> income = [];
  DateTime incomeTime1 = DateTime.now();
  List<MyIncome> filteredIncome = [];
  List<MyIncome> get thisFilteredIncome {
    return filteredIncome.where((income) {
      return income.time.year == thisIncomeDate.year &&
          income.time.month == thisIncomeDate.month &&
          income.time.day == thisIncomeDate.day;
    }).toList();
  }

  DateTime get thisIncomeDate => incomeTime1;
  List<MyIncome> get myIncome => income;
  int size = 100;
  late String type, incomeType;
  late Timestamp time, incomeTime;
  late int money, incomeAmount;
  bool ref = true;
  int temp1 = 0, total1 = 0, temp = 0, total = 0;
  int running = 0;
  int get thisRunning => running;
  Future<bool> totalExpense() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('Expense')
          .get();
      snapshot.docs.forEach((doc) {
        type = doc['Expense Type'];
        time = doc['Time'];
        print('Here');
        money = doc['Amount'];
        Expense expense = Expense(
          type,
          money,
          time.toDate(),
        );
        expenses.add(expense);
        temp1 = doc['Amount'];
        total1 = total1 + temp1;
      });
      size = expenses.length;
      expenses.isEmpty ? ref == true : ref == false;
      running = 1;
      filteredExpense = expenses;
      print(total1);
      print(expenses);
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> totalIncome() async {
    try {
      print('Here1');
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('Income')
          .get();
      snapshot.docs.forEach((doc) {
        print('Here1');
        incomeType = doc['Income Type'];
        print('Here1');
        incomeTime = doc['Time'];
        print('Here1');
        incomeAmount = doc['Ammount'];
        MyIncome thisIncome = MyIncome(
          incomeType: incomeType,
          amount: incomeAmount,
          time: incomeTime.toDate(),
        );
        income.add(thisIncome);
        temp = doc['Ammount'];
        total = total + temp;
      });
      size = income.length;
      income.isEmpty ? ref == true : ref == false;
      running = 1;
      filteredIncome = income;
      print(total);
      print(income);
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }

  void updateSelectedDate(DateTime date) {
    print(date);
    selectedDate = date;
    print('update');
    print(thisFilterExpense);
    print(filteredExpense);
    notifyListeners(); // Notify listeners that the date has changed
  }

  void updateSelectedIncomeDate(DateTime date) {
    incomeTime1 = date;
    notifyListeners();
  }

  void addIncome(MyIncome income) {
    filteredIncome.add(income);
    notifyListeners(); // Notify listeners that
  }

  void addExpense(Expense expense) {
    filteredExpense.add(expense);
    notifyListeners(); // Notify listeners of new expense addition
  }
}

class ProfileImageProvider with ChangeNotifier {
  int running = 0;
  String profileImage = '';
  String get thisProfileImage => profileImage;
  getProfileImage() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('Users')
          .where(
            'UserID',
            isEqualTo: FirebaseAuth.instance.currentUser!.uid,
          )
          .get();
      snapshot.docs.forEach((doc) {
        profileImage = doc['ProfileImage'];
        running = 1;
      });
      notifyListeners();
      print(profileImage);
    } on FirebaseException catch (e) {
      Fluttertoast.showToast(
        msg: e.message.toString(),
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: Color(0xffF8F8F8),
        textColor: Colors.red,
        fontSize: 16.0,
      );
    }
  }
}
