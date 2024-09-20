import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_and_income_tracker/controllers/income_controller.dart';
import 'package:expense_and_income_tracker/expense_controller/my_income.dart';
import 'package:expense_and_income_tracker/provider/expence_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class IncomeScreen extends StatefulWidget {
  IncomeScreen({super.key});

  @override
  State<IncomeScreen> createState() => _IncomeScreenState();
}

DateTime selectedDate1 = DateTime.now();

class _IncomeScreenState extends State<IncomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var incomeProvider = Provider.of<ExpenceProvider>(context);
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: incomeProvider.myIncome.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(
                    bottom: 5,
                    left: 10,
                    right: 10,
                  ),
                  child: ListTile(
                    tileColor: incomeProvider.myIncome[index].incomeType ==
                            'Register Credit Card Sales'
                        ? Color.fromARGB(179, 235, 193, 193)
                        : incomeProvider.myIncome[index].incomeType ==
                                'Register Cash Sales'
                            ? Color.fromARGB(255, 186, 192, 228)
                            : Color.fromARGB(255, 198, 216, 177),
                    leading: incomeProvider.myIncome[index].incomeType ==
                            'Register Credit Card Sales'
                        ? Icon(
                            Icons.credit_card_outlined,
                          )
                        : incomeProvider.myIncome[index].incomeType ==
                                'Register Cash Sales'
                            ? Icon(Icons.money_outlined)
                            : incomeProvider.myIncome[index].incomeType ==
                                    'Check Received from Vendor'
                                ? Icon(
                                    Icons.account_balance_outlined,
                                  )
                                : Icon(
                                    Icons.wallet_outlined,
                                  ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          incomeProvider.myIncome[index].incomeType,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          '+' +
                              incomeProvider.myIncome[index].amount.toString() +
                              ' RS',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    subtitle: Text(
                      DateFormat('EEE M-d-y').format(
                        incomeProvider.myIncome[index].time,
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
