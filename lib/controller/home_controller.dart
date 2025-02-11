import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_final_exam/model/products_model.dart';
import 'package:flutter_final_exam/services/firestore/firestore_services.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxList<ProductsModel> allProductsList = <ProductsModel>[].obs;
  TextEditingController txtProductName = TextEditingController();
  TextEditingController txtProductPrice = TextEditingController();
  final FireStoreServices fireStore = FireStoreServices.fireStoreServices;
  RxBool isLoading = false.obs;

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    await fetchData();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    txtProductName.dispose();
    txtProductPrice.dispose();
    super.onClose();
  }

  Future<void> fetchData() async {
    isLoading.value = true;
    final value = await fireStore.readDataFromFireStore();
    print("$value--------------------");
    if (value.docs.isNotEmpty) {
      allProductsList.clear();
      for (var product in value.docs) {
        print(product.data());
        allProductsList.add(ProductsModel.fromMap(product.data()));
      }
    } else {
      allProductsList.value = [];
    }
    isLoading.value = false;
  }

  Future<void> addProductToAllProducts(
      String productName, String productPrice) async {
    await fireStore.addProductToFireStore(productName, productPrice);
    await fireStore.readDataFromFireStore().then((data) {
      allProductsList.clear();
      for (var product in data.docs) {
        allProductsList.add(ProductsModel.fromMap(product.data()));
      }
    });
    await fetchData();
  }

  Future<void> deleteProductFromAllProducts(String productName) async {
    await fireStore.deleteProductFromFireStore(productName);
    await fetchData();
  }

  Future<void> updateProductInAllProductsList(
    String productName,
    String productPrice,
    String oldProductName,
  ) async {
    await fireStore.updateProductInFireStore(
      productName,
      productPrice,
      oldProductName,
    );
    await fetchData();
  }
}
