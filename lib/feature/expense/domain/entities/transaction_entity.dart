import 'package:spend_wise/feature/expense/domain/entities/transaction_type.dart';

class TransactionEntity {
  final String transactionId;
  final double amount;
  final String categoryId;
  final TransactionType type;
  final DateTime dateTime;
  final String? notes;

  TransactionEntity({
    required this.transactionId,
    required this.amount,
    required this.categoryId,
    required this.type,
    required this.dateTime,
    required this.notes,
  });
}
