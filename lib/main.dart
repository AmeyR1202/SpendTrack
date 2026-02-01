import 'package:expense_tracker/core/database/app_database_instance.dart';
import 'package:expense_tracker/core/router/app_router.dart';
import 'package:expense_tracker/feature/expense/data/datasources/user_local_data_source.dart';
import 'package:expense_tracker/feature/expense/data/repositories/user_repository_impl.dart';
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
            getUserUseCase: GetUserUseCase(
              repository: UserRepositoryImpl(UserLocalDataSource(appDatabase)),
            ),
          ),
        ),
        BlocProvider(
          create: (_) => EnterNameBloc(
            saveUserUseCase: SaveUserUseCase(
              repository: UserRepositoryImpl(UserLocalDataSource(appDatabase)),
            ),
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
