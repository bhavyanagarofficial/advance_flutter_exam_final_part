import 'package:flutter/material.dart';
import 'package:flutter_final_exam/controller/home_local_db_controller.dart';
import 'package:get/get.dart';

class CartScreen extends StatelessWidget {
  CartScreen({super.key});
  final HomeLocalDbController homeLocalDbController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping Cart'),
      ),
      body: Obx(
        () {
          if (homeLocalDbController.cartProductsList.isEmpty) {
            return const Center(
              child: Text('Your shopping cart is empty.'),
            );
          }

          return ListView.builder(
              itemCount: homeLocalDbController.cartProductsList.length,
              itemBuilder: (context, index) {
                final product = homeLocalDbController.cartProductsList[index];
                return ListTile(
                  title: Text(product.productName),
                  subtitle: Text(product.productPrice),
                  trailing: SizedBox(
                    width: 170,
                    child: Row(
                      children: [
                        IconButton(
                            onPressed: () async {
                              if (product.quantity > 1) {
                                await homeLocalDbController
                                    .decreaseProductQuantity(product);
                              }
                            },
                            icon: Icon(Icons.remove)),
                        Text(product.quantity.toString()),
                        IconButton(
                            onPressed: () async {
                              await homeLocalDbController
                                  .increaseProductQuantity(product);
                            },
                            icon: Icon(Icons.add)),
                        IconButton(
                            onPressed: () async {
                              await homeLocalDbController
                                  .deleteProductFromCart(product.productName);
                            },
                            icon: Icon(Icons.delete))
                      ],
                    ),
                  ),
                );
              });
        },
      ),
    );
  }
}
