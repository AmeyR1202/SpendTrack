import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spend_wise/core/theme/app_colors.dart';
import 'package:spend_wise/feature/expense/domain/entities/category_entity.dart';
import 'package:spend_wise/feature/expense/domain/entities/transaction_entity.dart';
import 'package:spend_wise/feature/expense/domain/entities/transaction_type.dart';
import 'package:spend_wise/feature/expense/presentation/dashboard/bloc/dashboard_bloc.dart';
import 'package:spend_wise/feature/expense/presentation/dashboard/bloc/dashboard_event.dart';

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

        return Dismissible(
          key: ValueKey(tx.transactionId),
          direction: DismissDirection.endToStart,
          background: Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: AppColors.expense,
            ),
            child: const Icon(Icons.delete, color: AppColors.textPrimary),
          ),
          onDismissed: (_) {
            context.read<DashboardBloc>().add(
              TransactionDeleted(tx.transactionId),
            );
          },
          child: InkWell(
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
                          tx.categoryId,
                          style: const TextStyle(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w900,
                            fontSize: 16,
                          ),
                        ),

                        const SizedBox(height: 4),
                        Text(
                          _formatDate(tx.dateTime),
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Text(
                    '${isExpense ? '-' : '+'}₹${tx.amount.abs().toStringAsFixed(2)}',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                      color: isExpense ? AppColors.expense : AppColors.income,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  String _formatDate(DateTime date) {
    final hour = date.hour > 12 ? date.hour - 12 : date.hour;
    final amPm = date.hour >= 12 ? "PM" : "AM";

    return "${date.day} ${_month(date.month)} ${date.year}, "
        "$hour:${date.minute.toString().padLeft(2, '0')} $amPm";
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
