import 'package:expense_tracker/feature/expense/data/datasources/transaction_local_data_source.dart';
import 'package:expense_tracker/feature/expense/domain/entities/transaction_entity.dart';
import 'package:expense_tracker/feature/expense/domain/repositories/transaction_repository.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  final TransactionLocalDataSource localDataSource;

  TransactionRepositoryImpl(this.localDataSource);

  @override
  Future<void> addTransaction(TransactionEntity transaction) {
    return localDataSource.addTransaction(
      id: transaction.transactionId,
      amount: transaction.amount,
      categoryId: transaction.categoryId,
      dateTime: transaction.dateTime,
      notes: transaction.notes,
    );
  }

  @override
  Future<List<TransactionEntity>> getTransactionsForMonth(
    DateTime month,
  ) async {
    final data = await localDataSource.getTransactionsForMonth(month);

    return data
        .map(
          (t) => TransactionEntity(
            transactionId: t.id,
            amount: t.amount,
            categoryId: t.categoryId,
            dateTime: DateTime.fromMillisecondsSinceEpoch(t.timestamp),
            notes: t.notes,
          ),
        )
        .toList();
  }
}
