import '../database/cartDb.dart';
import '../models/cartModels.dart';

class CartRepository {
  final CartDB _cartDB = CartDB();

  Future<List<CartModel>> getCartItems() => _cartDB.getCartItems();
  Future<void> addToCart(CartModel item) => _cartDB.insertCartItem(item);
  Future<void> removeFromCart(int id) => _cartDB.deleteCartItem(id.toString());
}
