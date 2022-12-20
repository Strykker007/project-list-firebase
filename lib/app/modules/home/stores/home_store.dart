import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';

import '../home_repository.dart';

class HomeStore extends NotifierStore<Exception, List<String>> {
  final HomeRepository _repository = Modular.get();
  HomeStore() : super([]);

  Future<void> getShoppingLists() async {
    setLoading(true);
    await _repository.getShoppingLists().then(
      (shoppingList) {
        update(shoppingList);
        setLoading(false);
      },
    ).catchError(
      (onError) {
        setLoading(false);
        setError(onError);
        throw onError;
      },
    );
    setLoading(false);
  }

  Future<void> createShoppingList(String listName) async {
    setLoading(true);
    await _repository.createList(listName).then(
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
