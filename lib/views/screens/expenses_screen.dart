import 'package:expense_tracker/viewmodels/expense_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:expense_tracker/data/models/expense.dart';

import 'package:expense_tracker/views/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/views/widgets/chart/chart.dart';
import 'package:expense_tracker/views/widgets/new_expense.dart';

/// Main screen for displaying and managing expenses
///
/// This screen serves as the primary interface for the expense tracker app.
/// It displays a chart showing expense distribution by category and a list
/// of all expenses with options to add new expenses or remove existing ones.
///
/// The screen uses the Provider pattern to listen for changes in the
/// ExpenseViewModel and automatically updates the UI when data changes.
class ExpensesScreen extends StatefulWidget {
  /// Creates the expenses screen
  const ExpensesScreen({super.key});

  @override
  State<ExpensesScreen> createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  /// Opens the add expense modal bottom sheet
  ///
  /// Displays a modal bottom sheet containing the NewExpense form
  /// with enhanced Material 3 styling and proper elevation.
  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      useSafeArea: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      builder: (ctx) => NewExpense(onAddExpense: (expense) {
        // Add the new expense through the ViewModel without listening to changes
        Provider.of<ExpenseViewModel>(context, listen: false)
            .addExpense(expense);
      }),
    );
  }

  /// Removes an expense with undo functionality
  ///
  /// Removes the expense from the ViewModel and shows a SnackBar
  /// with an undo option. If the user taps undo within 3 seconds,
  /// the expense is restored to its original position.
  ///
  /// [expense] - The expense to remove
  void _removeExpense(Expense expense) {
    // Store the original index for potential undo operation
    final expenseIndex = Provider.of<ExpenseViewModel>(context, listen: false)
        .registeredExpenses
        .indexOf(expense);

    // Remove the expense from the ViewModel
    Provider.of<ExpenseViewModel>(context, listen: false)
        .removeExpense(expense);

    // Clear any existing snack bars to avoid stacking
    ScaffoldMessenger.of(context).clearSnackBars();

    // Show a snackbar with undo option
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Expense deleted'),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            // Restore the expense to its original position
            Provider.of<ExpenseViewModel>(context, listen: false)
                .insertExpense(expenseIndex, expense);
          },
        ),
      ),
    );
  }

  /// Builds the main UI for the expenses screen
  ///
  /// Creates a responsive layout with:
  /// - An app bar with title and add button
  /// - A chart showing expense distribution (only shown on wider screens)
  /// - Either an empty state message or the expenses list
  /// - Responsive design that adapts to screen width
  ///
  /// Uses Consumer&lt;ExpenseViewModel&gt; to automatically rebuild when
  /// expense data changes.
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Consumer<ExpenseViewModel>(
      builder: (context, viewModel, child) {
        Widget mainContent = Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Theme.of(context)
                      .colorScheme
                      .primaryContainer
                      .withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.receipt_long,
                  size: 64,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'No expenses yet',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                'Start tracking your expenses by adding your first one',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: _openAddExpenseOverlay,
                icon: const Icon(Icons.add),
                label: const Text('Add First Expense'),
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        );

        if (viewModel.registeredExpenses.isNotEmpty) {
          mainContent = ExpensesList(
            expenses: viewModel.registeredExpenses,
            onRemoveExpense: _removeExpense,
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Theme.of(context)
                        .colorScheme
                        .onPrimary
                        .withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.account_balance_wallet,
                    size: 20,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
                const SizedBox(width: 12),
                const Text('Expense Tracker'),
              ],
            ),
            centerTitle: true,
            actions: [
              Container(
                margin: const EdgeInsets.only(right: 16),
                decoration: BoxDecoration(
                  color: Theme.of(context)
                      .colorScheme
                      .onPrimary
                      .withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: IconButton(
                  onPressed: _openAddExpenseOverlay,
                  icon: const Icon(Icons.add),
                  tooltip: 'Add Expense',
                ),
              ),
            ],
          ),
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Theme.of(context).colorScheme.surface,
                  Theme.of(context).colorScheme.surface.withValues(alpha: 0.95),
                ],
              ),
            ),
            child: width < 600
                ? Column(
                    children: [
                      Chart(
                        expenses: viewModel.registeredExpenses,
                      ),
                      Expanded(child: mainContent),
                    ],
                  )
                : Row(
                    children: [
                      Expanded(
                        child: Chart(
                          expenses: viewModel.registeredExpenses,
                        ),
                      ),
                      const VerticalDivider(width: 1),
                      Expanded(child: mainContent),
                    ],
                  ),
          ),
        );
      },
    );
  }
}
