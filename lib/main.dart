import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spend_wise/core/database/app_database_instance.dart';
import 'package:spend_wise/core/router/app_router.dart';
import 'package:spend_wise/feature/expense/data/datasources/user_local_data_source.dart';
import 'package:spend_wise/feature/expense/data/repositories/user_repository_impl.dart';
import 'package:spend_wise/feature/expense/domain/usecases/get_user_usecase.dart';
import 'package:spend_wise/feature/expense/domain/usecases/save_user_usecase.dart';
import 'package:spend_wise/feature/expense/presentation/enter_name/bloc/enter_name_bloc.dart';
import 'package:spend_wise/feature/expense/presentation/splash/bloc/splash_bloc.dart';
import 'package:spend_wise/feature/expense/presentation/user/bloc/user_bloc.dart';
import 'package:spend_wise/feature/expense/presentation/user/bloc/user_event.dart';

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
        BlocProvider(
          create: (_) => UserBloc(
            getUserUseCase: GetUserUseCase(
              repository: UserRepositoryImpl(UserLocalDataSource(appDatabase)),
            ),
          )..add(LoadUser()),
        ),
      ],
      child: MaterialApp.router(
        theme: ThemeData(fontFamily: 'Inter', useMaterial3: true),
        routerConfig: appRouter,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

/*
1. Clear the multiple instances of UserRepositoryImpl(UserLocalDataSource(appDatabase)) => Clean this using Dependecy Injection Later

2. Change the font like Inter doesn't look that good

3. Add a off white or cream color theme app wide

4. Dark theme as well (v2)

5. Add couple of currencies as well
 */
