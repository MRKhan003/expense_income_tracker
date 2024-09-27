import 'package:expense_and_income_tracker/provider/expence_provider.dart';
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

  String truncateString(String text, int maxLength) {
    return text.length > maxLength
        ? '${text.substring(0, maxLength)}...'
        : text;
  }

  @override
  Widget build(BuildContext context) {
    var incomeProvider = Provider.of<ExpenceProvider>(context);
    final incomeGetter = incomeProvider.thisFilteredIncome;
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          incomeGetter.isEmpty
              ? const Center(
                  child: Text(
                    'No income date',
                  ),
                )
              : Expanded(
                  child: ListView.builder(
                    itemCount: incomeGetter.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(
                          bottom: 5,
                          left: 10,
                          right: 10,
                        ),
                        child: ListTile(
                          tileColor: incomeGetter[index].incomeType ==
                                  'Register Credit Card Sales'
                              ? const Color.fromARGB(179, 235, 193, 193)
                              : incomeGetter[index].incomeType ==
                                      'Register Cash Sales'
                                  ? const Color.fromARGB(255, 186, 192, 228)
                                  : const Color.fromARGB(255, 198, 216, 177),
                          leading: incomeGetter[index].incomeType ==
                                  'Register Credit Card Sales'
                              ? const Icon(
                                  Icons.credit_card_outlined,
                                )
                              : incomeGetter[index].incomeType ==
                                      'Register Cash Sales'
                                  ? const Icon(Icons.money_outlined)
                                  : incomeGetter[index].incomeType ==
                                          'Check Received from Vendor'
                                      ? const Icon(
                                          Icons.account_balance_outlined,
                                        )
                                      : const Icon(
                                          Icons.wallet_outlined,
                                        ),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                truncateString(
                                  incomeGetter[index].incomeType,
                                  25,
                                ),
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                '+${incomeGetter[index].amount} RS',
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          subtitle: Text(
                            DateFormat('EEE M-d-y').format(
                              incomeGetter[index].time,
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
