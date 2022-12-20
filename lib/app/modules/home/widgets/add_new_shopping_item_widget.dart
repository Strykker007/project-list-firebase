import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:listadecompras/app/core/models/shopping_item_model.dart';
import 'package:listadecompras/app/modules/home/stores/list_details_store.dart';
import 'package:listadecompras/app/modules/home/widgets/error_dialog_widget.dart';

class AddNewShoppingItem extends StatefulWidget {
  final String? listName;
  final ShoppingItemModel? item;
  const AddNewShoppingItem({super.key, this.listName, this.item});

  @override
  State<AddNewShoppingItem> createState() => _AddNewShoppingItemState();
}

class _AddNewShoppingItemState extends State<AddNewShoppingItem> {
  final ListDetailsStore store = Modular.get();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  @override
  void initState() {
    if (widget.item != null) {
      nameController.text = widget.item!.itemName!;
      quantityController.text = widget.item!.quantity!.toString();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Adicionar nova lista',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headline6!.copyWith(
              fontWeight: FontWeight.bold,
            ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: nameController,
            decoration: const InputDecoration(
              hintText: 'Insira o nome do item da lista',
            ),
          ),
          TextFormField(
            controller: quantityController,
            keyboardType: const TextInputType.numberWithOptions(decimal: false),
            decoration: const InputDecoration(
              hintText: 'Insira a quantidade',
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () async {
            if (widget.item == null) {
              ShoppingItemModel model = ShoppingItemModel(
                itemName: nameController.text,
                quantity: int.parse(quantityController.text),
              );
              store.state.add(model);
            } else {
              int i = 0;
              for (var element in store.state) {
                if (widget.item!.itemName == store.state[i].itemName) {
                  store.state[i].itemName = nameController.text;
                  store.state[i].quantity = int.parse(quantityController.text);
                }
                i++;
              }
            }
            await store
                .saveShoppingListDetails(widget.listName!, store.state)
                .then(
              (value) async {
                await store.getShoppingListDetails(widget.listName!).catchError(
                  (onError) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return const ErrorDialogWidget(
                          message: 'Erro ao carregar as suas listas',
                        );
                      },
                    );
                  },
                );
                Modular.to.pop();
              },
            ).catchError(
              (onError) {
                log('erro ao criar sua lista');
              },
            );
          },
          child: Text(
            'Confirmar',
            style: Theme.of(context).textTheme.headline6!.copyWith(
                  color: Colors.green,
                ),
          ),
        ),
        TextButton(
          onPressed: () {
            Modular.to.pop();
          },
          child: Text(
            'Cancelar',
            style: Theme.of(context).textTheme.headline6!.copyWith(
                  color: Colors.red,
                ),
          ),
        ),
      ],
    );
  }
}
