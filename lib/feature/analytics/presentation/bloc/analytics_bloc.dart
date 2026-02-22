import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spend_wise/core/state/status.dart';
import 'package:spend_wise/feature/analytics/domain/usecase/get_monthly_category_breakdown_usecase.dart';
import 'package:spend_wise/feature/analytics/domain/usecase/get_monthly_trend_usecase.dart';
import 'package:spend_wise/feature/analytics/presentation/bloc/analytics_event.dart';
import 'package:spend_wise/feature/analytics/presentation/bloc/analytics_state.dart';

class AnalyticsBloc extends Bloc<AnalyticsEvent, AnalyticsState> {
  final GetMonthlyCategoryBreakdownUseCase useCase;
  final GetMonthlyTrendUseCase trendUseCase;

  AnalyticsBloc({required this.useCase, required this.trendUseCase})
    : super(AnalyticsState()) {
    on<AnalyticsRequested>((event, emit) async {
      emit(state.copyWith(status: Status.loading));
      try {
        final result = await useCase(event.month);
        emit(state.copyWith(status: Status.success, breakdown: result));
      } catch (e) {
        emit(
          state.copyWith(
            status: Status.error,
            errorMessage: 'Failed to load analytics',
          ),
        );
      }
    });
    on<TrendRequested>((event, emit) async {
      emit(state.copyWith(status: Status.loading));

      try {
        final result = await trendUseCase(event.month);

        emit(state.copyWith(status: Status.success, trend: result));
      } catch (_) {
        emit(state.copyWith(status: Status.error));
      }
    });
  }
}
