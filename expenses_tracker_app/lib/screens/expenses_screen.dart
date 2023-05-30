import 'package:expenses_tracker_app/models/expense_model.dart';
import 'package:expenses_tracker_app/repositoriers/expense_database_repository.dart';
import 'package:expenses_tracker_app/widgets/chart/chart.dart';
import 'package:expenses_tracker_app/widgets/chips.dart';
import 'package:expenses_tracker_app/widgets/expense_item_widget.dart';
import 'package:expenses_tracker_app/widgets/expense_list_widget.dart';
import 'package:expenses_tracker_app/widgets/input_modal_widget.dart';
import 'package:flutter/material.dart';

class ExpenseScreen extends StatefulWidget {
  const ExpenseScreen({super.key});

  @override
  State<ExpenseScreen> createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  final List<Expense> _savedExpense = [];
  List<Expense> myExpenses = [];

  final List chipItems = ["All", "Category", "Date", "Custom sort"];

  void getExpenses() async {
    await ExpenseDatabaseRepository.instance.getAllExpenses().then((value) {
      setState(() {
        myExpenses = value;
      });
    }).catchError((e) => debugPrint(e.toString()));
    print(myExpenses.length);
  }

  void delete({required Expense expense, required BuildContext context}) async {
    await ExpenseDatabaseRepository.instance
        .deleteItem(expense.id!)
        .then((value) {
      final expenseId = myExpenses.indexOf(expense);
      print(expenseId);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("Expense deleted"),
          action: SnackBarAction(
            label: 'undo',
            onPressed: () {
              setState(
                () {
                  myExpenses.insert(expenseId, expense);
                },
              );
            },
          ),
        ),
      );
    });
  }

  void _openInputFields() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (modalSheetContext) {
        return InputModalView(
          saveExpenseData: _addExpensesData,
        );
      },
    );
  }

  void _addExpensesData(Expense expense) {
    setState(() {
      _savedExpense.add(expense);
    });
    Navigator.pop(context);
  }

  // void _removeExpenseData(Expense expense) {
  //   final expenseIndex = _savedExpense.indexOf(expense);
  //   setState(() {
  //     _savedExpense.remove(expense);
  //   });
  //   ScaffoldMessenger.of(context).clearSnackBars();
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       content: const Text("Expense deleted"),
  //       action: SnackBarAction(
  //         label: 'undo',
  //         onPressed: () {
  //           setState(() {
  //             _savedExpense.insert(expenseIndex, expense);
  //           });
  //         },
  //       ),
  //     ),
  //   );
  // }

  void initDB() async {
    await ExpenseDatabaseRepository.instance.database;
  }

  @override
  void initState() {
    initDB();
    getExpenses();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            pinned: true,
            actions: [
              IconButton(
                onPressed: _openInputFields,
                icon: const Icon(Icons.add),
                color: Colors.white,
              ),
            ],
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
                background: Container(
              margin: const EdgeInsets.only(top: 60),
              height: 100,
              width: double.infinity,
              child: Chart(expenses: myExpenses),
            )),
          ),
          SliverToBoxAdapter(
              child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Wrap(
              children: List.generate(
                chipItems.length,
                (index) => StatefulBuilder(
                  builder: (context, setState) => ChipsWidget(
                      chipLabel: chipItems[index],
                      isChipSelected: index == 0,
                      selectedChipIndex: chipItems.indexOf(chipItems[index])),
                  //isChipSelected: This property determines whether the chip is initially selected or not. It is assigned index == 0, which means it will be true only when the current index is 0 (representing the first chip in the list). So, only the first chip will have isChipSelected set to true, while the others will have it set to false.
                  //By setting isChipSelected to true for the first chip initially, we ensure that it appears selected when the app is loaded, while the rest of the chips remain unselected.
                ),
              ),
            ),
          )),
          ExpensesList(
            expenses: myExpenses,
            deleteItem: (expense) {
              delete(expense: expense, context: context);
              getExpenses();
            },
          )
        ],
      ),
    );
  }
}

// Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           "Expenses Tracker",
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//         actions: [
//           IconButton(
//             onPressed: _openInputFields,
//             icon: const Icon(Icons.add),
//             color: Colors.black,
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           Chart(expenses: _savedExpense),
//           Expanded(
//             child: _savedExpense.isEmpty
//                 ? const Center(
//                     child: Text("Add your first expense..."),
//                   )
//                 : ExpensesList(
//                     expenses: _savedExpense,
//                     removeListItem: _removeExpenseData),
//           )
//         ],
//       ),
//     );

