import 'package:flutter/material.dart';
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
      itemCount: transactions.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final tx = transactions[index];

        /// Decide type
        final isExpense = tx.type == TransactionType.expense;

        /// Convert categoryId -> categoryName
        final category = categories.firstWhere(
          (c) => c.categoryId == tx.categoryId,
          orElse: () => CategoryEntity(
            categoryId: '',
            categoryName: 'Unknown',
            type: TransactionType.expense,
          ),
        );

        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.grey.shade100,
          ),
          child: Row(
            children: [
              /// ICON
              CircleAvatar(
                radius: 22,
                backgroundColor: (isExpense ? Colors.orange : Colors.green)
                    .withOpacity(0.15),
                child: Icon(
                  isExpense ? Icons.arrow_upward : Icons.arrow_downward,
                  color: isExpense ? Colors.orange : Colors.green,
                ),
              ),

              const SizedBox(width: 12),

              /// CATEGORY + DATE
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      category.categoryName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _formatDate(tx.dateTime),
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),

              /// AMOUNT
              Text(
                '${isExpense ? '-' : '+'}₹${tx.amount.abs().toStringAsFixed(2)}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isExpense ? Colors.orange : Colors.green,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  String _formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }
}
