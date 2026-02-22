import 'package:get_it/get_it.dart';
import 'package:spend_wise/core/database/app_database_instance.dart';
import 'package:spend_wise/feature/analytics/domain/usecase/get_monthly_category_breakdown_usecase.dart';
import 'package:spend_wise/feature/analytics/domain/usecase/get_monthly_trend_usecase.dart';
import 'package:spend_wise/feature/analytics/presentation/bloc/analytics_bloc.dart';
import 'package:spend_wise/feature/expense/data/datasources/category_local_data_source.dart';
import 'package:spend_wise/feature/expense/data/datasources/transaction_local_data_source.dart';
import 'package:spend_wise/feature/expense/data/datasources/user_local_data_source.dart';
import 'package:spend_wise/feature/expense/data/repositories/category_repository_impl.dart';
import 'package:spend_wise/feature/expense/data/repositories/transaction_repository_impl.dart';
import 'package:spend_wise/feature/expense/data/repositories/user_repository_impl.dart';
import 'package:spend_wise/feature/expense/domain/repositories/category_repository.dart';
import 'package:spend_wise/feature/expense/domain/repositories/transaction_repository.dart';
import 'package:spend_wise/feature/expense/domain/repositories/user_repository.dart';
import 'package:spend_wise/feature/expense/domain/usecases/add_transaction_usecase.dart';
import 'package:spend_wise/feature/expense/domain/usecases/delete_transaction_usecase.dart';
import 'package:spend_wise/feature/expense/domain/usecases/get_categories_usecase.dart';
import 'package:spend_wise/feature/expense/domain/usecases/get_monthly_summary_usecase.dart';
import 'package:spend_wise/feature/expense/domain/usecases/get_monthly_transaction_usecase.dart';
import 'package:spend_wise/feature/expense/domain/usecases/get_user_usecase.dart';
import 'package:spend_wise/feature/expense/domain/usecases/save_user_usecase.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  // DB
  sl.registerLazySingleton(() => appDatabase);

  // DataSources
  sl.registerLazySingleton(() => UserLocalDataSource(sl()));
  sl.registerLazySingleton(() => TransactionLocalDataSource(sl()));
  sl.registerLazySingleton(() => CategoryLocalDataSource(sl()));

  // Repositories
  sl.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(sl()));
  sl.registerLazySingleton<TransactionRepository>(
    () => TransactionRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<CategoryRepository>(
    () => CategoryRepositoryImpl(sl()),
  );

  // UseCases
  sl.registerLazySingleton(() => AddTransactionUseCase(repository: sl()));
  sl.registerLazySingleton(() => DeleteTransactionUsecase(sl()));
  sl.registerLazySingleton(() => GetCategoriesUseCase(repository: sl()));
  sl.registerLazySingleton(
    () => GetMonthlyTransactionUseCase(repository: sl()),
  );
  sl.registerLazySingleton(
    () => GetMonthlyCategoryBreakdownUseCase(
      transactionRepository: sl(),
      categoryRepository: sl(),
    ),
  );

  sl.registerLazySingleton(
    () => GetMonthlyTrendUseCase(transactionRepository: sl()),
  );

  sl.registerFactory(
    () => AnalyticsBloc(
      useCase: sl<GetMonthlyCategoryBreakdownUseCase>(),
      trendUseCase: sl<GetMonthlyTrendUseCase>(),
    ),
  );
  sl.registerLazySingleton(() => GetUserUseCase(repository: sl()));
  sl.registerLazySingleton(() => SaveUserUseCase(repository: sl()));
  sl.registerLazySingleton(
    () => GetMonthlySummaryUsecase(repository: sl(), categoryRepository: sl()),
  );
}
