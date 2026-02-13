import 'package:spend_wise/core/state/status.dart';
import 'package:spend_wise/feature/expense/domain/usecases/get_user_usecase.dart';
import 'package:spend_wise/feature/expense/presentation/splash/bloc/splash_event.dart';
import 'package:spend_wise/feature/expense/presentation/splash/bloc/splash_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final GetUserUseCase getUserUseCase;

  SplashBloc({required this.getUserUseCase}) : super(SplashState.initial()) {
    on<SplashStarted>(_onSplashStarted);
  }

  Future<void> _onSplashStarted(
    SplashStarted event,
    Emitter<SplashState> emit,
  ) async {
    emit(state.copyWith(status: Status.loading));

    await Future.delayed(const Duration(seconds: 2));

    try {
      final user = await getUserUseCase();

      emit(state.copyWith(status: Status.success, isUserPresent: user != null));
    } catch (e) {
      emit(
        state.copyWith(
          status: Status.error,
          errorMessage: 'Something went wrong',
        ),
      );
    }
  }
}
