import 'package:flutter/material.dart';
import 'package:spend_wise/core/theme/app_colors.dart';
import 'package:spend_wise/feature/expense/domain/entities/category_entity.dart';
import 'package:spend_wise/feature/expense/domain/entities/transaction_entity.dart';
import 'package:spend_wise/feature/expense/domain/entities/transaction_type.dart';

class TransactionList extends StatelessWidget {
  final List<TransactionEntity> transactions;
  final List<CategoryEntity> categories;

  const TransactionList({
    super.key,
    required this.transactions,
    required this.categories,
  });

  @override
  Widget build(BuildContext context) {
    if (transactions.isEmpty) {
      return const Center(child: Text('No transactions yet'));
    }

    return ListView.separated(
      padding: const EdgeInsets.only(bottom: 100),
      itemCount: transactions.length,
      separatorBuilder: (_, _) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final tx = transactions[index];
        final isExpense = tx.type == TransactionType.expense;

        return InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: () {},
          child: Ink(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: AppColors.surface,
              boxShadow: [
                BoxShadow(
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                  color: AppColors.background.withValues(alpha: 0.4),
                ),
              ],
            ),
            child: Row(
              children: [
                /// ICON
                Container(
                  height: 44,
                  width: 44,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: (isExpense ? AppColors.expense : AppColors.income)
                        .withValues(alpha: 0.12),
                  ),
                  child: Icon(
                    isExpense ? Icons.arrow_upward : Icons.arrow_downward,
                    color: isExpense ? AppColors.expense : AppColors.income,
                  ),
                ),

                const SizedBox(width: 14),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tx.categoryName,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),

                      const SizedBox(height: 4),
                      Text(
                        _formatDate(tx.dateTime),
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.textMuted,
                        ),
                      ),
                    ],
                  ),
                ),

                Text(
                  '${isExpense ? '-' : '+'}₹${tx.amount.abs().toStringAsFixed(2)}',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                    color: isExpense ? AppColors.expense : AppColors.income,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String _formatDate(DateTime date) {
    return "${date.day} ${_month(date.month)}";
  }

  String _month(int m) {
    const months = [
      '',
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return months[m];
  }
}
