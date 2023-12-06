import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_learn/provider/item_data.dart';
import 'package:provider_learn/screens/home_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider<ItemData>(
      create: (_) => ItemData(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        "/": (context) => Home(),
      },
    );
  }
}
