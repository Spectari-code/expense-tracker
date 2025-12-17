import 'package:expense_tracker/views/widgets/chart/chart_bar.dart';
import 'package:flutter/material.dart';

import 'package:expense_tracker/data/models/expense.dart';

class Chart extends StatelessWidget {
  const Chart({super.key, required this.expenses});

  final List<Expense> expenses;

  List<ExpenseBucket> get buckets {
    return [
      ExpenseBucket.forCategory(expenses, Category.food),
      ExpenseBucket.forCategory(expenses, Category.travel),
      ExpenseBucket.forCategory(expenses, Category.leisure),
      ExpenseBucket.forCategory(expenses, Category.work),
      ExpenseBucket.forCategory(expenses, Category.utilities),
    ];
  }

  double get maxTotalExpense {
    double maxTotalExpense = 0;

    for (final bucket in buckets) {
      if (bucket.totalExpenses > maxTotalExpense) {
        maxTotalExpense = bucket.totalExpenses;
      }
    }
    return maxTotalExpense;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Card(
      margin: const EdgeInsets.all(16),
      elevation: 8,
      shadowColor: Theme.of(context).colorScheme.shadow.withValues(alpha: 0.2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        width: double.infinity,
        height: 240,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: isDark
              ? Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.3)
              : Theme.of(context).colorScheme.primary.withValues(alpha: 0.05),
        ),
        child: Column(
          children: [
            // Chart title
            Text(
              'Spending Overview',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 20),

            // Chart bars
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  for (final bucket in buckets)
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: ChartBar(
                          fill: bucket.totalExpenses == 0
                              ? 0
                              : bucket.totalExpenses / maxTotalExpense,
                          category: bucket.category,
                        ),
                      ),
                    )
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Category icons and labels
            Row(
              children: buckets
                  .map(
                    (bucket) => Expanded(
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: _getCategoryColor(context, bucket.category).withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              categoryIcons[bucket.category],
                              size: 24,
                              color: _getCategoryColor(context, bucket.category),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            _getCategoryLabel(bucket.category),
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).colorScheme.onSurfaceVariant,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            )
          ],
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

  String _getCategoryLabel(Category category) {
    switch (category) {
      case Category.food:
        return 'Food';
      case Category.travel:
        return 'Travel';
      case Category.leisure:
        return 'Leisure';
      case Category.work:
        return 'Work';
      case Category.utilities:
        return 'Utilities';
    }
  }
}
