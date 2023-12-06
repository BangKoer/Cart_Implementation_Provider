import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_learn/model/item_model.dart';
import 'package:provider_learn/provider/item_data.dart';
import 'package:provider_learn/screens/calculate_tab.dart';
import 'package:provider_learn/screens/main_tab.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // add textfield controller
  final itemNameField_controller = TextEditingController();
  final itemPriceField_controller = TextEditingController();

  // for navigating through navigation
  int currentPage = 0;

  // method to clear All field
  void clear() {
    itemNameField_controller.clear();
    itemPriceField_controller.clear();
  }

  // method to add data
  void addItem() {
    if (itemNameField_controller.text.isNotEmpty &&
        itemPriceField_controller.text.isNotEmpty) {
      context.read<ItemData>().addItem(
            Item(
              name: itemNameField_controller.text,
              price: double.parse(itemPriceField_controller.text),
            ),
          );
    }
    Navigator.pop(context);
    clear();
  }

  // method to showdialog to add data
  void addNewItemBuy() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Add New Item"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Item Name
            TextField(
              decoration: InputDecoration(labelText: "Item Name"),
              controller: itemNameField_controller,
            ),
            // Price Name
            TextField(
              decoration: InputDecoration(labelText: "Item Price"),
              controller: itemPriceField_controller,
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          // save button
          MaterialButton(
            onPressed: addItem,
            child: Text(
              'Add',
              style: TextStyle(color: Colors.white),
            ),
            color: Colors.green,
          ),
          // Cancel button
          MaterialButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'Cancel',
              style: TextStyle(color: Colors.white),
            ),
            color: Colors.red,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List _tabs = [
      MainTab(
          items: context.watch<ItemData>().overAllItem,
          boughtItem: context.watch<ItemData>().boughtItem),
      CalculateTab(boughtItem: context.watch<ItemData>().boughtItem)
    ];
    return Scaffold(
      backgroundColor: Colors.grey[200],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentPage,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.grey[200],
        selectedItemColor: Colors.green,
        iconSize: 30,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calculate),
            label: "Calculation",
          ),
        ],
        onTap: (index) {
          setState(() {
            currentPage = index;
          });
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: addNewItemBuy,
        child: Icon(Icons.add, size: 40),
        backgroundColor: Colors.black,
      ),
      appBar: AppBar(
        toolbarHeight: 70,
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          "Buy List",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: Colors.black,
          ),
        ),
      ),
      body: _tabs[currentPage],
    );
  }
}
