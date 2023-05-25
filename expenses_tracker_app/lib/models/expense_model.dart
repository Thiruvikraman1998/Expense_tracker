import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

const Uuid uuid =
    Uuid(); // using this object to get uique id for each expenses that are added.

final formatter =
    DateFormat.yMd(); // asigning the instance to the formatter variable

enum Category {
  food,
  travel,
  entertainment,
  medical,
  misc
} // we use enum bcos we can actually pass a string to a constructor, but we might face typo error, so it will be easier to maintain if we use a enum of categories here.

// mapping the enum keys to the icon values.
const categoryIcons = {
  Category.food: Icons.fastfood_rounded,
  Category.travel: Icons.flight_takeoff_rounded,
  Category.entertainment: Icons.movie_filter,
  Category.medical: Icons.medical_services,
  Category.misc: Icons.miscellaneous_services_outlined
};

class Expense {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  Expense(
      {required this.title,
      required this.amount,
      required this.date,
      required this.category})
      : id = uuid
            .v4(); // values after the constructor is a initializer, which is often used when we dont want to get value from constructor. this is commonly used when we generate unique id's like this.

  String get formattedDate {
    return formatter.format(date);
  } // we can use method getter, anything is fine in this case.
}

// creating a new class to work with charts

class ChartBucket {
  final Category category;
  final List<Expense> expenses;

  ChartBucket({required this.category, required this.expenses});

// creating a named constructer that takes list expenses and category and filters to the exact category
  ChartBucket.filterCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses
            .where((expense) => expense.category == category)
            .toList();
// checks and filters according to the category,if the selected category by user is equal to the category in the chart then it gets added to the category in the chart, if the condition becomes false then it checks for other.

  double get totlaExpense {
    double sum = 0;
    for (final expense in expenses) {
      sum += expense.amount;
    }
    return sum;
  }
}
