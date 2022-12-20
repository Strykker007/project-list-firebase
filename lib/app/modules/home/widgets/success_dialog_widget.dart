import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SuccessDialogWidget extends StatelessWidget {
  final String? message;
  const SuccessDialogWidget({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        message!,
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
