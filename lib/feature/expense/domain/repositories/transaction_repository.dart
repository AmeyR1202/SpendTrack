import 'package:spend_wise/feature/expense/domain/entities/transaction_entity.dart';

abstract class TransactionRepository {
  Future<void> addTransaction(TransactionEntity transaction);
  Future<List<TransactionEntity>> getTransactionsForMonth(DateTime month);
  Future<void> deleteTransaction(String id);
}
