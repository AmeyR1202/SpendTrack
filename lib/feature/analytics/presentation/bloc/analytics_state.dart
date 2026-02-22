import 'package:spend_wise/core/state/status.dart';
import 'package:spend_wise/feature/analytics/domain/entities/category_spending.dart';
import 'package:spend_wise/feature/analytics/domain/entities/daily_spending.dart';

class AnalyticsState {
  final Status status;
  final List<CategorySpending> breakdown;
  final String? errorMessage;
  final List<DailySpending> trend;

  AnalyticsState({
    this.status = Status.initial,
    this.breakdown = const [],
    this.errorMessage,
    this.trend = const [],
  });

  AnalyticsState copyWith({
    Status? status,
    List<CategorySpending>? breakdown,
    String? errorMessage,
    List<DailySpending>? trend,
  }) {
    return AnalyticsState(
      status: status ?? this.status,
      breakdown: breakdown ?? this.breakdown,
      errorMessage: errorMessage ?? this.errorMessage,
      trend: trend ?? this.trend,
    );
  }
}
