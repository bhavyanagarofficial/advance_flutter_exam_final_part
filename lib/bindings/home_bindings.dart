import 'package:get/get.dart';
import '../controllers/home_controller.dart/homeController.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
  }
}
