import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:expense_and_income_tracker/controllers/expense_controller.dart';
import 'package:expense_and_income_tracker/firebase/firebase_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ExpenseFields extends StatefulWidget {
  const ExpenseFields({super.key});

  @override
  State<ExpenseFields> createState() => _ExpenseFieldsState();
}

class _ExpenseFieldsState extends State<ExpenseFields> {
  ExpenseController controller = ExpenseController();
  String? selectedValue;
  List<String> items = [
    'Cash',
    'Card',
    'Cheque',
    'Total Lottery Payout',
    'Vending Machine Lottery Payout',
    'Pull Tab',
    'Lottery Coupons',
    'Money added to ATM',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButtonHideUnderline(
                child: DropdownButton2<String>(
                  isExpanded: true,
                  hint: const Text(
                    'Expense Type',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black45,
                    ),
                  ),
                  items: items
                      .map((String item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ))
                      .toList(),
                  value: selectedValue,
                  onChanged: (String? value) {
                    setState(() {
                      selectedValue = value;
                    });
                  },
                  buttonStyleData: ButtonStyleData(
                    height: 60,
                    width: double.infinity,
                    padding: const EdgeInsets.only(left: 14, right: 14),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: Colors.black26,
                      ),
                      color: Colors.white,
                    ),
                    elevation: 2,
                  ),
                  menuItemStyleData: const MenuItemStyleData(
                    height: 40,
                  ),
                ),
              ),
            ),
            selectedValue == 'Total Lottery Payout' ||
                    selectedValue == 'Pull Tab'
                ? const SizedBox()
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: controller.vendorController,
                      cursorColor: Colors.black45,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          selectedValue == 'Money added to ATM'
                              ? Icons.account_balance_outlined
                              : Icons.person_2_outlined,
                        ),
                        label: Text(
                          selectedValue == 'Money added to ATM'
                              ? 'Bank Name'
                              : 'Vendor Name',
                        ),
                        labelStyle: GoogleFonts.poppins(
                          color: Colors.black45,
                        ),
                        floatingLabelStyle: GoogleFonts.poppins(
                          color: const Color(
                            0xffF8B31A,
                          ),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black45,
                            style: BorderStyle.solid,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              10,
                            ),
                          ),
                        ),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black45,
                            style: BorderStyle.solid,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              10,
                            ),
                          ),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(
                              0xffF8B31A,
                            ),
                            style: BorderStyle.solid,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              10,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: controller.amountController,
                cursorColor: Colors.black45,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.money_outlined,
                  ),
                  label: const Text(
                    'Amount',
                  ),
                  labelStyle: GoogleFonts.poppins(
                    color: Colors.black45,
                  ),
                  floatingLabelStyle: GoogleFonts.poppins(
                    color: const Color(
                      0xffF8B31A,
                    ),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black45,
                      style: BorderStyle.solid,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        10,
                      ),
                    ),
                  ),
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black45,
                      style: BorderStyle.solid,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        10,
                      ),
                    ),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(
                        0xffF8B31A,
                      ),
                      style: BorderStyle.solid,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        10,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            selectedValue == 'Cheque'
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: controller.paymentTypeController,
                      cursorColor: Colors.black45,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.account_balance_outlined,
                        ),
                        label: const Text(
                          'Check Number',
                        ),
                        labelStyle: GoogleFonts.poppins(color: Colors.black45),
                        floatingLabelStyle: GoogleFonts.poppins(
                          color: const Color(
                            0xffF8B31A,
                          ),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black45,
                            style: BorderStyle.solid,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              10,
                            ),
                          ),
                        ),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black45,
                            style: BorderStyle.solid,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              10,
                            ),
                          ),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(
                              0xffF8B31A,
                            ),
                            style: BorderStyle.solid,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              10,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                : const SizedBox(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                readOnly: true,
                initialValue: DateFormat('EEE M-d-y').format(
                  DateTime.now(),
                ),
                cursorColor: Colors.black45,
                keyboardType: TextInputType.datetime,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.calendar_month_outlined,
                  ),
                  label: const Text('Time'),
                  labelStyle: GoogleFonts.poppins(color: Colors.black45),
                  floatingLabelStyle: GoogleFonts.poppins(
                    color: const Color(
                      0xffF8B31A,
                    ),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black45,
                      style: BorderStyle.solid,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        10,
                      ),
                    ),
                  ),
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black45,
                      style: BorderStyle.solid,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        10,
                      ),
                    ),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(
                        0xffF8B31A,
                      ),
                      style: BorderStyle.solid,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        10,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                UserDatabase().sendExpense(
                  selectedValue!,
                  controller.vendorController.text,
                  int.parse(controller.amountController.text),
                  controller.paymentTypeController.text ?? '',
                );
                controller.amountController.clear();
                controller.chequeNumberController.clear();
                controller.vendorController.clear();
                controller.amountController.clear();
                controller.paymentTypeController.clear();
                controller.reasonController.clear();

                selectedValue == null;
              },
              child: const Text(
                'Save',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
