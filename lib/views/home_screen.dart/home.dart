import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _productController = TextEditingController();

  void addProduct() {
    Get.defaultDialog(
      title: "Add Product",
      titleStyle: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold),
      content: Padding(
        padding: const EdgeInsets.all(10.0),
        child: TextField(
          controller: _productController,
          decoration: InputDecoration(
            labelText: "Product Name",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
      ),
      textConfirm: "Add",
      textCancel: "Cancel",
      confirmTextColor: Colors.white,
      onConfirm: () {
        if (_productController.text.isNotEmpty) {
          _firestore.collection('products').add({'name': _productController.text});
          _productController.clear();
          Get.back();
        }
      },
    );
  }

  void _deleteProduct(String id) {
    _firestore.collection('products').doc(id).delete();
  }

  void _editProduct(String id, String currentName) {
    _productController.text = currentName;
    Get.defaultDialog(
      title: "Edit Product",
      content: TextField(
        controller: _productController,
        decoration: InputDecoration(border: OutlineInputBorder()),
      ),
      textConfirm: "Update",
      textCancel: "Cancel",
      confirmTextColor: Colors.white,
      onConfirm: () {
        if (_productController.text.isNotEmpty) {
          _firestore.collection('products').doc(id).update({'name': _productController.text});
          _productController.clear();
          Get.back();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home", style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('products').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

          var products = snapshot.data!.docs;

          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              var product = products[index];
              return ListTile(
                title: Text(
                  product['name'],
                  style: GoogleFonts.poppins(fontSize: 18),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.orange),
                      onPressed: () => _editProduct(product.id, product['name']),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _deleteProduct(product.id),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addProduct,
        child: const Icon(Icons.add),
      ),
    );
  }
}
