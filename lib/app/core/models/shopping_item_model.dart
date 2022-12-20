import 'dart:convert';

class ShoppingItemModel {
  String? itemName;
  int? quantity;
  ShoppingItemModel({
    this.itemName,
    this.quantity,
  });

  Map<String, dynamic> toMap() {
    return {
      'itemName': itemName,
      'quantity': quantity,
    };
  }

  factory ShoppingItemModel.fromMap(Map<String, dynamic> map) {
    return ShoppingItemModel(
      itemName: map['itemName'],
      quantity: map['quantity']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory ShoppingItemModel.fromJson(String source) =>
      ShoppingItemModel.fromMap(json.decode(source));
}
