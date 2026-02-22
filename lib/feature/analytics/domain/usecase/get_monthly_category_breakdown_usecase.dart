import 'package:spend_wise/feature/analytics/domain/entities/category_spending.dart';
import 'package:spend_wise/feature/expense/domain/entities/transaction_type.dart';
import 'package:spend_wise/feature/expense/domain/repositories/category_repository.dart';
import 'package:spend_wise/feature/expense/domain/repositories/transaction_repository.dart';

class GetMonthlyCategoryBreakdownUseCase {
  final TransactionRepository transactionRepository;
  final CategoryRepository categoryRepository;

  GetMonthlyCategoryBreakdownUseCase({
    required this.transactionRepository,
    required this.categoryRepository,
  });

  Future<List<CategorySpending>> call(DateTime month) async {
    final transaction = await transactionRepository.getTransactionsForMonth(
      month,
    );

    final categories = await categoryRepository.getCategories();

    final expenseTransactions = transaction.where(
      (t) => t.type == TransactionType.expense,
    );

    final totalExpense = expenseTransactions.fold<double>(
      0,
      (sum, t) => sum + t.amount,
    );

    final Map<String, double> grouped = {};

    for (final tx in expenseTransactions) {
      grouped[tx.categoryId] = (grouped[tx.categoryId] ?? 0) + tx.amount;
    }

    return grouped.entries.map((entry) {
      final category = categories.firstWhere((c) => c.categoryId == entry.key);

      final double percentage = totalExpense == 0
          ? 0
          : (entry.value / totalExpense) * 100;

      return CategorySpending(
        categoryId: entry.key,
        categoryName: category.categoryName,
        totalAmount: entry.value,
        percentage: percentage,
      );
    }).toList();
  }
}
