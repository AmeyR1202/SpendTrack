import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spend_wise/core/state/status.dart';
import 'package:spend_wise/feature/expense/domain/entities/transaction_type.dart';
import 'package:spend_wise/feature/expense/domain/usecases/add_transaction_usecase.dart';
import 'package:spend_wise/feature/expense/presentation/opening_balance/bloc/opening_balance_event.dart';
import 'package:spend_wise/feature/expense/presentation/opening_balance/bloc/opening_balance_state.dart';

class OpeningBalanceBloc
    extends Bloc<OpeningBalanceEvent, OpeningBalanceState> {
  final AddTransactionUseCase usecase;

  OpeningBalanceBloc(this.usecase) : super(const OpeningBalanceState()) {
    on<DigitPressed>((event, emit) {
      final updated = state.amount * 10 + event.digit;
      emit(state.copyWith(amount: updated));
    });

    on<BackspacePressed>((event, emit) {
      emit(state.copyWith(amount: state.amount ~/ 10));
    });

    on<Submitted>((event, emit) async {
      if (state.amount == 0) return;

      emit(state.copyWith(status: Status.loading));

      final params = AddTransactionParams(
        amount: state.amount.toDouble(),
        categoryId: 'opening',
        type: TransactionType.income,
        notes: 'Opening Balance',
      );

      await usecase(params);

      emit(state.copyWith(status: Status.success));
    });
  }
}
