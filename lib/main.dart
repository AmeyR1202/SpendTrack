import 'package:expense_tracker/core/router/app_router.dart';
import 'package:expense_tracker/feature/expense/domain/repositories/fake_user_repository.dart';
import 'package:expense_tracker/feature/expense/domain/usecases/get_user_usecase.dart';
import 'package:expense_tracker/feature/expense/domain/usecases/save_user_usecase.dart';
import 'package:expense_tracker/feature/expense/presentation/enter_name/bloc/enter_name_bloc.dart';
import 'package:expense_tracker/feature/expense/presentation/splash/bloc/splash_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => SplashBloc(
            getUserUseCase: GetUserUseCase(repository: FakeUserRepository()),
          ),
        ),
        BlocProvider(
          create: (_) => EnterNameBloc(
            saveUserUseCase: SaveUserUseCase(repository: FakeUserRepository()),
          ),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: appRouter,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
