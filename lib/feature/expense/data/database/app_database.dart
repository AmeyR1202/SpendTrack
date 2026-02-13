import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:spend_wise/feature/expense/data/tables/categories_table.dart';
import 'package:spend_wise/feature/expense/data/tables/transactions_table.dart';
import 'package:spend_wise/feature/expense/data/tables/user_tables.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [Users, Categories, Transactions])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(openConnection());
  @override
  int get schemaVersion => 6;

  // User queries
  Future<User?> getUser() {
    return select(users).getSingleOrNull();
  }

  Future<void> insertUser(UsersCompanion user) {
    return into(users).insertOnConflictUpdate(user);
  }

  // categories queries

  Future<List<Category>> getCategories() {
    return select(categories).get();
  }

  Future<int> getCategoryCount() async {
    final result = await customSelect(
      'SELECT COUNT(*) AS count FROM categories',
    ).getSingle();
    return result.data['count'] as int;
  }

  Future<void> insertCategories(List<CategoriesCompanion> data) async {
    await batch((batch) {
      batch.insertAll(categories, data);
    });
  }

  // Transaction queries
  Future<void> insertTransactions(TransactionsCompanion data) {
    return into(transactions).insert(data);
  }

  Future<List<Transaction>> getTransactionForMonth(DateTime month) {
    final start = DateTime(month.year, month.month, 1).millisecondsSinceEpoch;
    final end = DateTime(month.year, month.month + 1, 1).millisecondsSinceEpoch;
    return (select(
      transactions,
    )..where((t) => t.timestamp.isBetweenValues(start, end))).get();
  }
}

LazyDatabase openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'expense_app.db'));
    return NativeDatabase(file);
  });
}
