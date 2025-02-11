class CartModel {
  final int? id;
  final String name;

  CartModel({this.id, required this.name});

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name};
  }
}
