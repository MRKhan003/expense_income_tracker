import 'package:expense_and_income_tracker/expense_controller/my_expense.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
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
                double percent = (expenses[index].amount / 1090) * 100;
                return Padding(
                  padding: const EdgeInsets.only(
                    bottom: 5,
                    left: 10,
                    right: 10,
                  ),
                  child: ListTile(
                    tileColor: expenses[index].category == 'Food'
                        ? Color.fromARGB(179, 235, 193, 193)
                        : expenses[index].category == 'Fees'
                            ? Color.fromARGB(255, 186, 192, 228)
                            : Color.fromARGB(255, 198, 216, 177),
                    leading: CircularPercentIndicator(
                      radius: 20,
                      percent: percent / 100,
                      center: Text(
                        percent.toStringAsPrecision(3) + '%',
                        style: GoogleFonts.poppins(
                          fontSize: 8,
                        ),
                      ),
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
                          '-' + expenses[index].amount.toString() + ' RS',
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
