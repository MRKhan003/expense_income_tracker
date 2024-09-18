import 'package:expense_and_income_tracker/controllers/income_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class IncomeScreen extends StatelessWidget {
  IncomeScreen({super.key});
  List<IncomeController> income = [
    IncomeController(
      'Rent',
      100.0,
      DateTime.now(),
      'Cash',
    ),
    IncomeController(
      'Salary',
      500.0,
      DateTime.now().subtract(
        Duration(days: 1),
      ),
      'Cash',
    ),
    IncomeController(
      'Rent',
      100.0,
      DateTime.now().subtract(
        Duration(days: 10),
      ),
      'Cash',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: income.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(
                    bottom: 5,
                    left: 10,
                    right: 10,
                  ),
                  child: ListTile(
                    tileColor: income[index].source == 'Rent'
                        ? Color.fromARGB(179, 235, 193, 193)
                        : income[index].source == 'Salary'
                            ? Color.fromARGB(255, 186, 192, 228)
                            : Color.fromARGB(255, 198, 216, 177),
                    leading: income[index].source == 'Rent'
                        ? Icon(
                            Icons.house_outlined,
                          )
                        : income[index].source == 'Salary'
                            ? Icon(Icons.wallet_outlined)
                            : Icon(
                                Icons.accessibility_new_outlined,
                              ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          income[index].source,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          '+' + income[index].amount.toString() + ' RS',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    subtitle: Text(
                      DateFormat('M-d-y').format(
                        income[index].time,
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
