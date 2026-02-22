import 'package:spend_wise/feature/analytics/domain/entities/daily_spending.dart';
import 'package:spend_wise/feature/expense/domain/entities/transaction_type.dart';
import 'package:spend_wise/feature/expense/domain/repositories/transaction_repository.dart';

class GetMonthlyTrendUseCase {
  final TransactionRepository transactionRepository;

  GetMonthlyTrendUseCase({required this.transactionRepository});

  Future<List<DailySpending>> call(DateTime month) async {
    final transactions = await transactionRepository.getTransactionsForMonth(
      month,
    );

    final expenseTransactions = transactions.where(
      (t) => t.type == TransactionType.expense,
    );

    final Map<int, double> groupedByDay = {};

    for (final tx in expenseTransactions) {
      final day = tx.dateTime.day;

      groupedByDay[day] = (groupedByDay[day] ?? 0) + tx.amount;
    }

    final year = month.year;
    final monthNumber = month.month;

    final lastDay = DateTime(year, monthNumber + 1, 0).day;

    final List<DailySpending> result = [];

    for (int day = 1; day <= lastDay; day++) {
      result.add(
        DailySpending(
          date: DateTime(year, monthNumber, day),
          totalAmount: groupedByDay[day] ?? 0,
        ),
      );
    }

    return result;
  }
}
