import 'package:flutter/material.dart';

class ChipsWidget extends StatefulWidget {
  final String chipLabel;
  final bool isChipSelected;
  final int selectedChipIndex;
  const ChipsWidget(
      {super.key,
      required this.chipLabel,
      this.isChipSelected = false,
      required this.selectedChipIndex});

  @override
  State<ChipsWidget> createState() => _ChipsWidgetState();
}

class _ChipsWidgetState extends State<ChipsWidget> {
  bool isChipSelected = false;
  int selectedIndex = 0;

  @override
  void initState() {
    setState(() {
      isChipSelected = widget
          .isChipSelected; // it comes as true for the first item alone and asigns true to the isChipSelected Local variable hence it will be selected on app loads for the first time.
    });
    super.initState();
  }

  void filterExpenses(index) {
    if (index == 1) {}
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = widget.selectedChipIndex;
          debugPrint(selectedIndex.toString());
          isChipSelected = !isChipSelected;
        });
        filterExpenses(selectedIndex);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: Chip(
          label: Text(
            widget.chipLabel,
            style:
                TextStyle(color: isChipSelected ? Colors.black : Colors.white),
          ),
          //autofocus: true,
          backgroundColor: isChipSelected ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}
