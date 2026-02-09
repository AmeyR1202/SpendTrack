import 'package:flutter/material.dart';
import 'package:spend_wise/feature/expense/domain/entities/transaction_type.dart';

class TransactionHeader extends StatelessWidget {
  final TransactionType type;

  const TransactionHeader({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    final isExpense = type == TransactionType.expense;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: isExpense
            ? const LinearGradient(
                colors: [Colors.orange, Colors.orange],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : const LinearGradient(
                colors: [Color(0xFF6BCB77), Color(0xFF1B8E3E)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isExpense ? Icons.arrow_upward : Icons.arrow_downward,
            color: Colors.white,
          ),
          const SizedBox(width: 8),
          Text(
            isExpense ? "Expense" : "Income",
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
