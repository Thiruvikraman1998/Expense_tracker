import 'package:expenses_tracker_app/models/expense_model.dart';
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

  void _openInputFields() {
    showModalBottomSheet(
      context: context,
      builder: (modalSheetContext) {
        return const InputModalView();
      },
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
          const Text("Expenses Chart"),
          Expanded(child: ExpensesList(expenses: _savedExpense))
        ],
      ),
    );
  }
}
