import 'package:flutter/cupertino.dart';
import 'package:kharchaa/data/hive_database.dart';
import 'package:kharchaa/model/date_time_helper.dart';
import 'package:kharchaa/model/expense_item.dart';

class ExpenseData extends ChangeNotifier {
  //list of all expenses
  List<ExpenseItem> overallExpenseslist = [];

  //get expense list
  List<ExpenseItem> getALLExpenseList() {
    return overallExpenseslist;
  }

  //generate data to display from hive
  final db = HiveDataBaae();
  void prepareData() {
    //if there is already exist data
    if (db.readData().isNotEmpty) {
      overallExpenseslist =
          db.readData(); //read  data return List from Hive database
    }
  }

  //add new axpense
  void addNewExpense(ExpenseItem newExpense) {
    overallExpenseslist.add(newExpense);
    notifyListeners();
    db.saveData(overallExpenseslist);
  }

  //delete Expense
  void deleteExpense(ExpenseItem expense) {
    overallExpenseslist.remove(expense);
    notifyListeners();
    db.saveData(overallExpenseslist);
  }

  //get weekday
  String getDayName(DateTime dateTime) {
    switch (dateTime.weekday) {
      case 1:
        return 'Mon';
      case 2:
        return 'Tue';
      case 3:
        return 'Wed';
      case 4:
        return 'Thur';
      case 5:
        return 'Fri';
      case 6:
        return 'Sat';
      case 7:
        return 'Sun';
      default:
        return ' ';
    }
  }

  //get the date for the start of week day (sunday)
  DateTime startOfWeekDate() {
    DateTime? startOfWeek;

    //Get todays date
    DateTime today = DateTime.now();

    //go backwards from today to find sunday
    for (int i = 0; i < 7; i++) {
      if (getDayName(today.subtract(Duration(days: i))) == 'Sun') {
        startOfWeek = today.subtract(Duration(days: i));
      }
    }
    return startOfWeek!;
  }

  Map<String, double> calculateExpenseSummary() {
    Map<String, double> dailyExpenseSummary = {};
    for (var expense in overallExpenseslist) {
      String date = converDateTimeToString(expense.dateTime);
      double amount = double.parse(expense.amount);

      if (dailyExpenseSummary.containsKey(date)) {
        double currentAmount = dailyExpenseSummary[date]!;
        currentAmount += amount;
        dailyExpenseSummary[date] = currentAmount;
      } else {
        dailyExpenseSummary.addAll({date: amount});
      }
    }
    return dailyExpenseSummary;
  }
}
