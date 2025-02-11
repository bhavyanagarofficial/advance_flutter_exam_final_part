import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreServices {
  static final FireStoreServices fireStoreServices = FireStoreServices._();
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;
  FireStoreServices._();

  Future<void> addProductToFireStore(
      String productName, String productPrice) async {
    await fireStore.collection('products').doc().set({
      'productName': productName,
      'productPrice': productPrice,
    });
  }

  Future<QuerySnapshot<Map<String, dynamic>>> readDataFromFireStore() async {
    final QuerySnapshot<Map<String, dynamic>> allProducts =
        await fireStore.collection('products').get();
    return allProducts;
  }

  Future<void> deleteProductFromFireStore(String productName) async {
    final documentId = await fireStore
        .collection('products')
        .where('productName', isEqualTo: productName)
        .get();
    await fireStore
        .collection("products")
        .doc(documentId.docs.first.id)
        .delete();
  }

  Future<void> updateProductInFireStore(
    String productName,
    String productPrice,
    String oldProductName,
  ) async {
    final documentId = await fireStore
        .collection('products')
        .where('productName', isEqualTo: oldProductName)
        .get();
    await fireStore
        .collection("products")
        .doc(documentId.docs.first.id)
        .update({
      'productName': productName,
      'productPrice': productPrice,
    });
  }
}
