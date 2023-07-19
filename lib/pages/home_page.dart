import 'package:flutter/material.dart';
import 'package:kharchaa/components/expense_summary.dart';
import 'package:kharchaa/components/expense_tile.dart';
import 'package:kharchaa/data/expense_data.dart';
import 'package:kharchaa/model/expense_item.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  //contrller
  final newExpenseNameController = TextEditingController();
  final newExpenseAmountController = TextEditingController();

  @override
  void initState() {
    super.initState();

    //prepare the data
    Provider.of<ExpenseData>(context, listen: false).prepareData();
  }

  //Add new Expense
  void addNewExpense() {
    showDialog(
      context: context,
      builder: ((context) {
        return AlertDialog(
          title: const Text("Add New Expense "),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: newExpenseNameController,
                decoration: InputDecoration(hintText: "Expense"),
              ), //namer
              TextField(
                controller: newExpenseAmountController,
                keyboardType: TextInputType.numberWithOptions(),
                decoration: InputDecoration(hintText: "Amount"),
              ), //amount
            ],
          ),
          actions: [
            MaterialButton(
              onPressed: save,
              child: const Text('Save'),
            ),
            MaterialButton(
              onPressed: cancel,
              child: const Text('Cancel'),
            ),
          ],
        );
      }),
    );
  }

  void deleteExpense(ExpenseItem expense) {
    Provider.of<ExpenseData>(context, listen: false).deleteExpense(expense);
  }

  //save
  void save() {
    if (newExpenseAmountController.text.isNotEmpty &&
        newExpenseNameController.text.isNotEmpty) {
      //create expense item
      ExpenseItem newExpense = ExpenseItem(
        name: newExpenseNameController.text,
        amount: newExpenseAmountController.text,
        dateTime: DateTime.now(),
      );
      Provider.of<ExpenseData>(context, listen: false)
          .addNewExpense(newExpense);
    }
    Navigator.pop(context);
    clear();
  }

//cancel
  void cancel() {
    Navigator.pop(context);
    clear();
  }

//clear
  void clear() {
    newExpenseAmountController.clear();
    newExpenseNameController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseData>(
        builder: (context, value, child) => Scaffold(
            backgroundColor: Colors.grey[300],
            floatingActionButton: FloatingActionButton(
              onPressed: addNewExpense,
              backgroundColor: Colors.black,
              child: const Icon(
                Icons.add,
                color: Color.fromARGB(255, 200, 185, 185),
              ),
            ),
            body: ListView(
              children: [
                //BAR graph
                ExpenseSummary(startOfWeek: value.startOfWeekDate()),

                const SizedBox(
                  height: 10,
                ),
                const Divider(
                  color: Color.fromARGB(255, 111, 107, 107),
                  thickness: 4,
                ),

                const SizedBox(
                  height: 10,
                ),
                //expenses

                ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: value.getALLExpenseList().length,
                    itemBuilder: (context, index) => ExpenseTile(
                          name: value.getALLExpenseList()[index].name,
                          amount: value.getALLExpenseList()[index].amount,
                          dateTime: value.getALLExpenseList()[index].dateTime,
                          deleteTapped: (p0) =>
                              deleteExpense(value.getALLExpenseList()[index]),
                        )),
              ],
            )));
  }
}
