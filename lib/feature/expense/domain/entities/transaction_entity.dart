class TransactionEntity {
  final String transactionId;
  final double amount;
  final String categoryId;
  final DateTime dateTime;
  final String? notes;

  TransactionEntity({
    required this.transactionId,
    required this.amount,
    required this.categoryId,
    required this.dateTime,
    required this.notes,
  });
}
