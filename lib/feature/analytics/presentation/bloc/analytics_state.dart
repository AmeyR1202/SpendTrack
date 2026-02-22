import 'package:spend_wise/core/state/status.dart';
import 'package:spend_wise/feature/analytics/domain/entities/category_spending.dart';

class AnalyticsState {
  final Status status;
  final List<CategorySpending> breakdown;
  final String? errorMessage;

  AnalyticsState({
    this.status = Status.initial,
    this.breakdown = const [],
    this.errorMessage,
  });

  AnalyticsState copyWith({
    Status? status,
    List<CategorySpending>? breakdown,
    String? errorMessage,
  }) {
    return AnalyticsState(
      status: status ?? this.status,
      breakdown: breakdown ?? this.breakdown,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
