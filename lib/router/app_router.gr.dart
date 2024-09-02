// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i7;
import 'package:personal_expense_tracker/ui/home/tabs/dashboard/view/dashboard_tab.dart'
    as _i1;
import 'package:personal_expense_tracker/ui/home/tabs/expenditure/view/expenditure_tab.dart'
    as _i2;
import 'package:personal_expense_tracker/ui/home/tabs/settings/view/settings_tab.dart'
    as _i5;
import 'package:personal_expense_tracker/ui/home/view/home_page.dart' as _i3;
import 'package:personal_expense_tracker/ui/login/view/login_page.dart' as _i4;
import 'package:personal_expense_tracker/ui/sign_up/view/sign_up_page.dart'
    as _i6;

/// generated route for
/// [_i1.DashboardTab]
class DashboardRoute extends _i7.PageRouteInfo<void> {
  const DashboardRoute({List<_i7.PageRouteInfo>? children})
      : super(
          DashboardRoute.name,
          initialChildren: children,
        );

  static const String name = 'DashboardRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i1.DashboardTab();
    },
  );
}

/// generated route for
/// [_i2.ExpenditureTab]
class ExpenditureRoute extends _i7.PageRouteInfo<void> {
  const ExpenditureRoute({List<_i7.PageRouteInfo>? children})
      : super(
          ExpenditureRoute.name,
          initialChildren: children,
        );

  static const String name = 'ExpenditureRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i2.ExpenditureTab();
    },
  );
}

/// generated route for
/// [_i3.HomePage]
class HomeRoute extends _i7.PageRouteInfo<void> {
  const HomeRoute({List<_i7.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i3.HomePage();
    },
  );
}

/// generated route for
/// [_i4.LoginPage]
class LoginRoute extends _i7.PageRouteInfo<void> {
  const LoginRoute({List<_i7.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i4.LoginPage();
    },
  );
}

/// generated route for
/// [_i5.SettingsTab]
class SettingsRoute extends _i7.PageRouteInfo<void> {
  const SettingsRoute({List<_i7.PageRouteInfo>? children})
      : super(
          SettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingsRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i5.SettingsTab();
    },
  );
}

/// generated route for
/// [_i6.SignUpPage]
class SignUpRoute extends _i7.PageRouteInfo<void> {
  const SignUpRoute({List<_i7.PageRouteInfo>? children})
      : super(
          SignUpRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignUpRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i6.SignUpPage();
    },
  );
}
