import 'package:sqflite/sqflite.dart';
import '../models/cartModels.dart';
import 'db_helper.dart';

class CartDB {
  final DBHelper _dbHelper = DBHelper();

  Future<List<CartModel>> getCartItems() async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('cart');
    return maps.map((map) => CartModel(id: map['id'], name: map['name'])).toList();
  }

  Future<void> insertCartItem(CartModel item) async {
    final db = await _dbHelper.database;
    await db.insert('cart', item.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> deleteCartItem(String id) async {
    final db = await _dbHelper.database;
    await db.delete('cart', where: 'id = ?', whereArgs: [id]);
  }
}
