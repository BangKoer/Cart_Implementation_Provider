import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:provider_learn/model/item_model.dart';
import 'package:provider/provider.dart';
import 'package:provider_learn/provider/item_data.dart';

class CalculateTab extends StatelessWidget {
  const CalculateTab({
    super.key,
    required this.boughtItem,
  });

  final List<Item> boughtItem;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: boughtItem.length,
          itemBuilder: (_, index) {
            final currentItem = boughtItem[index];
            return Container(
              key: ValueKey(currentItem.name),
              child: Slidable(
                endActionPane:
                    ActionPane(motion: const StretchMotion(), children: [
                  // delete button
                  SlidableAction(
                    onPressed: (context) {
                      context.read<ItemData>().removeItem(currentItem);
                      context.read<ItemData>().removeBoughtItem(currentItem);
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
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Container(
                height: 50,
                child: IntrinsicWidth(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      "Total : \$${context.watch<ItemData>().calculateAllItemBought()}",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
