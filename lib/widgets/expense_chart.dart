import 'package:expense_and_income_tracker/expense_controller/my_expense.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ExpenseChart extends StatelessWidget {
  final List<Expense> expenses;
  final List<Color> barColors = [
    Colors.lightBlue,
    Colors.lightBlueAccent,
    Colors.lightGreen,
    Colors.lightGreenAccent,
    Colors.lightGreenAccent,
    Colors.lightGreenAccent,
    Colors.lightGreenAccent,
  ];
  ExpenseChart({
    required this.expenses,
  });
  String truncateString(String text, int maxLength) {
    return text.length > maxLength
        ? '${text.substring(0, maxLength)}...'
        : text;
  }

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        barGroups: _buildBarGroups(),
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (double value, TitleMeta meta) {
                final expenseIndex = value.toInt();
                if (expenseIndex < expenses.length) {
                  return Text(
                    truncateString(
                      expenses[expenseIndex].category,
                      4,
                    ),
                    style: const TextStyle(color: Colors.black),
                  );
                }
                return Container();
              },
            ),
          ),
        ),
        borderData: FlBorderData(
          show: false,
        ),
        barTouchData: BarTouchData(enabled: true),
      ),
    );
  }

  List<BarChartGroupData> _buildBarGroups() {
    return List.generate(
      expenses.length,
      (index) => BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: expenses[index].amount.toDouble(),
            color: barColors[index],
            width: 20,
          ),
        ],
      ),
    );
  }
}
