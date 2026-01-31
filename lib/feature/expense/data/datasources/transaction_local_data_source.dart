import 'package:drift/drift.dart';
import 'package:expense_tracker/feature/expense/data/database/app_database.dart';

class TransactionLocalDataSource {
  final AppDatabase database;

  TransactionLocalDataSource(this.database);

  Future<void> addTransaction({
    required String id,
    required double amount,
    required String categoryId,
    required DateTime dateTime,
    String? notes,
  }) {
    return database.insertTransactions(
      TransactionsCompanion.insert(
        id: id,
        amount: amount,
        categoryId: categoryId,
        timestamp: dateTime.millisecondsSinceEpoch,
        notes: Value(notes),
      ),
    );
  }

  Future<List<Transaction>> getTransactionsForMonth(DateTime month) {
    return database.getTransactionForMonth(month);
  }
}
