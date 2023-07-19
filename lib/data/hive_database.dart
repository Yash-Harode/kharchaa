import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../model/expense_item.dart';

class HiveDataBaae {
  //refrence our box
  final _myBox = Hive.box("expense_database");

  //write
  void saveData(List<ExpenseItem> AllExpense) {
    //we can only save String and DateTime not a user Difine List type ExpenseItem
    //We need to  perform sort of opration to formate the data that can be store in Hive
    //we have A list of String, DateTime, Amount so...
    List<List<dynamic>> allExpenseFormatted = [];

    for (var expense in AllExpense) {
      List<dynamic> expenseFormatted = [
        expense.name,
        expense.amount,
        expense.dateTime,
      ];
      allExpenseFormatted.add(expenseFormatted);
    }

//Succesfully Formatted not put

    _myBox.put("All_Exepnses", allExpenseFormatted);
  }
  //read

  List<ExpenseItem> readData() {
    //to read from hive We Have to again convert the saved data into our user DataType ExpenseItem
    List savedExpenses = _myBox.get("All_Expense") ?? [];
    List<ExpenseItem> allExpenses = [];

    for (var i = 0; i < savedExpenses.length; i++) {
      //collect individual
      //[name,amount,datetime]
      String name = savedExpenses[i][0];
      String amount = savedExpenses[i][1];
      DateTime dateTime = savedExpenses[i][2];

      //create out user datatype
      ExpenseItem expense =
          ExpenseItem(name: name, amount: amount, dateTime: dateTime);

      //add expense to overall list of expenses
      allExpenses.add(expense);
    }
    return allExpenses;
  }
}
