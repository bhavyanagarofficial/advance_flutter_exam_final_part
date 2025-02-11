import 'package:get/get.dart';

import '../views/cart_screen.dart/cart.dart';
import '../views/home_screen.dart/home.dart';
import '../views/splash_screen.dart/splash.dart';

class AppRoutes {
  static const String splash = '/';
  static const String home = '/home';
  static const String cart = '/cart';

  static List<GetPage> routes = [
    GetPage(name: splash, page: () => SplashScreen()),
    GetPage(name: home, page: () => HomeScreen()),
    GetPage(name: cart, page: () => CartScreen()),
  ];
}
