import 'package:spend_wise/feature/expense/data/datasources/transaction_local_data_source.dart';
import 'package:spend_wise/feature/expense/domain/entities/transaction_entity.dart';
import 'package:spend_wise/feature/expense/domain/entities/transaction_type.dart';
import 'package:spend_wise/feature/expense/domain/repositories/transaction_repository.dart';

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
      type: transaction.type,
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
            type: t.type == 'income'
                ? TransactionType.income
                : TransactionType.expense,
            dateTime: DateTime.fromMillisecondsSinceEpoch(t.timestamp),
            notes: t.notes,
          ),
        )
        .toList();
  }

  @override
  Future<void> deleteTransaction(String id) {
    return localDataSource.deleteTransaction(id);
  }
}
