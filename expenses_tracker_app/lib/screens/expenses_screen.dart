import 'package:expenses_tracker_app/models/expense_model.dart';
import 'package:expenses_tracker_app/widgets/expense_list_widget.dart';
import 'package:flutter/material.dart';

class ExpenseScreen extends StatefulWidget {
  const ExpenseScreen({super.key});

  @override
  State<ExpenseScreen> createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  final List<Expense> _savedExpense = [
    Expense(
        title: 'Bag',
        amount: 25.5,
        date: DateTime.now(),
        category: Category.misc),
    Expense(
        title: 'Movie',
        amount: 50,
        date: DateTime.now(),
        category: Category.entertainment),
    Expense(
        title: 'Dominos',
        amount: 100.8,
        date: DateTime.now(),
        category: Category.food)
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text("Expenses Tracker"),
      ),
      body: Column(
        children: [
          const Text("Expenses Chart"),
          Expanded(child: ExpensesList(expenses: _savedExpense))
        ],
      ),
    );
  }
}
