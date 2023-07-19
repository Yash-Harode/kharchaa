import 'package:flutter/material.dart';
import 'package:kharchaa/bargraph/bar_graph.dart';
import 'package:kharchaa/data/expense_data.dart';
import 'package:kharchaa/model/date_time_helper.dart';
import 'package:provider/provider.dart';

class ExpenseSummary extends StatelessWidget {
  final DateTime startOfWeek;
  const ExpenseSummary({
    super.key,
    required this.startOfWeek,
  });
//upper cap for rods
  double calculateMax(
    ExpenseData value,
    String sunday,
    String monday,
    String tuesday,
    String wednesday,
    String thrusday,
    String friday,
    String saturday,
  ) {
    double? max = 100;

    List<double> values = [
      value.calculateExpenseSummary()[sunday] ?? 0,
      value.calculateExpenseSummary()[monday] ?? 0,
      value.calculateExpenseSummary()[tuesday] ?? 0,
      value.calculateExpenseSummary()[wednesday] ?? 0,
      value.calculateExpenseSummary()[thrusday] ?? 0,
      value.calculateExpenseSummary()[friday] ?? 0,
      value.calculateExpenseSummary()[saturday] ?? 0,
    ];
    //sort list to get max
    values.sort();
    //get the last highest val
    max = values.last * 1;
    return max == 0 ? 100 : max;
  }

  String calculateweekTotal(
    ExpenseData value,
    String sunday,
    String monday,
    String tuesday,
    String wednesday,
    String thrusday,
    String friday,
    String saturday,
  ) {
    List<double> values = [
      value.calculateExpenseSummary()[sunday] ?? 0,
      value.calculateExpenseSummary()[monday] ?? 0,
      value.calculateExpenseSummary()[tuesday] ?? 0,
      value.calculateExpenseSummary()[wednesday] ?? 0,
      value.calculateExpenseSummary()[thrusday] ?? 0,
      value.calculateExpenseSummary()[friday] ?? 0,
      value.calculateExpenseSummary()[saturday] ?? 0,
    ];
    double total = 0;
    for (var i = 0; i < values.length; i++) {
      total += values[i];
    }
    return total.toString();
  }

  @override
  Widget build(BuildContext context) {
    //get yyyymmdd
    String sunday =
        converDateTimeToString(startOfWeek.add(const Duration(days: 0)));
    String monday =
        converDateTimeToString(startOfWeek.add(const Duration(days: 1)));
    String tuesday =
        converDateTimeToString(startOfWeek.add(const Duration(days: 2)));
    String wednesday =
        converDateTimeToString(startOfWeek.add(const Duration(days: 3)));
    String thrusday =
        converDateTimeToString(startOfWeek.add(const Duration(days: 4)));
    String friday =
        converDateTimeToString(startOfWeek.add(const Duration(days: 5)));
    String saturday =
        converDateTimeToString(startOfWeek.add(const Duration(days: 6)));
    return Consumer<ExpenseData>(
        builder: (context, value, child) => Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Row(
                    children: [
                      const Text(
                        "Week Total:",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                          'Rs.${calculateweekTotal(value, sunday, monday, tuesday, wednesday, thrusday, friday, saturday)}'),
                    ],
                  ),
                ),
                SizedBox(
                  height: 200,
                  child: MyBarGraph(
                    maxY: calculateMax(value, sunday, monday, tuesday,
                        wednesday, thrusday, friday, saturday),
                    sunAmount: value.calculateExpenseSummary()[sunday] ?? 0,
                    monAmount: value.calculateExpenseSummary()[monday] ?? 0,
                    tueAmount: value.calculateExpenseSummary()[tuesday] ?? 0,
                    wedAmount: value.calculateExpenseSummary()[wednesday] ?? 0,
                    thurAmount: value.calculateExpenseSummary()[thrusday] ?? 0,
                    friAmount: value.calculateExpenseSummary()[friday] ?? 0,
                    satAmount: value.calculateExpenseSummary()[saturday] ?? 0,
                  ),
                ),
              ],
            ));
  }
}
