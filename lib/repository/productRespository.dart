import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/productModels.dart';

class ProductRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addProduct(ProductModel product) async {
    await _firestore.collection('products').add(product.toJson());
  }

  Future<List<ProductModel>> getProducts() async {
    QuerySnapshot snapshot = await _firestore.collection('products').get();
    return snapshot.docs.map((doc) {
      return ProductModel.fromJson(doc.data() as Map<String, dynamic>);
    }).toList();
  }

  Future<void> updateProduct(String id, ProductModel product) async {
    await _firestore.collection('products').doc(id).update(product.toJson());
  }

  Future<void> deleteProduct(String id) async {
    await _firestore.collection('products').doc(id).delete();
  }
}
