import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:listadecompras/app/modules/home/stores/home_store.dart';
import 'package:listadecompras/app/modules/home/stores/list_details_store.dart';
import 'package:listadecompras/app/modules/home/widgets/add_new_shopping_item_widget.dart';
import 'package:listadecompras/app/modules/home/widgets/shopping_item_widget.dart';
import 'package:listadecompras/app/modules/home/widgets/success_dialog_widget.dart';

import '../widgets/error_dialog_widget.dart';

class ListDetailsPage extends StatefulWidget {
  final String? listName;
  const ListDetailsPage({super.key, this.listName});

  @override
  State<ListDetailsPage> createState() => _ListDetailsPageState();
}

class _ListDetailsPageState extends State<ListDetailsPage> {
  final ListDetailsStore store = Modular.get();
  final HomeStore homeStore = Modular.get();
  @override
  void initState() {
    store.getShoppingListDetails(widget.listName!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.listName!),
        actions: [
          IconButton(
            onPressed: () async {
              await store.removeShoppingList(widget.listName!).then(
                (value) async {
                  await showDialog(
                    context: context,
                    builder: (context) {
                      return const SuccessDialogWidget(
                        message: 'Lista removida com sucesso!',
                      );
                    },
                  );
                  await homeStore.getShoppingLists();

                  Modular.to.pop();
                },
              ).catchError(
                (onError) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return const ErrorDialogWidget(
                        message: 'Erro ao remover sua lista',
                      );
                    },
                  );
                },
              );
            },
            icon: const Icon(
              Icons.remove,
              color: Colors.red,
            ),
          ),
        ],
      ),
      body: TripleBuilder(
        store: store,
        builder: (context, triple) {
          if (triple.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (store.state.isEmpty) {
            return const Center(
              child: Text('Clique no icone + para adicionar uma nova lista'),
            );
          }
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: store.state.length,
                  itemBuilder: (context, index) {
                    return ShoppingItemWidget(
                      listName: widget.listName,
                      item: store.state[index],
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AddNewShoppingItem(
                listName: widget.listName,
              );
            },
          );
        },
        label: Row(
          children: const [
            Text('Adicionar item'),
            SizedBox(width: 5),
            Icon(Icons.add),
          ],
        ),
      ),
    );
  }

  Future<void> showInSnackBar(String value, Color color) async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: color,
        content: Text(
          value,
          style: Theme.of(context).textTheme.headline5!.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).backgroundColor,
              ),
        ),
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
