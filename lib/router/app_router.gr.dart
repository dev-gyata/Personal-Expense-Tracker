// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i9;
import 'package:flutter/material.dart' as _i10;
import 'package:personal_expense_tracker/ui/create_expenditure/view/create_expenditure_page.dart'
    as _i1;
import 'package:personal_expense_tracker/ui/create_income/view/create_income_page.dart'
    as _i2;
import 'package:personal_expense_tracker/ui/home/tabs/dashboard/view/dashboard_tab.dart'
    as _i3;
import 'package:personal_expense_tracker/ui/home/tabs/expenditure/view/expenditure_tab.dart'
    as _i4;
import 'package:personal_expense_tracker/ui/home/tabs/settings/view/settings_tab.dart'
    as _i7;
import 'package:personal_expense_tracker/ui/home/view/home_page.dart' as _i5;
import 'package:personal_expense_tracker/ui/login/view/login_page.dart' as _i6;
import 'package:personal_expense_tracker/ui/sign_up/view/sign_up_page.dart'
    as _i8;

/// generated route for
/// [_i1.CreateExpenditurePage]
class CreateExpenditureRoute
    extends _i9.PageRouteInfo<CreateExpenditureRouteArgs> {
  CreateExpenditureRoute({
    _i10.VoidCallback? onExpenseCreated,
    _i10.Key? key,
    List<_i9.PageRouteInfo>? children,
  }) : super(
          CreateExpenditureRoute.name,
          args: CreateExpenditureRouteArgs(
            onExpenseCreated: onExpenseCreated,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'CreateExpenditureRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CreateExpenditureRouteArgs>(
          orElse: () => const CreateExpenditureRouteArgs());
      return _i1.CreateExpenditurePage(
        onExpenseCreated: args.onExpenseCreated,
        key: args.key,
      );
    },
  );
}

class CreateExpenditureRouteArgs {
  const CreateExpenditureRouteArgs({
    this.onExpenseCreated,
    this.key,
  });

  final _i10.VoidCallback? onExpenseCreated;

  final _i10.Key? key;

  @override
  String toString() {
    return 'CreateExpenditureRouteArgs{onExpenseCreated: $onExpenseCreated, key: $key}';
  }
}

/// generated route for
/// [_i2.CreateIncomePage]
class CreateIncomeRoute extends _i9.PageRouteInfo<CreateIncomeRouteArgs> {
  CreateIncomeRoute({
    _i10.Key? key,
    _i10.VoidCallback? onIncomeCreated,
    List<_i9.PageRouteInfo>? children,
  }) : super(
          CreateIncomeRoute.name,
          args: CreateIncomeRouteArgs(
            key: key,
            onIncomeCreated: onIncomeCreated,
          ),
          initialChildren: children,
        );

  static const String name = 'CreateIncomeRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CreateIncomeRouteArgs>(
          orElse: () => const CreateIncomeRouteArgs());
      return _i2.CreateIncomePage(
        key: args.key,
        onIncomeCreated: args.onIncomeCreated,
      );
    },
  );
}

class CreateIncomeRouteArgs {
  const CreateIncomeRouteArgs({
    this.key,
    this.onIncomeCreated,
  });

  final _i10.Key? key;

  final _i10.VoidCallback? onIncomeCreated;

  @override
  String toString() {
    return 'CreateIncomeRouteArgs{key: $key, onIncomeCreated: $onIncomeCreated}';
  }
}

/// generated route for
/// [_i3.DashboardTab]
class DashboardRoute extends _i9.PageRouteInfo<void> {
  const DashboardRoute({List<_i9.PageRouteInfo>? children})
      : super(
          DashboardRoute.name,
          initialChildren: children,
        );

  static const String name = 'DashboardRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i3.DashboardTab();
    },
  );
}

/// generated route for
/// [_i4.ExpenditureTab]
class ExpenditureRoute extends _i9.PageRouteInfo<void> {
  const ExpenditureRoute({List<_i9.PageRouteInfo>? children})
      : super(
          ExpenditureRoute.name,
          initialChildren: children,
        );

  static const String name = 'ExpenditureRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i4.ExpenditureTab();
    },
  );
}

/// generated route for
/// [_i5.HomePage]
class HomeRoute extends _i9.PageRouteInfo<HomeRouteArgs> {
  HomeRoute({
    _i10.Key? key,
    List<_i9.PageRouteInfo>? children,
  }) : super(
          HomeRoute.name,
          args: HomeRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      final args =
          data.argsAs<HomeRouteArgs>(orElse: () => const HomeRouteArgs());
      return _i5.HomePage(key: args.key);
    },
  );
}

class HomeRouteArgs {
  const HomeRouteArgs({this.key});

  final _i10.Key? key;

  @override
  String toString() {
    return 'HomeRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i6.LoginPage]
class LoginRoute extends _i9.PageRouteInfo<void> {
  const LoginRoute({List<_i9.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i6.LoginPage();
    },
  );
}

/// generated route for
/// [_i7.SettingsTab]
class SettingsRoute extends _i9.PageRouteInfo<void> {
  const SettingsRoute({List<_i9.PageRouteInfo>? children})
      : super(
          SettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingsRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i7.SettingsTab();
    },
  );
}

/// generated route for
/// [_i8.SignUpPage]
class SignUpRoute extends _i9.PageRouteInfo<void> {
  const SignUpRoute({List<_i9.PageRouteInfo>? children})
      : super(
          SignUpRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignUpRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i8.SignUpPage();
    },
  );
}
