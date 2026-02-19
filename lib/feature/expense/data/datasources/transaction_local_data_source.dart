import 'package:drift/drift.dart';
import 'package:spend_wise/feature/expense/data/database/app_database.dart';
import 'package:spend_wise/feature/expense/domain/entities/transaction_type.dart';

class TransactionLocalDataSource {
  final AppDatabase database;

  TransactionLocalDataSource(this.database);

  Future<void> addTransaction({
    required String id,
    required double amount,
    required String categoryId,
    required TransactionType type,
    required DateTime dateTime,
    String? notes,
  }) {
    return database.insertTransactions(
      TransactionsCompanion.insert(
        id: id,
        amount: amount,
        categoryId: categoryId,
        type: type.name,
        timestamp: dateTime.millisecondsSinceEpoch,
        notes: Value(notes),
      ),
    );
  }

  Future<List<Transaction>> getTransactionsForMonth(DateTime month) async {
    final result = await database.getTransactionForMonth(month);

    return result;
  }

  Future<void> deleteTransaction(String id) {
    return (database.delete(
      database.transactions,
    )..where((t) => t.id.equals(id))).go();
  }
}
