import 'package:expense_tracker/feature/expense/domain/entities/transaction_entity.dart';
import 'package:expense_tracker/feature/expense/domain/repositories/transaction_repository.dart';

class AddTransactionUsecase {
  final TransactionRepository repository;

  AddTransactionUsecase({required this.repository});

  Future<void> call(TransactionEntity transaction) {
    return repository.addTransaction(transaction);
  }
}
