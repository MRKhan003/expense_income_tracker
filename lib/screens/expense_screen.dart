import 'package:expense_and_income_tracker/expense_controller/my_expense.dart';
import 'package:expense_and_income_tracker/provider/expence_provider.dart';
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

  String truncateString(String text, int maxLength) {
    return text.length > maxLength
        ? '${text.substring(0, maxLength)}...'
        : text;
  }

  int total = 0, temp = 0;

  @override
  Widget build(BuildContext context) {
    var expenceProvider = Provider.of<ExpenceProvider>(context);
    final expenses = expenceProvider.thisFilterExpense;
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              expenses.isEmpty
                  ? const Center(
                      child: Text(
                        'No Expenses',
                      ),
                    )
                  : const SizedBox(),
              Container(
                child: TextButton(
                  child: Text('View all expenses'),
                  onPressed: () {},
                ),
              )
            ],
          ),
          expenses.isNotEmpty
              ? Expanded(
                  child: ListView.builder(
                    itemCount: expenses.length,
                    itemBuilder: (context, index) {
                      double percent =
                          (expenses[index].amount / expenceProvider.total1) *
                              100;
                      return Padding(
                        padding: const EdgeInsets.only(
                          bottom: 5,
                          left: 10,
                          right: 10,
                        ),
                        child: ListTile(
                          tileColor: expenses[index].category == 'Cash'
                              ? const Color.fromARGB(179, 235, 193, 193)
                              : expenses[index].category == 'Card'
                                  ? const Color.fromARGB(255, 186, 192, 228)
                                  : const Color.fromARGB(255, 198, 216, 177),
                          leading: CircularPercentIndicator(
                            radius: 20,
                            percent: percent / 100,
                            center: Text(
                              '${percent.toStringAsPrecision(3)}%',
                              style: GoogleFonts.poppins(
                                fontSize: 8,
                              ),
                            ),
                          ),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                truncateString(
                                  expenses[index].category,
                                  25,
                                ),
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                '-${expenses[index].amount} RS',
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          subtitle: Text(
                            DateFormat('EEE M-d-y').format(
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
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
