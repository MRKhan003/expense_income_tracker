import 'package:expense_and_income_tracker/controllers/income_controller.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class IncomeChart extends StatelessWidget {
  final List<IncomeController> income;
  final List<Color> barColors = [
    Colors.lightBlue,
    Colors.lightBlueAccent,
    Colors.lightGreen,
    Colors.lightGreenAccent,
    Colors.lightGreenAccent,
    Colors.lightGreenAccent,
    Colors.lightGreenAccent,
  ];
  IncomeChart({
    required this.income,
  });
  String truncateString(String text, int maxLength) {
    return text.length > maxLength
        ? text.substring(0, maxLength) + '...'
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
                if (expenseIndex < income.length) {
                  return Text(
                    truncateString(
                      income[expenseIndex].source,
                      4,
                    ),
                    style: TextStyle(color: Colors.black),
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
      income.length,
      (index) => BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: income[index].amount,
            color: barColors[index],
            width: 20,
          ),
        ],
      ),
    );
  }
}
