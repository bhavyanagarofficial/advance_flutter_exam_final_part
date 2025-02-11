import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/cartModels.dart';

class DBHelper {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'cart.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute(
          '''CREATE TABLE cart (
            id TEXT PRIMARY KEY,
            name TEXT
          )''',
        );
      },
    );
  }

  Future<List<CartModel>> getCartItems() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('cart');
    return maps.map((map) => CartModel(id: map['id'], name: map['name'])).toList();
  }

  Future<void> insertCartItem(CartModel item) async {
    final db = await database;
    await db.insert('cart', item.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> deleteCartItem(String id) async {
    final db = await database;
    await db.delete('cart', where: 'id = ?', whereArgs: [id]);
  }
}
