import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_and_income_tracker/expense_controller/my_expense.dart';
import 'package:expense_and_income_tracker/provider/expence_provider.dart';
import 'package:expense_and_income_tracker/widgets/drawerItems.dart';
import 'package:expense_and_income_tracker/widgets/expense_chart.dart';
import 'package:expense_and_income_tracker/widgets/expense_fields.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';

class HomeScreen extends StatefulWidget {
  int size = 100;
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  String selectedPeriod = 'Last 7 Days';
  int total1 = 0, temp1 = 0;
  double total = 0.0;
  double temp = 0.0;
  double avg = 0.0, avg1 = 0.0;
  bool isSelected = false;
  RoundedLoadingButtonController buttonController =
      RoundedLoadingButtonController();
  int listLength = 1;
  int running = 0;
  bool ref = true;
  String listLengthText = 'View All';

  void totalAmount(List<Expense> filterExpenseList, int index) {
    temp = 0;
    total = 0;
    avg = 0;
    for (var i = 0; i < filterExpenseList.length; i++) {
      temp = temp + filterExpenseList[index].amount;
      index++;
    }
    setState(() {
      total = temp;
      if (selectedPeriod == 'Last 7 Days') {
        avg = total / 7;
      } else if (selectedPeriod == 'Last Month') {
        avg = total / 30;
      }
    });
  }

  void defaultValue(List<Expense> defaultExpense, int index) {
    total1 = 0;
    temp1 = 0;
    avg1 = 0.0;
    for (var i = 0; i < defaultExpense.length; i++) {
      temp1 = temp1 + defaultExpense[index].amount;
      index++;
    }
    setState(() {
      total1 = temp1;
      avg1 = total1 / 7;
    });
  }

  List<Expense> filterExpenses(List<Expense> allExpenses, String period) {
    DateTime now = DateTime.now();
    late DateTime startDate;

    if (period == 'Last 7 Days') {
      startDate = now.subtract(const Duration(days: 7));
    } else if (period == 'Last Month') {
      startDate = DateTime(now.year, now.month - 1, now.day);
    }
    return allExpenses
        .where(
          (expense) => expense.date.isAfter(
            startDate,
          ),
        )
        .toList();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var expenseProvider = Provider.of<ExpenceProvider>(context);
    defaultValue(
      expenseProvider.myExpense,
      0,
    );
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 10,
              bottom: 10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextButton(
                  style: ButtonStyle(
                    side: WidgetStatePropertyAll(
                      BorderSide(
                        color: isSelected == false
                            ? Color(0xffF8B31A)
                            : Colors.grey,
                      ),
                    ),
                    backgroundColor: WidgetStatePropertyAll(
                      Color(
                        0xffF8F8F8,
                      ),
                    ),
                    elevation: WidgetStatePropertyAll(
                      50,
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      selectedPeriod = 'Last 7 Days';
                      totalAmount(
                        filterExpenses(
                          expenseProvider.myExpense,
                          selectedPeriod,
                        ),
                        0,
                      );
                      isSelected = false;
                    });
                  },
                  child: Text(
                    'Weekly',
                    style: GoogleFonts.poppins(
                      color: isSelected == false ? Colors.black : Colors.grey,
                    ),
                  ),
                ),
                TextButton(
                  style: ButtonStyle(
                    side: WidgetStatePropertyAll(
                      BorderSide(
                        color: isSelected == true
                            ? Color(0xffF8B31A)
                            : Colors.grey,
                      ),
                    ),
                    backgroundColor: WidgetStatePropertyAll(
                      Color(
                        0xffF8F8F8,
                      ),
                    ),
                    elevation: WidgetStatePropertyAll(
                      50,
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      selectedPeriod = 'Last Month';
                      totalAmount(
                        filterExpenses(
                          expenseProvider.myExpense,
                          selectedPeriod,
                        ),
                        0,
                      );
                      isSelected = true;
                    });
                  },
                  child: Text(
                    'Monthly',
                    style: GoogleFonts.poppins(
                      color: isSelected == true ? Colors.black : Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 10,
              right: 10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  selectedPeriod,
                  style: GoogleFonts.poppins(
                    color: Colors.grey,
                  ),
                ),
                Text(
                  'Avg Day',
                  style: GoogleFonts.poppins(
                    color: Colors.grey,
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 10,
              right: 10,
              bottom: 10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  total < 1
                      ? total1.toStringAsFixed(2)
                      : total.toStringAsFixed(2),
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  avg < 1 ? avg1.toStringAsFixed(2) : avg.toStringAsFixed(2),
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                )
              ],
            ),
          ),
          expenseProvider.thisRunning == 0
              ? Center(
                  child: CircularProgressIndicator(
                    color: Color(
                      0xffF8B31A,
                    ),
                  ),
                )
              : Expanded(
                  child: ExpenseChart(
                    expenses: filterExpenses(
                      expenseProvider.myExpense,
                      selectedPeriod,
                    ),
                  ),
                ),
          const SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 15,
                ),
                child: Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Recent Expenses:',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  right: 15,
                ),
                child: Container(
                  alignment: Alignment.topLeft,
                  child: TextButton(
                    onPressed: () => setState(() {
                      listLengthText == 'View All'
                          ? listLength = expenseProvider.myExpense.length
                          : listLength = 1;
                      listLengthText == 'View All'
                          ? listLengthText = 'Hide'
                          : listLengthText = 'View All';
                    }),
                    child: Text(
                      listLengthText,
                      style: GoogleFonts.poppins(
                        color: Colors.blueAccent,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          expenseProvider.thisRunning == 0
              ? SizedBox()
              : expenseProvider.myExpense.isEmpty
                  ? Center(
                      child: Text(
                        'No expense added',
                      ),
                    )
                  : Expanded(
                      child: ListView.builder(
                        itemCount: listLength,
                        itemBuilder: (context, index) {
                          return Material(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                bottom: 5,
                                left: 10,
                                right: 10,
                              ),
                              child: ListTile(
                                tileColor: expenseProvider
                                            .myExpense[index].category ==
                                        'Cash'
                                    ? Color.fromARGB(179, 235, 193, 193)
                                    : expenseProvider
                                                .myExpense[index].category ==
                                            'Card'
                                        ? Color.fromARGB(255, 186, 192, 228)
                                        : Color.fromARGB(255, 198, 216, 177),
                                leading:
                                    expenseProvider.myExpense[index].category ==
                                            'Cash'
                                        ? Icon(
                                            Icons.money_outlined,
                                          )
                                        : expenseProvider.myExpense[index]
                                                    .category ==
                                                'Card'
                                            ? Icon(Icons.credit_card_outlined)
                                            : expenseProvider.myExpense[index]
                                                        .category ==
                                                    'Cheque'
                                                ? Icon(
                                                    Icons.payment_outlined,
                                                  )
                                                : expenseProvider
                                                            .myExpense[index]
                                                            .category ==
                                                        'Money added to ATM'
                                                    ? Icon(
                                                        Icons
                                                            .account_balance_outlined,
                                                      )
                                                    : Icon(
                                                        Icons.money_outlined,
                                                      ),
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      expenseProvider.myExpense[index].category,
                                      style: GoogleFonts.poppins(
                                        fontSize: 14,
                                      ),
                                    ),
                                    Text(
                                      '-' +
                                          expenseProvider
                                              .myExpense[index].amount
                                              .toString() +
                                          ' RS',
                                      style: GoogleFonts.poppins(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                                subtitle: Text(
                                  DateFormat('EEE M-d-y').format(
                                      expenseProvider.myExpense[index].date),
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
        ],
      ),
    );
  }
}
