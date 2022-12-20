import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ItemListWidget extends StatelessWidget {
  final String? listName;
  const ItemListWidget({super.key, this.listName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Modular.to.pushNamed(
          '/listDetails',
          arguments: listName,
        );
      },
      child: Container(
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              offset: Offset(-2, 3),
              blurRadius: 2,
              color: Colors.grey,
            ),
          ],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          listName!,
          style: Theme.of(context).textTheme.headline6!.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
    );
  }
}
