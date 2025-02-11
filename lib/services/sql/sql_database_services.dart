import 'package:flutter_final_exam/model/products_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqlDatabaseServices {
  static final SqlDatabaseServices sqlDatabaseServices =
      SqlDatabaseServices._();
  SqlDatabaseServices._();
  Database? _database;

  Future<Database?> get database async =>
      (_database != null) ? _database : await initDatabase();

  Future<Database?> initDatabase() async {
    // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'products.db');

// open the database
    _database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(
          'CREATE TABLE cartProduct (id INTEGER PRIMARY KEY AUTOINCREMENT , productName TEXT, productPrice TEXT,quantity INTEGER)');
    });
    return _database;
  }

  Future<void> addProductToLocalDatabase(ProductsModel products) async {
    final db = await database;
    await db!.insert('cartProduct', products.toMap());
  }

  Future<int> delete(String productName) async {
    final db = await database;

    return await db!.delete('cartProduct',
        where: 'productName = ?', whereArgs: [productName]);
  }

  Future<List<ProductsModel>> fetchProductsFromLocalDatabase() async {
    final db = await database;
    List<Map> data = await db!.query("cartProduct");
    return data.map((e) => ProductsModel.fromMap(e)).toList();
  }

  Future<void> update(ProductsModel product) async {
    final db = await database;

    await db!.update("cartProduct", product.toMap(),
        where: 'productName = ?', whereArgs: [product.productName]);
  }
}
