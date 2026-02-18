import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spend_wise/core/state/status.dart';
import 'package:spend_wise/feature/expense/domain/usecases/add_transaction_usecase.dart';
import 'package:spend_wise/feature/expense/presentation/add_transaction/bloc/add_transaction_event.dart';
import 'package:spend_wise/feature/expense/presentation/add_transaction/bloc/add_transaction_state.dart';
import 'package:spend_wise/feature/expense/presentation/add_transaction/flow/add_transaction_step.dart';

class AddTransactionBloc
    extends Bloc<AddTransactionEvent, AddTransactionState> {
  final AddTransactionUseCase addTransactionUseCase;

  AddTransactionBloc({required this.addTransactionUseCase})
    : super(AddTransactionState.initial()) {
    on<FlowStarted>((event, emit) {
      emit(AddTransactionState.initial());
    });

    on<TransactionTypeSelected>((event, emit) {
      emit(
        state.copyWith(type: event.type, step: AddTransactionStep.enterAmount),
      );
    });

    on<AmountDigitPressed>((event, emit) {
      final updated = state.amount * 10 + event.digit;
      emit(state.copyWith(amount: updated));
    });

    on<AmountBackspacePressed>((event, emit) {
      final updated = state.amount ~/ 10;
      emit(state.copyWith(amount: updated));
    });

    on<AmountConfirmation>((event, emit) {
      if (state.amount == 0) return;
      emit(state.copyWith(step: AddTransactionStep.selectCategory));
    });

    on<CategorySelected>((event, emit) {
      emit(
        state.copyWith(
          categoryId: event.categoryId,
          step: AddTransactionStep.addDetails,
        ),
      );
    });

    on<NotesEntered>((event, emit) {
      emit(state.copyWith(notes: event.notes));
    });
    on<TransactionSubmitted>((event, emit) async {
      if (state.type == null || state.categoryId == null || state.amount == 0) {
        return;
      }

      emit(state.copyWith(status: Status.loading));

      final params = AddTransactionParams(
        amount: state.amount.toDouble(),
        categoryId: state.categoryId!,
        type: state.type!,
        notes: state.notes,
      );

      await addTransactionUseCase(params);

      emit(
        state.copyWith(
          status: Status.success,
          step: AddTransactionStep.completed,
        ),
      );
    });
  }
}
