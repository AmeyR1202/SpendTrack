import 'package:expense_tracker/core/state/status.dart';
import 'package:expense_tracker/feature/expense/domain/entities/user_entity.dart';
import 'package:expense_tracker/feature/expense/domain/usecases/save_user_usecase.dart';
import 'package:expense_tracker/feature/expense/presentation/enter_name/bloc/enter_name_event.dart';
import 'package:expense_tracker/feature/expense/presentation/enter_name/bloc/enter_name_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EnterNameBloc extends Bloc<EnterNameEvent, EnterNameState> {
  final SaveUserUseCase saveUserUseCase;

  EnterNameBloc({required this.saveUserUseCase})
    : super(EnterNameState.initial()) {
    on<NameChanged>(_onNameChanged);
    on<SavePressed>(_onSavePressed);
  }

  void _onNameChanged(NameChanged event, Emitter<EnterNameState> emit) {
    emit(state.copyWith(name: event.name, errorMessage: null));
  }

  Future<void> _onSavePressed(
    SavePressed event,
    Emitter<EnterNameState> emit,
  ) async {
    if (state.name.trim().isEmpty) {
      emit(
        state.copyWith(
          status: Status.error,
          errorMessage: 'Name cannot be empty',
        ),
      );
      return;
    }
    emit(state.copyWith(status: Status.loading));

    try {
      final user = UserEntity(
        DateTime.now().millisecondsSinceEpoch.toString(),
        state.name.trim(),
      );
      await saveUserUseCase(user);
      emit(state.copyWith(status: Status.success));
    } catch (e) {
      emit(
        state.copyWith(
          status: Status.error,
          errorMessage: 'Failed to save user',
        ),
      );
    }
  }
}
