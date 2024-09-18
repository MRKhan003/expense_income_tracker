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
                    bottom: 10,
                  ),
                  child: ListTile(
                    tileColor: income[index].source == 'Rent'
                        ? Colors.yellow
                        : income[index].source == 'Salary'
                            ? Colors.lightBlue
                            : income[index].source == 'Cash Bond'
                                ? Colors.white70
                                : Colors.lightGreenAccent,
                    leading: Icon(
                      Icons.shopping_cart_outlined,
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
                          income[index].amount.toString() + ' RS',
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
