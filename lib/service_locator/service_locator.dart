import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:personal_expense_tracker/config/config.dart';
import 'package:personal_expense_tracker/router/app_router.dart';
import 'package:personal_expense_tracker/services/authentication_service.dart';
import 'package:personal_expense_tracker/services/expenditure_service.dart';
import 'package:personal_expense_tracker/services/income_service.dart';
import 'package:personal_expense_tracker/services/token_storage_service.dart';
import 'package:personal_expense_tracker/utils/dio_interceptors/authentication_interceptor.dart';

// Global service locator
final sl = GetIt.instance;

void registerServices() {
  sl
    ..registerSingleton(
      const FlutterSecureStorage(),
    )
    ..registerSingleton<TokenStorageService>(
      TokenStorageService(
        storage: sl<FlutterSecureStorage>(),
      ),
    )
    ..registerSingleton<AppRouter>(AppRouter())
    ..registerSingleton<AuthenticationInterceptor>(
      AuthenticationInterceptor(
        tokenStorageService: sl<TokenStorageService>(),
      ),
    )
    ..registerSingleton(
      Dio(
        BaseOptions(
          // ignore: avoid_redundant_argument_values
          baseUrl: AppEnv.baseUrl,
        ),
      )..interceptors.addAll([
          sl<AuthenticationInterceptor>(),
        ]),
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
