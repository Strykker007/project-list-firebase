import 'dart:convert';

import 'shopping_item_model.dart';

class ShoppingListModel {
  String? name;
  List<ShoppingItemModel>? shoppingItems;
  ShoppingListModel({
    this.name,
    this.shoppingItems,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'shoppingItems': shoppingItems?.map((x) => x.toMap()).toList(),
    };
  }

  factory ShoppingListModel.fromMap(Map<String, dynamic> map) {
    return ShoppingListModel(
      name: map['name'],
      shoppingItems: map['shoppingItems'] != null
          ? List<ShoppingItemModel>.from(
              map['shoppingItems']?.map((x) => ShoppingItemModel.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ShoppingListModel.fromJson(String source) =>
      ShoppingListModel.fromMap(json.decode(source));
}
