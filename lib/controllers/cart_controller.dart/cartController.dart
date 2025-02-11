import 'package:get/get.dart';
import 'package:shopping_list/models/cartModels.dart';
import 'package:shopping_list/models/productModels.dart';
import '../../database/db_helper.dart';

class CartController extends GetxController {
  final DBHelper dbHelper = DBHelper();
  var cartItems = <ProductModel>[].obs;

  @override
  void onInit() {
    fetchCartItems();
    super.onInit();
  }

  void fetchCartItems() async {
    var data = await dbHelper.getCartItems();
    cartItems.assignAll(data as Iterable<ProductModel>);
  }

  void addToCart(ProductModel product) async {
    await dbHelper.insertCartItem(product as CartModel);
    fetchCartItems();
  }

  void removeFromCart(String id) async {
    await dbHelper.deleteCartItem(id);
    fetchCartItems();
  }
}
