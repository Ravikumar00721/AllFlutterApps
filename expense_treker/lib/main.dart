import 'package:flutter/material.dart';
import 'package:expense_treker/Widgets/expenses.dart';

// Define a color scheme using a seed color
var kColorScheme = ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 181, 63, 59));
var kDarkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 0, 0, 0));

void main() {
  
  runApp(MaterialApp(
    darkTheme: ThemeData.dark().copyWith(
      useMaterial3: true,
      colorScheme: kDarkColorScheme,
      cardTheme: CardTheme().copyWith(
        color: kDarkColorScheme.secondaryContainer,
        margin: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: kDarkColorScheme.primaryContainer,
          foregroundColor: kDarkColorScheme.onPrimaryContainer
        )
      ),
    ),
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: kColorScheme,
      appBarTheme: AppBarTheme(
        backgroundColor: kColorScheme.onPrimaryContainer,
        foregroundColor: kColorScheme.primaryContainer,
      ),
      cardTheme: CardTheme().copyWith(
        color: kColorScheme.secondaryContainer,
        margin: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: kColorScheme.primaryContainer
        )
      ),
      textTheme: ThemeData().textTheme.copyWith(
        titleLarge:const  TextStyle(
          fontWeight: FontWeight.normal,
          color: Colors.red,
          fontSize: 14
        )
      )
    ),
    themeMode: ThemeMode.system,
    // Define the home widget
    home: const Expenses(),
  ));
}
