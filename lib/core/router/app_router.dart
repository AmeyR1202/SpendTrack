import 'package:expense_tracker/core/database/app_database_instance.dart';
import 'package:expense_tracker/feature/expense/data/datasources/category_local_data_source.dart';
import 'package:expense_tracker/feature/expense/data/datasources/transaction_local_data_source.dart';
import 'package:expense_tracker/feature/expense/data/repositories/category_repository_impl.dart';
import 'package:expense_tracker/feature/expense/data/repositories/transaction_repository_impl.dart';
import 'package:expense_tracker/feature/expense/domain/usecases/get_monthly_summary_usecase.dart';
import 'package:expense_tracker/feature/expense/presentation/dashboard/bloc/dashboard_bloc.dart';
import 'package:expense_tracker/feature/expense/presentation/dashboard/dashboard_screen.dart';
import 'package:expense_tracker/feature/expense/presentation/enter_name/enter_name_screen.dart';
import 'package:expense_tracker/feature/expense/presentation/splash/splash_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const SplashScreen()),
    GoRoute(
      path: '/dashboard',
      builder: (context, state) {
        return BlocProvider(
          create: (_) => DashboardBloc(
            getMonthlySummaryUsecase: GetMonthlySummaryUsecase(
              repository: TransactionRepositoryImpl(
                TransactionLocalDataSource(appDatabase),
              ),
              categoryRepository: CategoryRepositoryImpl(
                CategoryLocalDataSource(appDatabase),
              ),
            ),
          ),
          child: const DashboardPage(),
        );
      },
    ),

    GoRoute(
      path: '/enter-name',
      builder: (context, state) => const EnterNameScreen(),
    ),
  ],
);
