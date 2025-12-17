import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

/// Date formatter for displaying expense dates in a user-friendly format
///
/// Formats dates as "15 December 2023" for better readability
/// in the expense list and detail views.
final dateFormatter = DateFormat('d MMMM y');

/// UUID generator for creating unique expense identifiers
///
/// Uses UUID v4 to ensure each expense has a globally unique identifier,
/// preventing conflicts during data synchronization or sharing.
const uuid = Uuid();

/// Categories for organizing expenses
///
/// Defines the available expense categories that users can select
/// when creating or editing expenses. Each category helps users
/// organize and track their spending patterns.
enum Category {
  /// Food and dining expenses including restaurants, groceries, and delivery services
  food,

  /// Travel-related expenses including flights, hotels, transportation, and tourism
  travel,

  /// Entertainment and leisure activities including movies, games, hobbies, and recreation
  leisure,

  /// Work-related expenses including office supplies, software, professional development, and commuting
  work,

  /// Utility bills including electricity, water, internet, phone services, and other household expenses
  utilities,
}

/// Icon mapping for expense categories
///
/// Provides consistent, bold Material Design icons for each expense category
/// to enhance visual recognition and create a cohesive user experience.
/// All icons use filled variants for better visual impact.
const categoryIcons = {
  Category.food: Icons.restaurant,
  Category.travel: Icons.flight,
  Category.leisure: Icons.movie,
  Category.work: Icons.work,
  Category.utilities: Icons.electrical_services,
};

/// Represents a single expense entry in the expense tracker
///
/// This class encapsulates all information about an expense including
/// its unique identifier, title, amount, date, and category. Each expense
/// automatically gets a unique ID when created to ensure data integrity.
class Expense {
  /// Creates a new expense with the required properties
  ///
  /// [title] - The title or description of the expense (e.g., "Coffee", "Groceries")
  /// [amount] - The monetary amount of the expense (must be positive)
  /// [date] - When the expense was incurred
  /// [category] - The category type for organizing the expense
  ///
  /// A unique [id] is automatically generated using UUID v4 format
  /// to ensure no two expenses have the same identifier.
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();

  /// Unique identifier for this expense
  ///
  /// Automatically generated using UUID v4 format to ensure
  /// global uniqueness across different devices and sessions.
  final String id;

  /// The title or description of the expense
  ///
  /// A user-friendly description of what the expense was for.
  /// Examples: "Morning Coffee", "Uber to Airport", "Monthly Netflix"
  final String title;

  /// The monetary amount of the expense
  ///
  /// Stored as a double to support decimal values for currency.
  /// Should always be a positive value representing the cost.
  final double amount;

  /// The date when the expense was incurred
  ///
  /// Represents the actual date of the expense transaction,
  /// not necessarily when it was recorded in the app.
  final DateTime date;

  /// The category classification for this expense
  ///
  /// Used for organizing expenses by type and generating
  /// spending reports and visualizations.
  final Category category;

  /// Returns a formatted date string for display purposes
  ///
  /// Uses the global [dateFormatter] to create a user-friendly
  /// date representation (e.g., "15 December 2023").
  String get formattedDate {
    return dateFormatter.format(date);
  }

  /// Creates a string representation of the expense
  ///
  /// Useful for debugging and logging purposes.
  @override
  String toString() {
    return 'Expense(id: $id, title: $title, amount: R ${amount.toStringAsFixed(2)}, date: $formattedDate, category: $category)';
  }

  /// Compares two expenses for equality
  ///
  /// Expenses are considered equal if they have the same ID,
  /// since IDs are guaranteed to be unique.
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Expense && other.id == id;
  }

  /// Returns a hash code for the expense
  ///
  /// Uses the expense ID for hashing to ensure consistent
  /// equality comparisons and efficient storage in collections.
  @override
  int get hashCode => id.hashCode;
}

/// Represents a collection of expenses grouped by category
///
/// This class is used for charting and analytics, providing
/// aggregated expense data for a specific category. It helps
/// calculate totals and generate visual representations of spending.
class ExpenseBucket {
  /// Creates an expense bucket for a specific category
  ///
  /// [category] - The category this bucket represents
  /// [expenses] - List of expenses belonging to this category
  const ExpenseBucket({
    required this.category,
    required this.expenses,
  });

  /// Utility constructor to create a bucket by filtering expenses
  ///
  /// Creates an [ExpenseBucket] containing only the expenses that match
  /// the specified [category] from the provided [allExpenses] list.
  ///
  /// This constructor is commonly used for generating chart data where
  /// expenses need to be separated by category for visualization.
  ///
  /// Example:
  /// ```dart
  /// final foodBucket = ExpenseBucket.forCategory(allExpenses, Category.food);
  /// ```
  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses
            .where((expense) => expense.category == category)
            .toList();

  /// The category this bucket represents
  final Category category;

  /// List of expenses in this category
  final List<Expense> expenses;

  /// Calculates the total amount of all expenses in this bucket
  ///
  /// Sums up all expense amounts to provide the total spending
  /// for this category. This value is used in charts to show
  /// the proportion of spending in each category.
  ///
  /// Returns 0.0 if there are no expenses in this bucket.
  double get totalExpenses {
    return expenses.fold(0.0, (sum, expense) => sum + expense.amount);
  }

  /// Returns the number of expenses in this bucket
  ///
  /// Useful for analytics and understanding the frequency
  /// of expenses in each category.
  int get expenseCount => expenses.length;

  /// Creates a string representation of the bucket
  ///
  /// Useful for debugging and logging category summaries.
  @override
  String toString() {
    return 'ExpenseBucket(category: $category, count: $expenseCount, total: R ${totalExpenses.toStringAsFixed(2)})';
  }
}
