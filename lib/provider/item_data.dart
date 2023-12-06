import 'package:flutter/material.dart';
import 'package:provider_learn/model/item_model.dart';

class ItemData extends ChangeNotifier {
  // list over all item
  final List<Item> overAllItem = [
    Item(name: "Flour", price: 12.5),
  ];

  // list of item that already bough
  final List<Item> boughtItem = [];

  // Add overAllItem data
  void addItem(Item item) {
    overAllItem.add(item);
    notifyListeners();
  }

  // Add boughtItem data
  void addBoughtItem(Item item) {
    boughtItem.add(item);
    notifyListeners();
  }

  // Remove overAllItem Data
  void removeItem(Item item) {
    overAllItem.remove(item);
    notifyListeners();
  }

  // Remove boughtItem Data
  void removeBoughtItem(Item item) {
    boughtItem.remove(item);
    notifyListeners();
  }

  // count all price
  double calculateAllItemBought() {
    double total = 0;
    for (var i = 0; i < boughtItem.length; i++) {
      total += boughtItem[i].price;
    }
    return total;
  }
}
