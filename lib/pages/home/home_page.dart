import 'package:flutter/material.dart';
import 'package:flutter_final_exam/controller/home_controller.dart';
import 'package:flutter_final_exam/controller/home_local_db_controller.dart';

import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final HomeController homeController = Get.put(HomeController());
  final HomeLocalDbController homeLocalDbController =
      Get.put(HomeLocalDbController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Products"),
        actions: [
          Obx(
            () => (homeLocalDbController.cartProductsList.isEmpty)
                ? InkWell(
                    onTap: () {
                      Get.toNamed('/cart');
                    },
                    child: Icon(Icons.shopping_bag_outlined))
                : Badge.count(
                    count: homeLocalDbController.cartProductsList.length,
                    child: InkWell(
                        onTap: () {
                          Get.toNamed('/cart');
                        },
                        child: Icon(Icons.shopping_bag_outlined))),
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
      body: Obx(
        () {
          if (homeController.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return (homeController.allProductsList.isEmpty)
              ? const Center(
                  child: Text("No Products to show"),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: homeController.allProductsList.length,
                  itemBuilder: (context, index) {
                    final product = homeController.allProductsList[index];
                    return ListTile(
                        leading: Text("${index + 1}"),
                        title: Text(product.productName),
                        subtitle: Text(product.productPrice),
                        trailing: SizedBox(
                          width: 145,
                          child: Row(
                            children: [
                              IconButton(
                                  onPressed: () async {
                                    await homeLocalDbController
                                        .addProductToCart(product);
                                    Get.toNamed('/cart');
                                  },
                                  icon: const Icon(Icons.add)),
                              IconButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: const Text(
                                            "Add Product to Catalogue ?"),
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            TextField(
                                              controller:
                                                  homeController.txtProductName,
                                              decoration: const InputDecoration(
                                                  label: Text("Product Name"),
                                                  border: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          width: 1))),
                                            ),
                                            const SizedBox(
                                              height: 30,
                                            ),
                                            TextField(
                                              controller: homeController
                                                  .txtProductPrice,
                                              decoration: const InputDecoration(
                                                  label: Text("Product Price"),
                                                  border: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          width: 1))),
                                            ),
                                          ],
                                        ),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Get.back();
                                              },
                                              child: const Text("Cancel")),
                                          TextButton(
                                              onPressed: () async {
                                                String productName =
                                                    (homeController
                                                            .txtProductName
                                                            .text
                                                            .isNotEmpty)
                                                        ? homeController
                                                            .txtProductName.text
                                                        : product.productName;
                                                String productPrice =
                                                    (homeController
                                                            .txtProductPrice
                                                            .text
                                                            .isNotEmpty)
                                                        ? homeController
                                                            .txtProductPrice
                                                            .text
                                                        : product.productPrice;
                                                await homeController
                                                    .updateProductInAllProductsList(
                                                        productName,
                                                        productPrice,
                                                        product.productName);
                                                homeController.txtProductName
                                                    .clear();
                                                homeController.txtProductPrice
                                                    .clear();
                                                Get.back();
                                              },
                                              child: const Text("Update")),
                                        ],
                                      ),
                                    );
                                  },
                                  icon: const Icon(Icons.edit)),
                              IconButton(
                                  onPressed: () async {
                                    await homeController
                                        .deleteProductFromAllProducts(
                                            product.productName);
                                  },
                                  icon: const Icon(Icons.delete)),
                            ],
                          ),
                        ));
                  },
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text("Add Product to Catalogue ?"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: homeController.txtProductName,
                    decoration: const InputDecoration(
                        label: Text("Product Name"),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 1))),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextField(
                    controller: homeController.txtProductPrice,
                    decoration: const InputDecoration(
                        label: Text("Product Price"),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 1))),
                  ),
                ],
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: const Text("Cancel")),
                TextButton(
                    onPressed: () {
                      homeController.addProductToAllProducts(
                          homeController.txtProductName.text,
                          homeController.txtProductPrice.text);
                      homeController.txtProductName.clear();
                      homeController.txtProductPrice.clear();
                      Get.back();
                    },
                    child: const Text("Add")),
              ],
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
