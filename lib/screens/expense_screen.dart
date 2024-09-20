import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_and_income_tracker/expense_controller/my_expense.dart';
import 'package:expense_and_income_tracker/provider/expence_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
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
  @override
  void initState() {
    super.initState();
  }

  int total = 0, temp = 0;
  @override
  Widget build(BuildContext context) {
    var expenceProvider = Provider.of<ExpenceProvider>(context);
    return Scaffold(
      body: Column(
        children: [
          // Container(
          //   color: Color(
          //     0xffF8B31A,
          //   ),
          //   alignment: Alignment.center,
          //   child: Text(
          //     textAlign: TextAlign.center,
          //     DateFormat('EEE M-d-y').format(
          //       selectedDate,
          //     ),
          //     style: GoogleFonts.poppins(
          //       fontSize: 14,
          //       color: Colors.black,
          //     ),
          //   ),
          // ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: expenceProvider.myExpense.length,
              itemBuilder: (context, index) {
                double percent = (expenceProvider.myExpense[index].amount /
                        expenceProvider.total1) *
                    100;
                return Padding(
                  padding: const EdgeInsets.only(
                    bottom: 5,
                    left: 10,
                    right: 10,
                  ),
                  child: ListTile(
                    tileColor: expenceProvider.myExpense[index].category ==
                            'Cash'
                        ? Color.fromARGB(179, 235, 193, 193)
                        : expenceProvider.myExpense[index].category == 'Card'
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
                          expenceProvider.myExpense[index].category,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          '-' +
                              expenceProvider.myExpense[index].amount
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
                        expenceProvider.myExpense[index].date,
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
