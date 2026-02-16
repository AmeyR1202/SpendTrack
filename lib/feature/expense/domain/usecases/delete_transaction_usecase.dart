import 'package:spend_wise/feature/expense/domain/repositories/transaction_repository.dart';

class DeleteTransactionUsecase {
  final TransactionRepository repository;

  DeleteTransactionUsecase(this.repository);

  Future<void> call(String id) {
    return repository.deleteTransaction(id);
  }
}
