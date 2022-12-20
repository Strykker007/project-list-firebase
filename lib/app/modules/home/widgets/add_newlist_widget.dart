import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:listadecompras/app/modules/home/widgets/error_dialog_widget.dart';

import '../stores/home_store.dart';

class AddNewlistWidget extends StatefulWidget {
  const AddNewlistWidget({super.key});

  @override
  State<AddNewlistWidget> createState() => _AddNewlistWidgetState();
}

class _AddNewlistWidgetState extends State<AddNewlistWidget> {
  final HomeStore store = Modular.get();
  final TextEditingController nameController = TextEditingController();
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
      content: TextFormField(
        controller: nameController,
        decoration: const InputDecoration(
          hintText: 'Insira aqui o título da lista',
        ),
      ),
      actions: [
        TextButton(
          onPressed: () async {
            await store.createShoppingList(nameController.text).then(
              (value) async {
                await store.getShoppingLists().catchError(
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
            style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(color: Colors.green),
          ),
        ),
        TextButton(
          onPressed: () {
            Modular.to.pop();
          },
          child: Text(
            'Cancelar',
            style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(color: Colors.red),
          ),
        ),
      ],
    );
  }
}
