import 'package:auto_route/auto_route.dart';
import 'package:personal_expense_tracker/router/app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen|Page|Tab,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: LoginRoute.page, initial: true),
        AutoRoute(
          page: SignUpRoute.page,
        ),
        AutoRoute(
          page: CreateExpenditureRoute.page,
        ),
        AutoRoute(
          page: CreateIncomeRoute.page,
        ),
        AutoRoute(
          page: HomeRoute.page,
          children: [
            AutoRoute(page: DashboardRoute.page),
            AutoRoute(page: ExpenditureRoute.page),
            AutoRoute(page: SettingsRoute.page),
          ],
        ),
      ];
}
