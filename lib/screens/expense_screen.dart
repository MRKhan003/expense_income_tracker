import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:expense_and_income_tracker/expense_controller/my_expense.dart';
import 'package:expense_and_income_tracker/widgets/drawerItems.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';

class ExpenseScreen extends StatefulWidget {
  ExpenseScreen({super.key});

  @override
  State<ExpenseScreen> createState() => _ExpenseScreenState();
}

RoundedLoadingButtonController buttonController =
    RoundedLoadingButtonController();
DateTime selectedDate = DateTime.now();

class _ExpenseScreenState extends State<ExpenseScreen> {
  // void _selectDate(BuildContext context) async {
  //   final DateTime? selector = await showDatePicker(
  //     context: context,
  //     initialDate: selectedDate,
  //     firstDate: DateTime(2000, 1),
  //     lastDate: DateTime(2100),
  //   );
  //   if (selector != null && selector != DateTime.now()) {
  //     setState(() {
  //       selectedDate = selector;
  //     });
  //   }
  // }

  List<Expense> expenses = [
    Expense(
      'Food',
      200.0,
      DateTime.now().subtract(
        const Duration(days: 1),
      ),
    ),
    Expense(
      'Food',
      140.0,
      DateTime.now().subtract(
        const Duration(days: 3),
      ),
    ),
    Expense(
      'Fees',
      200.0,
      DateTime.now().subtract(
        const Duration(days: 1),
      ),
    ),
    Expense(
      'Transportation',
      100.0,
      DateTime.now().subtract(
        const Duration(days: 3),
      ),
    ),
    Expense(
      'Shopping',
      300.0,
      DateTime.now().subtract(
        const Duration(days: 8),
      ),
    ),
    Expense(
      'Entertainment',
      150.0,
      DateTime.now().subtract(
        const Duration(days: 15),
      ),
    ),
    // Add more expenses with dates
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: Color(
              0xffF8B31A,
            ),
            alignment: Alignment.center,
            child: Text(
              textAlign: TextAlign.center,
              DateFormat('EEE M-d-y').format(
                selectedDate,
              ),
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: expenses.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(
                    bottom: 10,
                  ),
                  child: ListTile(
                    tileColor: expenses[index].category == 'Food'
                        ? Colors.amber
                        : expenses[index].category == 'Fees'
                            ? Colors.blue
                            : Colors.lightGreen,
                    leading: Icon(
                      Icons.food_bank,
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          expenses[index].category,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          expenses[index].amount.toString() + ' RS',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    subtitle: Text(
                      DateFormat('M-d-y').format(
                        expenses[index].date,
                      ),
                      style: GoogleFonts.poppins(
                        fontSize: 12,
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
