import 'package:expense_tracker/feature/expense/domain/entities/transaction_entity.dart';
import 'package:expense_tracker/feature/expense/domain/repositories/transaction_repository.dart';

class GetMonthlyTransactionUsecase {
  final TransactionRepository repository;

  GetMonthlyTransactionUsecase({required this.repository});

  Future<List<TransactionEntity?>> call(DateTime month) {
    return repository.getTransactionsForMonth(month);
  }
}
