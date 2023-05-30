import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import '../models/table_constant_model.dart';

class ExpenseDatabaseRepository {
  //static final ExpenseDatabaseRepository instance = ExpenseDatabaseRepository._init();

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
}
