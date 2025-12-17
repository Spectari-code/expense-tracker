import 'package:flutter/material.dart';

import 'package:expense_tracker/data/models/expense.dart';

import 'package:expense_tracker/views/widgets/expenses_list/expense_item.dart';

/// A dismissible list widget that displays expenses
///
/// This widget renders a list of expenses with swipe-to-delete functionality.
/// When a user swipes left or right on an expense item, it triggers the
/// onRemoveExpense callback to remove the expense from the list.
class ExpensesList extends StatelessWidget {
  /// Creates an expense list widget
  ///
  /// [expenses] is the list of expense objects to display
  /// [onRemoveExpense] is the callback function called when an expense is dismissed
  const ExpensesList({
    super.key,
    required this.expenses,
    required this.onRemoveExpense,
  });

  /// The list of expenses to display in the list
  final List<Expense> expenses;

  /// Callback function triggered when an expense is swiped away
  ///
  /// This function receives the expense object that was dismissed
  /// and should handle its removal from the data source.
  final void Function(Expense expense) onRemoveExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (context, index) => Dismissible(
        // Background shown when the item is dismissed
        background: Container(
          // Use withValues() instead of deprecated withOpacity()
          color: Theme.of(context).colorScheme.error.withValues(alpha: 0.75),
          margin: EdgeInsets.symmetric(
              horizontal: Theme.of(context).cardTheme.margin!.horizontal),
        ),
        // Unique key for the dismissible widget
        key: ValueKey(
          ExpenseItem(expenses[index]),
        ),
        // Handle the dismiss action
        onDismissed: (direction) {
          onRemoveExpense(expenses[index]);
        },
        // The actual expense item widget
        child: ExpenseItem(expenses[index]),
      ),
    );
  }
}
