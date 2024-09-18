import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Draweritems extends StatelessWidget {
  String title;
  IconData icon;
  Color cardColor;
  Draweritems({
    required this.title,
    required this.icon,
    required this.cardColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      color: cardColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 10,
              ),
              child: Text(
                title,
                style: GoogleFonts.poppins(
                    //fontSize: 14,
                    ),
              ),
            ),
          ),
          Expanded(
            child: Icon(
              icon,
              //size: 14,
            ),
          ),
        ],
      ),
    );
  }
}
