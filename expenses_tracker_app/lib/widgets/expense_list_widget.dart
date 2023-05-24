import 'package:expenses_tracker_app/models/expense_model.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({super.key, required this.expenses});
  final List<Expense> expenses;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
              title: Text(expenses[index].title),
              trailing: Text("\$ ${expenses[index].amount}")),
        );
      },
    );
  }
}
