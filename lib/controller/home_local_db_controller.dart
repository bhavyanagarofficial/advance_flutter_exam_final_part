import 'package:flutter_final_exam/model/products_model.dart';
import 'package:flutter_final_exam/services/sql/sql_database_services.dart';
import 'package:get/get.dart';

class HomeLocalDbController extends GetxController {
  RxList<ProductsModel> cartProductsList = <ProductsModel>[].obs;

  final SqlDatabaseServices database = SqlDatabaseServices.sqlDatabaseServices;

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    await fetchProductsInCartFromLocalDatabase();
  }

  Future<void> fetchProductsInCartFromLocalDatabase() async {
    cartProductsList.value = await database.fetchProductsFromLocalDatabase();
  }

  Future<void> addProductToCart(ProductsModel product) async {
    await database.addProductToLocalDatabase(product);
    await fetchProductsInCartFromLocalDatabase();
  }

  Future<void> increaseProductQuantity(ProductsModel product) async {
    await database.update(product.copyWith(quantity: product.quantity + 1));
    await fetchProductsInCartFromLocalDatabase();
  }

  Future<void> decreaseProductQuantity(ProductsModel product) async {
    await database.update(product.copyWith(quantity: product.quantity - 1));

    await fetchProductsInCartFromLocalDatabase();
  }

  Future<void> deleteProductFromCart(String productName) async {
    await database.delete(productName);
    await fetchProductsInCartFromLocalDatabase();
  }
}
