import 'package:spend_wise/core/state/status.dart';
import 'package:spend_wise/feature/expense/domain/usecases/delete_transaction_usecase.dart';
import 'package:spend_wise/feature/expense/domain/usecases/get_categories_usecase.dart';
import 'package:spend_wise/feature/expense/domain/usecases/get_monthly_summary_usecase.dart';
import 'package:spend_wise/feature/expense/domain/usecases/get_monthly_transaction_usecase.dart';
import 'package:spend_wise/feature/expense/presentation/dashboard/bloc/dashboard_event.dart';
import 'package:spend_wise/feature/expense/presentation/dashboard/bloc/dashboard_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final GetMonthlySummaryUsecase getMonthlySummaryUsecase;
  final GetMonthlyTransactionUseCase getMonthlyTransactionsUseCase;
  final GetCategoriesUseCase getCategoriesUseCase;
  final DeleteTransactionUsecase deleteTransactionUseCase;

  DashboardBloc({
    required this.getMonthlySummaryUsecase,
    required this.getMonthlyTransactionsUseCase,
    required this.getCategoriesUseCase,
    required this.deleteTransactionUseCase,
  }) : super(DashboardState.initial()) {
    on<DashboardStarted>(_onDashboardStarted);
    on<TransactionDeleted>((event, emit) async {
      await deleteTransactionUseCase(event.id);
      add(DashboardStarted(DateTime.now()));
    });
  }

  Future<void> _onDashboardStarted(
    DashboardStarted event,
    Emitter<DashboardState> emit,
  ) async {
    emit(state.copyWith(status: Status.loading));

    try {
      final summary = await getMonthlySummaryUsecase(event.month);
      final transactions = await getMonthlyTransactionsUseCase(event.month);
      final categories = await getCategoriesUseCase();

      emit(
        state.copyWith(
          status: Status.success,
          summary: summary,
          transactions: transactions,
          categories: categories,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: Status.error,
          errorMessage: 'Failed to load dashboard',
        ),
      );
    }
  }
}
