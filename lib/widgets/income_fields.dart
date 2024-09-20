import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:expense_and_income_tracker/controllers/expense_controller.dart';
import 'package:expense_and_income_tracker/firebase/firebase_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class IncomeFields extends StatefulWidget {
  const IncomeFields({super.key});

  @override
  State<IncomeFields> createState() => _IncomeFieldsState();
}

class _IncomeFieldsState extends State<IncomeFields> {
  ExpenseController controller = ExpenseController();
  String? selectedValue;
  List<String> items = [
    'Register Cash Sales',
    'Register Credit Card Sales',
    'Register EBT Sales',
    'Total Lotto Credit Card Sales',
    'Total Scratch Instant Credit Card Sales',
    'Vending Machine Lotto Sales',
    'Vending Machine Instant Sales',
    'Check Received from Vendor'
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
                    'Income Type',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: controller.vendorController,
                cursorColor: Colors.black45,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.person_2_outlined,
                  ),
                  label: Text(
                    'Vendor Name',
                  ),
                  labelStyle: GoogleFonts.poppins(color: Colors.black45),
                  floatingLabelStyle: GoogleFonts.poppins(
                    color: Color(
                      0xffF8B31A,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
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
                  border: OutlineInputBorder(
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
                  focusedBorder: OutlineInputBorder(
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
                  prefixIcon: Icon(
                    Icons.money_outlined,
                  ),
                  label: Text(
                    'Amount',
                  ),
                  labelStyle: GoogleFonts.poppins(color: Colors.black45),
                  floatingLabelStyle: GoogleFonts.poppins(
                    color: Color(
                      0xffF8B31A,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
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
                  border: OutlineInputBorder(
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
                  focusedBorder: OutlineInputBorder(
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
            selectedValue == 'Check Received from Vendor'
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: controller.chequeNumberController,
                      cursorColor: Colors.black45,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.account_balance_outlined,
                        ),
                        label: Text(
                          'Check Number',
                        ),
                        labelStyle: GoogleFonts.poppins(color: Colors.black45),
                        floatingLabelStyle: GoogleFonts.poppins(
                          color: Color(
                            0xffF8B31A,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
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
                        border: OutlineInputBorder(
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
                        focusedBorder: OutlineInputBorder(
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
                : SizedBox(),
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
                  prefixIcon: Icon(
                    Icons.calendar_month_outlined,
                  ),
                  label: Text('Time'),
                  labelStyle: GoogleFonts.poppins(color: Colors.black45),
                  floatingLabelStyle: GoogleFonts.poppins(
                    color: Color(
                      0xffF8B31A,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
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
                  border: OutlineInputBorder(
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
                  focusedBorder: OutlineInputBorder(
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
                UserDatabase().addIncome(
                  selectedValue!,
                  controller.vendorController.text,
                  int.parse(controller.amountController.text),
                  controller.chequeNumberController.text ?? '',
                );
                controller.amountController.clear();
                controller.chequeNumberController.clear();
                controller.vendorController.clear();
                controller.amountController.clear();
                controller.paymentTypeController.clear();
                controller.reasonController.clear();
              },
              child: Text(
                'Save',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
