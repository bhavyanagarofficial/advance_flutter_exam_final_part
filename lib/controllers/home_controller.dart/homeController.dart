import 'package:get/get.dart';
import '../../models/productModels.dart';
import '../../repository/productRespository.dart';

class HomeController extends GetxController {
  final ProductRepository productRepo = ProductRepository();
  var products = <ProductModel>[].obs;

  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }

  void fetchProducts() async {
    var data = await productRepo.getProducts();
    products.assignAll(data);
  }
}
