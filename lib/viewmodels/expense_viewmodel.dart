import 'package:flutter/material.dart';
import 'package:expense_tracker/data/models/expense.dart';

/// ViewModel for managing expense data
///
/// Provides basic CRUD operations for expense management using
/// Flutter's ChangeNotifier pattern for reactive state management.
class ExpenseViewModel extends ChangeNotifier {
  final List<Expense> _registeredExpenses = [];

  /// Returns the list of all registered expenses
  List<Expense> get registeredExpenses => _registeredExpenses;

  /// Adds a new expense to the list
  ///
  /// [expense] - The expense object to add
  void addExpense(Expense expense) {
    _registeredExpenses.add(expense);
    notifyListeners();
  }

  /// Removes an expense from the list
  ///
  /// [expense] - The expense object to remove
  void removeExpense(Expense expense) {
    _registeredExpenses.remove(expense);
    notifyListeners();
  }

  /// Inserts an expense at a specific position
  ///
  /// Used primarily for undo operations
  /// [index] - The position where to insert the expense
  /// [expense] - The expense object to insert
  void insertExpense(int index, Expense expense) {
    _registeredExpenses.insert(index, expense);
    notifyListeners();
  }
}
