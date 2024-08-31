import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:personal_expense_tracker/router/app_router.dart';
import 'package:personal_expense_tracker/services/authentication_service.dart';
import 'package:personal_expense_tracker/services/expenditure_service.dart';
import 'package:personal_expense_tracker/services/income_service.dart';

final sl = GetIt.instance;

void registerServices() {
  sl
    ..registerSingleton<AppRouter>(AppRouter())
    ..registerSingleton(
      Dio(
        BaseOptions(
          baseUrl: 'https://personal-expense-tracker.myladder.africa',
        ),
      ),
    )
    ..registerSingleton<AuthenticationService>(
      AuthenticationService(dio: sl<Dio>()),
    )
    ..registerSingleton<IncomeService>(
      IncomeService(dio: sl<Dio>()),
    )
    ..registerSingleton<ExpenditureService>(
      ExpenditureService(dio: sl<Dio>()),
    );
}
