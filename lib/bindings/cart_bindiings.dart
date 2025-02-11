import 'package:get/get.dart';
import '../controllers/cart_controller.dart/cartController.dart';

class CartBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CartController>(() => CartController());
  }
}
