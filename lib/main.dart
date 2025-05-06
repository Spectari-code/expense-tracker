import 'package:flutter/material.dart';

import 'package:expense_tracker/widgets/expenses.dart';

// var kColorScheme = ColorScheme.fromSeed(
//   seedColor: const Color.fromRGBO(83, 86, 255, 1),
// );
var kBackgroundPrimary = const Color.fromRGBO(83, 86, 255, 1);
var kForegroundPrimary = const Color.fromRGBO(223, 245, 255, 1);
var kSecondaryBackground = const Color.fromRGBO(55, 140, 231, 1);
var kCardBackground = const Color.fromRGBO(103, 198, 227, 1);

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData().copyWith(
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: kBackgroundPrimary,
          foregroundColor: kForegroundPrimary,
          titleTextStyle: const TextStyle().copyWith(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        scaffoldBackgroundColor: kSecondaryBackground,
        cardTheme: const CardTheme().copyWith(
          color: kCardBackground,
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kBackgroundPrimary,
            foregroundColor: kForegroundPrimary,
          ),
        ),
        textTheme: ThemeData().textTheme.copyWith(
                titleLarge: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            )),
      ),
      home: const Expenses(),
    ),
  );
}
