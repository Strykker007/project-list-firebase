import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:listadecompras/app/modules/home/home_repository.dart';

import '../../../core/models/shopping_item_model.dart';

class ListDetailsStore
    extends NotifierStore<Exception, List<ShoppingItemModel>> {
  final HomeRepository _repository = Modular.get();
  ListDetailsStore() : super([]);

  Future<void> getShoppingListDetails(String listName) async {
    setLoading(true);
    await _repository.getShoppingListDetails(listName).then(
      (shoppingList) {
        setLoading(false);
        update(shoppingList);
      },
    ).catchError(
      (onError) {
        setLoading(false);
        throw onError;
      },
    );
    setLoading(false);
  }

  Future<void> removeShoppingList(String listName) async {
    setLoading(true);
    await _repository.removeList(listName).then(
      (shoppingList) {
        setLoading(false);
      },
    ).catchError(
      (onError) {
        setLoading(false);
        throw onError;
      },
    );
    setLoading(false);
  }

  Future<void> saveShoppingListDetails(
      String listName, List<ShoppingItemModel> list) async {
    setLoading(true);
    await _repository.saveList(listName, list).then(
      (shoppingList) {
        setLoading(false);
      },
    ).catchError(
      (onError) {
        setLoading(false);
        throw onError;
      },
    );
    setLoading(false);
  }
}
