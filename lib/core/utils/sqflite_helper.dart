import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqfliteHelper {
  // ====== Singleton ======
  SqfliteHelper._();
  static final SqfliteHelper sqfliteHelper = SqfliteHelper._();

  static const dbName = "item.db";
  static const dbVersion = 1;

  Database? _database;

  // ====== Get database ======
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    } else {
      _database = await _initDatabase();
      return _database!;
    }
  }

  // ====== Initialize database ======
  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), dbName);
    return await openDatabase(
      path,
      version: dbVersion,
      onCreate: _onCreate,
    );
  }

  // ====== Create table ======
  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE items(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        price REAL NOT NULL
      )
    ''');
  }

  // ====== Insert ======
  Future<int> insertItem(Map<String, dynamic> data) async {
    Database db = await database;
    return await db.insert('items', data);
  }

  // ====== Get all ======
  Future<List<Map<String, dynamic>>> getAllItems() async {
    Database db = await database;
    return await db.query('items');
  }

  // ====== Update ======
  Future<int> updateItem(int id, Map<String, dynamic> data) async {
    Database db = await database;
    return await db.update(
      'items',
      data,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // ====== Delete ======
  Future<int> deleteItem(int id) async {
    Database db = await database;
    return await db.delete(
      'items',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
