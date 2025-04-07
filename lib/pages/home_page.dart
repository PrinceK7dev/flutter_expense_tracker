import 'package:expence_tracker_app/data/expense_data.dart';
import 'package:expence_tracker_app/models/expense_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // text controller
  final newExpenseNameController = TextEditingController();
  final newExpenseAmountController = TextEditingController();

  // add new expense
  void addNewExpense() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('Add new Expense'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // expense name
                TextField(controller: newExpenseNameController),

                // expense amount
                TextField(controller: newExpenseAmountController),
              ],
            ),
            actions: [
              // save button
              ElevatedButton(
                onPressed: () {
                  save();
                },
                child: Text("Save"),
              ),
              // cancel button
              ElevatedButton(
                onPressed: () {
                  cancel();
                },
                child: Text("Cancel"),
              ),
            ],
          ),
    );
  }

  // save meth
  void save() {
    if (newExpenseNameController.text.isNotEmpty &&
        newExpenseAmountController.text.isNotEmpty) {
      ExpenseItem newExpense = ExpenseItem(
        name: newExpenseNameController.text,
        amount: newExpenseAmountController.text,
        dateTime: DateTime.now(),
      );
      Provider.of<ExpenseData>(
        context,
        listen: false,
      ).addNewExpense(newExpense);

      Navigator.pop(context);
      clear();
    } else {
      // show error message or toast
    }
  }

  // cancel meth
  void cancel() {
    Navigator.pop(context);
    clear();
  }

  // clear the controllers
  void clear() {
    newExpenseAmountController.clear();
    newExpenseNameController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseData>(
      builder:
          (context, value, child) => Scaffold(
            backgroundColor: Colors.grey[300],
            floatingActionButton: FloatingActionButton(
              onPressed: addNewExpense,
              child: Icon(Icons.add),
            ),
            body: ListView.builder(
              itemCount: value.getAllExpenseList().length,
              itemBuilder:
                  (context, index) => ListTile(
                    title: Text(value.getAllExpenseList()[index].name),
                  ),
            ),
          ),
    );
  }
}
