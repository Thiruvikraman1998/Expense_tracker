import 'package:expenses_tracker_app/models/expense_model.dart';
import 'package:expenses_tracker_app/widgets/chart/chart.dart';
import 'package:expenses_tracker_app/widgets/expense_list_widget.dart';
import 'package:expenses_tracker_app/widgets/input_modal_widget.dart';
import 'package:flutter/material.dart';

class ExpenseScreen extends StatefulWidget {
  const ExpenseScreen({super.key});

  @override
  State<ExpenseScreen> createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  final List<Expense> _savedExpense = [
    // Expense(
    //     title: 'Bag',
    //     amount: 25.5,
    //     date: DateTime.now(),
    //     category: Category.misc),
    // Expense(
    //     title: 'Movie',
    //     amount: 50,
    //     date: DateTime.now(),
    //     category: Category.entertainment),
    // Expense(
    //     title: 'Dominos',
    //     amount: 100.8,
    //     date: DateTime.now(),
    //     category: Category.food)
  ];

  void _openInputFields() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (modalSheetContext) {
        return InputModalView(saveExpenseData: _addExpensesData);
      },
    );
  }

  void _addExpensesData(Expense expense) {
    setState(() {
      _savedExpense.add(expense);
    });
    Navigator.pop(context);
  }

  void _removeExpenseData(Expense expense) {
    final expenseIndex = _savedExpense.indexOf(expense);
    setState(() {
      _savedExpense.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text("Expense deleted"),
        action: SnackBarAction(
          label: 'undo',
          onPressed: () {
            setState(() {
              _savedExpense.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Expenses Tracker",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: _openInputFields,
            icon: const Icon(Icons.add),
            color: Colors.black,
          ),
        ],
      ),
      body: Column(
        children: [
          Chart(expenses: _savedExpense),
          Expanded(
            child: _savedExpense.isEmpty
                ? const Center(
                    child: Text("Add your first expense..."),
                  )
                : ExpensesList(
                    expenses: _savedExpense,
                    removeListItem: _removeExpenseData),
          )
        ],
      ),
    );
  }
}
