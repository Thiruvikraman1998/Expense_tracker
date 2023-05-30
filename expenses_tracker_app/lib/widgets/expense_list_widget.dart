import 'package:expenses_tracker_app/models/expense_model.dart';
import 'package:expenses_tracker_app/widgets/expense_item_widget.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList(
      {super.key, required this.expenses, required this.deleteItem});
  final List<Expense> expenses;
  final void Function(Expense expense) deleteItem;

  @override
  Widget build(BuildContext context) {
    //expenses.sort((a, b) => a.date.compareTo(b.date));
    return expenses.isEmpty
        ? SliverToBoxAdapter(
            child: Center(
              child: Container(
                height: 100,
                width: 300,
                child: Text(" Add yuor first Expense"),
              ),
            ),
          )
        : SliverList(
            delegate: SliverChildBuilderDelegate(
                (context, index) => Dismissible(
                      background: Container(
                        padding: const EdgeInsetsDirectional.only(end: 40),
                        color: Theme.of(context).colorScheme.error,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              Icons.delete_sweep_rounded,
                              size: 30,
                              color:
                                  Theme.of(context).colorScheme.errorContainer,
                            )
                          ],
                        ),
                      ),
                      key: ValueKey(expenses[index]),
                      onDismissed: (direction) {
                        deleteItem;
                        print("item ${expenses[index].id}");
                      },
                      child: ExpenseItem(expense: expenses[index]),
                    ),
                childCount: expenses.length),
          );
  }
}
