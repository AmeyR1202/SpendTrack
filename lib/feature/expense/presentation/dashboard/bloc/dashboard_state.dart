import 'package:spend_wise/core/state/status.dart';
import 'package:spend_wise/feature/expense/domain/entities/category_entity.dart';
import 'package:spend_wise/feature/expense/domain/entities/monthly_summary_entity.dart';
import 'package:spend_wise/feature/expense/domain/entities/transaction_entity.dart';

class DashboardState {
  final Status status;
  final MonthlySummaryEntity? summary;
  final String? errorMessage;
  final List<TransactionEntity> transactions;
  final List<CategoryEntity> categories;

  const DashboardState({
    required this.status,
    this.summary,
    this.errorMessage,
    this.transactions = const [],
    this.categories = const [],
  });

  factory DashboardState.initial() {
    return DashboardState(status: Status.initial, transactions: []);
  }

  DashboardState copyWith({
    Status? status,
    MonthlySummaryEntity? summary,
    String? errorMessage,
    List<TransactionEntity>? transactions,
    List<CategoryEntity>? categories,
  }) {
    return DashboardState(
      status: status ?? this.status,
      summary: summary ?? this.summary,
      errorMessage: errorMessage ?? this.errorMessage,
      transactions: transactions ?? this.transactions,
      categories: categories ?? this.categories,
    );
  }
}
