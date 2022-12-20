import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ErrorDialogWidget extends StatelessWidget {
  final String? message;
  const ErrorDialogWidget({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Ops! Ocorreu um erro inesperado!',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headline6!.copyWith(
              fontWeight: FontWeight.bold,
            ),
      ),
      content: Text(message!),
      actions: [
        TextButton(
          onPressed: () {
            Modular.to.pop();
          },
          child: const Text('Fechar'),
        ),
      ],
    );
  }
}
