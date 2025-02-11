import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(
        const Duration(milliseconds: 2000), () => Get.offNamed('/home'));

    return Scaffold(
      body: Center(
        child: Container(
          height: 200,
          width: 200,
          child: Image.asset("assets/icon/icon_prev_ui.png"),
        ),
      ),
    );
  }
}
