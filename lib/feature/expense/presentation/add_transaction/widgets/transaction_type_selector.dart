import 'package:flutter/material.dart';
import 'package:spend_wise/core/theme/app_colors.dart';

class TransactionTypeSelector extends StatelessWidget {
  final VoidCallback onExpenseTap;
  final VoidCallback onIncomeTap;
  const TransactionTypeSelector({
    super.key,
    required this.onExpenseTap,
    required this.onIncomeTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Add Transaction",
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onIncomeTap,

              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(AppColors.income),
              ),
              child: Text(
                'Add Income',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(),
              ),
            ),
          ),

          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onExpenseTap,
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.orange),
              ),
              child: Text(
                'Add Expense',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
