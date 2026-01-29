import 'package:expense_tracker/feature/expense/domain/entities/transaction_entity.dart';

abstract class TransactionRepository {
  Future<void> addTransaction(TransactionEntity transaction);
  Future<List<TransactionEntity>> getTransactionsForMonth(DateTime month);
}
