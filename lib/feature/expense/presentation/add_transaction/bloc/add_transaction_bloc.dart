import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spend_wise/feature/expense/presentation/add_transaction/bloc/add_transaction_event.dart';
import 'package:spend_wise/feature/expense/presentation/add_transaction/bloc/add_transaction_state.dart';
import 'package:spend_wise/feature/expense/presentation/add_transaction/flow/add_transaction_step.dart';

class AddTransactionBloc
    extends Bloc<AddTransactionEvent, AddTransactionState> {
  AddTransactionBloc() : super(AddTransactionState.initial()) {
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
          category: event.category,
          step: AddTransactionStep.addDetails,
        ),
      );
    });

    on<NotesEntered>((event, emit) {
      emit(state.copyWith(notes: event.notes));
    });

    on<TransactionSubmitted>((event, emit) {
      emit(state.copyWith(step: AddTransactionStep.completed));
    });
  }
}
