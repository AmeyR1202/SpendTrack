import 'package:spend_wise/core/database/app_database_instance.dart';
import 'package:spend_wise/feature/expense/data/datasources/category_local_data_source.dart';
import 'package:spend_wise/feature/expense/data/datasources/transaction_local_data_source.dart';
import 'package:spend_wise/feature/expense/data/repositories/category_repository_impl.dart';
import 'package:spend_wise/feature/expense/data/repositories/transaction_repository_impl.dart';
import 'package:spend_wise/feature/expense/domain/usecases/add_transaction_usecase.dart';
import 'package:spend_wise/feature/expense/domain/usecases/delete_transaction_usecase.dart';
import 'package:spend_wise/feature/expense/domain/usecases/get_categories_usecase.dart';
import 'package:spend_wise/feature/expense/domain/usecases/get_monthly_summary_usecase.dart';
import 'package:spend_wise/feature/expense/domain/usecases/get_monthly_transaction_usecase.dart';
import 'package:spend_wise/feature/expense/presentation/add_transaction/bloc/add_transaction_bloc.dart';
import 'package:spend_wise/feature/expense/presentation/add_transaction/pages/add_transaction_page.dart';
import 'package:spend_wise/feature/expense/presentation/dashboard/bloc/dashboard_bloc.dart';
import 'package:spend_wise/feature/expense/presentation/dashboard/dashboard_screen.dart';
import 'package:spend_wise/feature/expense/presentation/enter_name/enter_name_screen.dart';
import 'package:spend_wise/feature/expense/presentation/opening_balance/bloc/opening_balance_bloc.dart';
import 'package:spend_wise/feature/expense/presentation/opening_balance/pages/opening_balance_page.dart';
import 'package:spend_wise/feature/expense/presentation/splash/splash_screen.dart';
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
            getMonthlyTransactionsUseCase: GetMonthlyTransactionUseCase(
              repository: TransactionRepositoryImpl(
                TransactionLocalDataSource(appDatabase),
              ),
            ),
            getCategoriesUseCase: GetCategoriesUseCase(
              repository: CategoryRepositoryImpl(
                CategoryLocalDataSource(appDatabase),
              ),
            ),
            deleteTransactionUseCase: DeleteTransactionUsecase(
              TransactionRepositoryImpl(
                TransactionLocalDataSource(appDatabase),
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
    GoRoute(
      path: '/add-transaction',
      builder: (context, state) {
        return BlocProvider(
          create: (_) => AddTransactionBloc(
            addTransactionUseCase: AddTransactionUseCase(
              repository: TransactionRepositoryImpl(
                TransactionLocalDataSource(appDatabase),
              ),
            ),
          ),
          child: const AddTransactionPage(),
        );
      },
    ),
    GoRoute(
      path: '/opening-balance',
      builder: (context, state) {
        return BlocProvider(
          create: (_) => OpeningBalanceBloc(
            AddTransactionUseCase(
              repository: TransactionRepositoryImpl(
                TransactionLocalDataSource(appDatabase),
              ),
            ),
          ),
          child: const OpeningBalancePage(),
        );
      },
    ),

    // GoRoute(
    //   path: '/settings',
    //   builder: (context, state) => const SettingsPage(),
    // ),
  ],
);
