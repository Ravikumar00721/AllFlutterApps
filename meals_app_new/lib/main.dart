import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app_new/screen/tabs.dart';

void main() {
  runApp(const ProviderScope(
    child: MyApp(),
  ));
}

final ThemeData myTheme = ThemeData(
  brightness: Brightness.dark, // Set the brightness to dark
  primarySwatch: Colors.blue,
  colorScheme: ColorScheme.fromSwatch(
    primarySwatch: Colors.blue,
    brightness: Brightness.dark, // Match the brightness
    backgroundColor: Colors.black,
    accentColor: Colors.amber, // Set the secondary color
  ),
  scaffoldBackgroundColor:
      Colors.black, // Ensure the scaffold background is black
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: myTheme,
      home: const TabsScreen(),
    );
  }
}
