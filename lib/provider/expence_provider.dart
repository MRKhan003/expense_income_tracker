import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_and_income_tracker/expense_controller/my_expense.dart';
import 'package:expense_and_income_tracker/expense_controller/my_income.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ExpenceProvider with ChangeNotifier {
  List<Expense> expenses = [];
  List<Expense> get myExpense => expenses;
  List<MyIncome> income = [];
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
      print(total);
      print(income);
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }
}
