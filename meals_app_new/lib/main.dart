import 'package:flutter/material.dart';

import 'categories.dart';

void main() {
  runApp(const MyApp());
}

final ThemeData mytheme = ThemeData(
  primarySwatch: Colors.blue,
  brightness: Brightness.light,
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: mytheme,
      home: const Categories(),
    );
  }
}
