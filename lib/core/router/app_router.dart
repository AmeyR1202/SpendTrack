import 'package:spend_wise/core/di/injection.dart';
import 'package:spend_wise/feature/analytics/presentation/bloc/analytics_bloc.dart';
import 'package:spend_wise/feature/analytics/presentation/pages/analytics_page.dart';
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
  ///  add a error builder and set the go route to dashboard page instead of splash page
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const SplashScreen()),
    GoRoute(
      path: '/dashboard',
      builder: (context, state) {
        return BlocProvider(
          create: (_) => DashboardBloc(
            getMonthlySummaryUsecase: sl(),
            getMonthlyTransactionsUseCase: sl(),
            getCategoriesUseCase: sl(),
            deleteTransactionUseCase: sl(),
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
            addTransactionUseCase: sl(),
            getCategoriesUseCase: sl(),
          ),
          child: const AddTransactionPage(),
        );
      },
    ),
    GoRoute(
      path: '/opening-balance',
      builder: (context, state) {
        return BlocProvider(
          create: (_) => OpeningBalanceBloc(sl()),
          child: const OpeningBalancePage(),
        );
      },
    ),
    GoRoute(
      path: '/analytics',
      name: 'analytics',
      builder: (context, state) {
        return BlocProvider(
          create: (_) => sl<AnalyticsBloc>(),
          child: const AnalyticsPage(),
        );
      },
    ),
    // GoRoute(
    //   path: '/settings',
    //   builder: (context, state) => const SettingsPage(),
    // ),
  ],
);
