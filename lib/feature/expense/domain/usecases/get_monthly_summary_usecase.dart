import 'package:expense_tracker/feature/expense/domain/entities/category_type.dart';
import 'package:expense_tracker/feature/expense/domain/entities/monthly_summary_entity.dart';
import 'package:expense_tracker/feature/expense/domain/repositories/category_repository.dart';
import 'package:expense_tracker/feature/expense/domain/repositories/transaction_repository.dart';

class GetMonthlySummaryUsecase {
  final TransactionRepository repository;
  final CategoryRepository categoryRepository;

  GetMonthlySummaryUsecase({
    required this.repository,
    required this.categoryRepository,
  });

  Future<MonthlySummaryEntity> call(DateTime month) async {
    final transactions = await repository.getTransactionsForMonth(month);

    final categories = await categoryRepository.getCategories();

    final categoryTypeMap = {for (final c in categories) c.categoryId: c.type};

    double totalIncome = 0;
    double totalExpense = 0;

    for (final t in transactions) {
      final type = categoryTypeMap[t.categoryId];

      if (type == CategoryType.income) {
        totalIncome += t.amount;
      } else if (type == CategoryType.expense) {
        totalExpense += t.amount;
      }
    }

    return MonthlySummaryEntity(
      totalIncome: totalIncome,
      totalExpense: totalExpense,
    );
  }
}
