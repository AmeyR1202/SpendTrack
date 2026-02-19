import 'package:spend_wise/core/state/status.dart';
import 'package:spend_wise/feature/expense/domain/entities/category_entity.dart';
import 'package:spend_wise/feature/expense/domain/entities/monthly_summary_entity.dart';
import 'package:spend_wise/feature/expense/presentation/dashboard/bloc/dashboard_bloc.dart';

class DashboardState {
  final Status status;
  final MonthlySummaryEntity? summary;
  final String? errorMessage;
  final List<TransactionViewModel> transactions;
  final List<CategoryEntity> categories;
  final bool showOpeningBalance;

  const DashboardState({
    this.showOpeningBalance = true,
    required this.status,
    this.summary,
    this.errorMessage,
    this.transactions = const [],
    this.categories = const [],
  });

  factory DashboardState.initial() {
    return const DashboardState(status: Status.initial, transactions: []);
  }

  DashboardState copyWith({
    Status? status,
    MonthlySummaryEntity? summary,
    String? errorMessage,
    List<TransactionViewModel>? transactions,
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
