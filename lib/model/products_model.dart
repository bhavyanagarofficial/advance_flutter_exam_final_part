class ProductsModel {
  final String productName;
  final String productPrice;
  final int quantity;

  ProductsModel(
      {required this.productName,
      required this.productPrice,
      this.quantity = 0});

  Map<String, dynamic> toMap() {
    return {
      'productName': productName,
      'productPrice': productPrice,
      'quantity': quantity,
    };
  }

  factory ProductsModel.fromMap(Map map) {
    return ProductsModel(
      productName: map['productName'] as String,
      productPrice: map['productPrice'] as String,
      quantity: map['quantity'] ?? 1,
    );
  }

  ProductsModel copyWith({
    String? productName,
    String? productPrice,
    int? quantity,
  }) {
    return ProductsModel(
      productName: productName ?? this.productName,
      productPrice: productPrice ?? this.productPrice,
      quantity: quantity ?? this.quantity,
    );
  }
}
