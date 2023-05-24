import 'package:flutter/material.dart';

class InputModalView extends StatefulWidget {
  const InputModalView({super.key});

  @override
  State<InputModalView> createState() => _InputModalViewState();
}

class _InputModalViewState extends State<InputModalView> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  // dispose() method is important because if we didnt dispose the controller, then the values stored in the variable will consume memory all the time even if the modalsheet is closed, this might affect the app smoothness. we use this dispose in more places like text fields animations and so on.
  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    //clears the data stored when the modal sheet was closed.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            maxLength: 50,
            decoration: const InputDecoration(
              label: Text("Title"),
            ),
          ),
          Row(
            children: [
              TextField(
                controller: _amountController,
                decoration: const InputDecoration(
                  label: Text("Title"),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
