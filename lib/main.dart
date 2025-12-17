import 'package:expense_tracker/viewmodels/expense_viewmodel.dart';
import 'package:expense_tracker/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:expense_tracker/views/screens/expenses_screen.dart';

/// Main entry point for the Expense Tracker application
///
/// This function initializes and runs the Flutter app with:
/// - Provider state management setup
/// - Material 3 theming support
/// - Dark/light theme mode based on system preferences
void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ExpenseViewModel(),
      child: MaterialApp(
        title: 'Expense Tracker',
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.system, // Follows system theme preference
        home: const ExpensesScreen(),
      ),
    ),
  );
}
