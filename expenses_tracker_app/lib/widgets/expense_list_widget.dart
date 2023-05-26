import 'package:expenses_tracker_app/models/expense_model.dart';
import 'package:expenses_tracker_app/widgets/expense_item_widget.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList(
      {super.key, required this.expenses, required this.removeListItem});
  final List<Expense> expenses;
  final void Function(Expense expense) removeListItem;

  @override
  Widget build(BuildContext context) {
    expenses.sort((b, a) => a.amount.compareTo(b.amount));
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (context, index) {
        return Dismissible(
          background: Container(
            padding: const EdgeInsetsDirectional.only(end: 40),
            color: Theme.of(context).colorScheme.error,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(
                  Icons.delete_sweep_rounded,
                  size: 30,
                  color: Theme.of(context).colorScheme.errorContainer,
                )
              ],
            ),
          ),
          key: ValueKey(expenses[index]),
          onDismissed: (direction) {
            removeListItem(expenses[index]);
          },
          child: ExpenseItem(expense: expenses[index]),
        );
      },
    );
  }
}
