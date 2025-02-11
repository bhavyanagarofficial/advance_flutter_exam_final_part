import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  Database? _database;
  List<Map<String, dynamic>> _cartItems = [];

  @override
  void initState() {
    super.initState();
    _initializeDatabase();
  }

  Future<void> _initializeDatabase() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), 'cart.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE cart(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT)",
        );
      },
      version: 1,
    );
    _fetchCartItems();
  }

  Future<void> _fetchCartItems() async {
    final List<Map<String, dynamic>> items = await _database!.query('cart');
    setState(() {
      _cartItems = items;
    });
  }

  Future<void> _removeFromCart(int id) async {
    await _database!.delete('cart', where: "id = ?", whereArgs: [id]);
    _fetchCartItems();
    Get.snackbar("Cart", "Product removed successfully!", snackPosition: SnackPosition.BOTTOM);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Cart",
          style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.greenAccent,
      ),
      body: _cartItems.isEmpty
          ? Center(
        child: Text(
          "Your Cart is Empty!",
          style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w500),
        ),
      )
          : ListView.builder(
        itemCount: _cartItems.length,
        itemBuilder: (context, index) {
          var item = _cartItems[index];
          return ListTile(
            title: Text(
              item['name'],
              style: GoogleFonts.poppins(fontSize: 18),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => _removeFromCart(item['id']),
            ),
          );
        },
      ),
    );
  }
}
