import 'package:flutter/material.dart';
import 'package:expense_tracker/data/models/expense.dart';

/// A bar widget for displaying expense data in charts
///
/// This widget represents a single bar in the expense chart, with a height
/// proportional to the expense value relative to the total expenses.
/// Enhanced with category-specific colors and modern styling.
class ChartBar extends StatelessWidget {
  /// Creates a chart bar widget
  ///
  /// [fill] determines the height of the bar as a fraction of the available space
  /// [category] determines the color of the bar based on expense category
  const ChartBar({
    super.key,
    required this.fill,
    required this.category,
  });

  /// The fill percentage for the bar (0.0 to 1.0)
  ///
  /// This value determines how tall the bar should be relative to the
  /// available space in the chart container.
  final double fill;

  /// The expense category for this bar
  ///
  /// Determines the color and visual styling of the bar.
  final Category category;

  @override
  Widget build(BuildContext context) {
    final barColor = _getCategoryColor(context, category);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: FractionallySizedBox(
          heightFactor: fill,
          alignment: Alignment.bottomCenter,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOutCubic,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  barColor,
                  barColor.withValues(alpha: isDark ? 0.8 : 0.9),
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: barColor.withValues(alpha: 0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
                border: Border.all(
                  color: barColor.withValues(alpha: 0.3),
                  width: 1,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Color _getCategoryColor(BuildContext context, Category category) {
    final colorScheme = Theme.of(context).colorScheme;

    switch (category) {
      case Category.food:
        return colorScheme.primary;
      case Category.travel:
        return colorScheme.secondary;
      case Category.leisure:
        return const Color(0xFF9C27B0); // Purple
      case Category.work:
        return const Color(0xFFFF5722); // Deep Orange
      case Category.utilities:
        return const Color(0xFF4CAF50); // Green
    }
  }
}
