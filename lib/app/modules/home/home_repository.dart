import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:listadecompras/app/core/models/shopping_item_model.dart';

class HomeRepository extends Disposable {
  final FirebaseFirestore instance = FirebaseFirestore.instance;
  @override
  void dispose() {}

  Future<List<ShoppingItemModel>> getShoppingListDetails(
      String listName) async {
    List<ShoppingItemModel> list = List.empty(growable: true);
    await instance.collection('shoppingList').doc(listName).get().then(
      (shoppingListItem) {
        for (var element in shoppingListItem.data()!.values) {
          element.forEach(
            (object) {
              list.add(ShoppingItemModel.fromMap(object));
            },
          );
        }
      },
    ).catchError(
      (onError) {
        throw onError;
      },
    );
    return list;
  }

  Future<List<String>> getShoppingLists() async {
    final List<String> shoppingList = List.empty(growable: true);
    await instance.collection('shoppingList').get().then(
      (value) {
        for (var element in value.docs) {
          shoppingList.add(element.id);
        }
      },
    ).catchError(
      (onError) {
        throw onError;
      },
    );
    return shoppingList;
  }

  Future<void> saveList(String? listName, List<ShoppingItemModel> model) async {
    await instance.collection('shoppingList').doc(listName).set(
      {
        'items': model.map((e) => e.toMap()).toList(),
      },
    ).catchError(
      (onError) {
        throw onError;
      },
    );
  }

  Future<void> createList(String? listName) async {
    await instance.collection('shoppingList').doc(listName).set(
      {},
    ).catchError(
      (onError) {
        throw onError;
      },
    );
  }

  Future<void> removeList(String? listName) async {
    instance.collection('shoppingList').doc(listName).delete().catchError(
      (onError) {
        throw onError;
      },
    );
  }
}
