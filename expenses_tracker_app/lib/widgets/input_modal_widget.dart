import 'package:expenses_tracker_app/models/expense_model.dart';
import 'package:expenses_tracker_app/repositoriers/expense_database_repository.dart';
import 'package:flutter/material.dart';

class InputModalView extends StatefulWidget {
  final void Function(Expense expense) saveExpenseData;
  const InputModalView({super.key, required this.saveExpenseData});

  @override
  State<InputModalView> createState() => _InputModalViewState();
}

class _InputModalViewState extends State<InputModalView> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  DateTime? _selectedDate;
  Category _selectedCategory = Category.food;

  // Future object//
  void _openDatePicker() async {
    final dateTimeNow = DateTime.now();
    final firstDate =
        DateTime(dateTimeNow.year - 1, dateTimeNow.month, dateTimeNow.day);
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: dateTimeNow,
        firstDate: firstDate,
        lastDate: dateTimeNow);

    // dateTimeNow - to place the marker on the today's date.
    // dateTimeNow.year - 1 : this logic is written to make the date picker to show past 1 year dates to pick and mark the expenses any if we did missed earlier.

    setState(() {
      _selectedDate = pickedDate;
    });
  }

  // dispose() method is important because if we didnt dispose the controller, then the values stored in the variable will consume memory all the time even if the modalsheet is closed, this might affect the app smoothness. we use this dispose in more places like text fields animations and so on.
  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    //clears the data stored when the modal sheet was closed.
    super.dispose();
  }

  void _validationSubmission() async {
    final _enteredAmount = double.tryParse(_amountController.text);
    final invalidAmount = _enteredAmount == null || _enteredAmount <= 0;

    if (_titleController.text.isEmpty ||
        invalidAmount ||
        _selectedDate == null) {
      showDialog(
        context: context,
        builder: (dialogBoxContext) {
          return AlertDialog(
            title: const Text("Invalid Input"),
            content: const Text(
                "Check whether entered title, amount, date, and category are valid."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(dialogBoxContext);
                },
                child: const Text("Okay"),
              )
            ],
          );
        },
      );
      return;
    }
    Expense newExpense = Expense(
        title: _titleController.text,
        amount: _enteredAmount,
        date: _selectedDate!,
        category: _selectedCategory);
    await ExpenseDatabaseRepository.instance.insert(expense: newExpense);
    // widget.saveExpenseData(Expense(
    //     title: _titleController.text,
    //     amount: _enteredAmount,
    //     date: _selectedDate!,
    //     category: _selectedCategory));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: Column(
        children: [
          const SizedBox(height: 30),
          TextField(
            controller: _titleController,
            maxLength: 50,
            decoration: const InputDecoration(
              hintText: 'Enter a title',
              label: Text("Title"),
            ),
          ),
          Row(
            children: [
              // here we are wrapping both the children with expanded as the text field takes all the width, so it throws error while we insert other childrens with them.
              Expanded(
                child: TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    prefix: Text('₹ '),
                    hintText: 'Enter an amount',
                    label: Text("Amount"),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      _selectedDate == null
                          ? "Select a date"
                          : formatter.format(_selectedDate!),
                    ),
                    IconButton(
                      onPressed: _openDatePicker,
                      icon: const Icon(Icons.calendar_month_rounded),
                    )
                  ],
                ),
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DropdownButton(
                  value: _selectedCategory,
                  items: Category.values
                      .map((category) => DropdownMenuItem(
                            value: category,
                            child: Text(
                              category.name.toUpperCase(),
                            ),
                          ))
                      .toList(),
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    }
                    setState(() {
                      _selectedCategory = value;
                    });
                  }),
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Cancel"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _validationSubmission();
                      Navigator.pop(context);
                    },
                    child: const Text("Save Data"),
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
