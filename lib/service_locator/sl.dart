import 'package:get_it/get_it.dart';
import 'package:personal_expense_tracker/router/app_router.dart';

final sl = GetIt.instance;

void registerServices() {
  sl.registerSingleton<AppRouter>(AppRouter());
}
