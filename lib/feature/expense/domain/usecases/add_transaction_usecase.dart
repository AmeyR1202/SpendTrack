import 'package:spend_wise/feature/expense/domain/entities/transaction_entity.dart';
import 'package:spend_wise/feature/expense/domain/entities/transaction_type.dart';
import 'package:spend_wise/feature/expense/domain/repositories/transaction_repository.dart';
import 'package:uuid/uuid.dart';

class AddTransactionParams {
  final double amount;
  final String categoryId;
  final TransactionType type;
  final String? notes;

  AddTransactionParams({
    required this.amount,
    required this.categoryId,
    required this.type,
    this.notes,
  });
}

class AddTransactionUseCase {
  final TransactionRepository repository;

  AddTransactionUseCase({required this.repository});

  Future<void> call(AddTransactionParams params) async {
    final id = const Uuid()
        .v4(); // Tomorrow when API is integrated then we'll use a different class to generate Id as BE will generate id, must not generate IDs locally.

    final transaction = TransactionEntity(
      transactionId: id,
      amount: params.amount,
      categoryId: params.categoryId,
      type: params.type,
      dateTime: DateTime.now(),
      notes: params.notes,
    );

    await repository.addTransaction(transaction);
  }
}
