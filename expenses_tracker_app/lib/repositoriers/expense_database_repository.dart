import 'package:expenses_tracker_app/models/expense_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import '../models/table_constant_model.dart';

class ExpenseDatabaseRepository {
  static final ExpenseDatabaseRepository instance =
      ExpenseDatabaseRepository._init();
  ExpenseDatabaseRepository._init(); // singleton

  static Database? _database;
  // ExpenseDatabase._init();

  // the below getter will returns database if there is already a database was created, and if nothing is created then it returns _initDB() method in which we will write code to create database for the first time.
  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await _initDB('expense.db');
    return _database;
  }

  // We need to initialize database and get its path.
  Future<Database> _initDB(String filePath) async {
    final dbPath =
        await getApplicationDocumentsDirectory(); // stores the instance to dbPath
    final path = join(dbPath.path, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  // creating the database tables.

  Future _createDB(Database db, int version) async {
    await db.execute('''CREATE TABLE ${TableConstants.tableName} (
      ${TableConstants.id} INTEGER PRIMARY KEY AUTOINCREMENT,
      ${TableConstants.title} TEXT,
      ${TableConstants.amount} REAL,
      ${TableConstants.date} TEXT,
      ${TableConstants.category} TEXT
    )''');
  }

  // add expense to database
  Future<void> insert({required Expense expense}) async {
    try {
      final db = await database;
      db!.insert(TableConstants.tableName, expense.toMap());
      print(expense.category.toString());
      print(" Expense added");
    } catch (e) {
      print("The exception is $e");
    }
  }

  // Get all expense list

  Future<List<Expense>> getAllExpenses() async {
    final db = await instance.database;

    final result = await db!.query(TableConstants.tableName);
    return List.generate(result.length, (i) => Expense.fromMap(result[i]));
  }

  // To delete an item

  Future<void> deleteItem(int id) async {
    try {
      final db = await instance.database;
      db!.delete(TableConstants.tableName,
          where: '${TableConstants.id} = ?', whereArgs: [id]);
    } catch (e) {
      print(e.toString());
    }
  }
}
