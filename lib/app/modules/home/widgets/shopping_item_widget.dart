import 'package:flutter/material.dart';
import 'package:listadecompras/app/core/models/shopping_item_model.dart';

import 'add_new_shopping_item_widget.dart';

class ShoppingItemWidget extends StatelessWidget {
  final String? listName;
  final ShoppingItemModel? item;
  const ShoppingItemWidget({super.key, this.listName, this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return AddNewShoppingItem(
              listName: listName,
              item: item,
            );
          },
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              item!.itemName!,
              style: Theme.of(context).textTheme.headline6!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            Text(
              'Quant.: ${item!.quantity!.toString()}',
              style: Theme.of(context).textTheme.headline6!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
