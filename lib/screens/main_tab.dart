import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider_learn/model/item_model.dart';
import 'package:provider/provider.dart';
import 'package:provider_learn/provider/item_data.dart';

class MainTab extends StatelessWidget {
  const MainTab({
    super.key,
    required this.items,
    required this.boughtItem,
  });

  final List<Item> items;
  final List<Item> boughtItem;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (_, index) {
        final currentItem = items[index];
        return Container(
          key: ValueKey(currentItem.name),
          child: Slidable(
            endActionPane: ActionPane(motion: const StretchMotion(), children: [
              // delete button
              SlidableAction(
                onPressed: (context) {
                  context.read<ItemData>().removeItem(currentItem);
                },
                icon: Icons.delete,
                backgroundColor: Colors.red,
              )
            ]),
            child: ListTile(
              title: Text(currentItem.name),
              subtitle: Text("\$ ${currentItem.price.toString()}"),
              trailing: IconButton(
                onPressed: () {
                  if (!boughtItem.contains(currentItem)) {
                    context.read<ItemData>().addBoughtItem(currentItem);
                  } else {
                    context.read<ItemData>().removeBoughtItem(currentItem);
                  }
                },
                icon: Icon(
                  Icons.shopping_cart,
                  color: boughtItem.contains(currentItem)
                      ? Colors.green
                      : Colors.black,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
