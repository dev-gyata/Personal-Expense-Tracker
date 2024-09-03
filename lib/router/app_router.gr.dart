// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i13;

import 'package:auto_route/auto_route.dart' as _i10;
import 'package:flutter/material.dart' as _i11;
import 'package:personal_expense_tracker/models/category_model.dart' as _i12;
import 'package:personal_expense_tracker/ui/create_expenditure/view/create_expenditure_page.dart'
    as _i1;
import 'package:personal_expense_tracker/ui/create_income/view/create_income_page.dart'
    as _i2;
import 'package:personal_expense_tracker/ui/expenditure_items/view/expenditure_items_page.dart'
    as _i4;
import 'package:personal_expense_tracker/ui/home/tabs/dashboard/view/dashboard_tab.dart'
    as _i3;
import 'package:personal_expense_tracker/ui/home/tabs/expenditure/view/expenditure_tab.dart'
    as _i5;
import 'package:personal_expense_tracker/ui/home/tabs/settings/view/settings_tab.dart'
    as _i8;
import 'package:personal_expense_tracker/ui/home/tabs/tabs.dart' as _i14;
import 'package:personal_expense_tracker/ui/home/view/home_page.dart' as _i6;
import 'package:personal_expense_tracker/ui/login/view/login_page.dart' as _i7;
import 'package:personal_expense_tracker/ui/sign_up/view/sign_up_page.dart'
    as _i9;

/// generated route for
/// [_i1.CreateExpenditurePage]
class CreateExpenditureRoute
    extends _i10.PageRouteInfo<CreateExpenditureRouteArgs> {
  CreateExpenditureRoute({
    _i11.VoidCallback? onExpenseCreated,
    _i11.Key? key,
    List<_i10.PageRouteInfo>? children,
  }) : super(
          CreateExpenditureRoute.name,
          args: CreateExpenditureRouteArgs(
            onExpenseCreated: onExpenseCreated,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'CreateExpenditureRoute';

  static _i10.PageInfo page = _i10.PageInfo(
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

  final _i11.VoidCallback? onExpenseCreated;

  final _i11.Key? key;

  @override
  String toString() {
    return 'CreateExpenditureRouteArgs{onExpenseCreated: $onExpenseCreated, key: $key}';
  }
}

/// generated route for
/// [_i2.CreateIncomePage]
class CreateIncomeRoute extends _i10.PageRouteInfo<CreateIncomeRouteArgs> {
  CreateIncomeRoute({
    _i11.Key? key,
    _i11.VoidCallback? onIncomeCreated,
    List<_i10.PageRouteInfo>? children,
  }) : super(
          CreateIncomeRoute.name,
          args: CreateIncomeRouteArgs(
            key: key,
            onIncomeCreated: onIncomeCreated,
          ),
          initialChildren: children,
        );

  static const String name = 'CreateIncomeRoute';

  static _i10.PageInfo page = _i10.PageInfo(
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

  final _i11.Key? key;

  final _i11.VoidCallback? onIncomeCreated;

  @override
  String toString() {
    return 'CreateIncomeRouteArgs{key: $key, onIncomeCreated: $onIncomeCreated}';
  }
}

/// generated route for
/// [_i3.DashboardTab]
class DashboardRoute extends _i10.PageRouteInfo<void> {
  const DashboardRoute({List<_i10.PageRouteInfo>? children})
      : super(
          DashboardRoute.name,
          initialChildren: children,
        );

  static const String name = 'DashboardRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return const _i3.DashboardTab();
    },
  );
}

/// generated route for
/// [_i4.ExpenditureItemsPage]
class ExpenditureItemsRoute
    extends _i10.PageRouteInfo<ExpenditureItemsRouteArgs> {
  ExpenditureItemsRoute({
    required _i12.CategoryModel category,
    required _i13.Future<_i14.ExpenditureDeletionStatus> Function(String)
        onDeleteExpenditure,
    _i11.Key? key,
    List<_i10.PageRouteInfo>? children,
  }) : super(
          ExpenditureItemsRoute.name,
          args: ExpenditureItemsRouteArgs(
            category: category,
            onDeleteExpenditure: onDeleteExpenditure,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'ExpenditureItemsRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ExpenditureItemsRouteArgs>();
      return _i4.ExpenditureItemsPage(
        category: args.category,
        onDeleteExpenditure: args.onDeleteExpenditure,
        key: args.key,
      );
    },
  );
}

class ExpenditureItemsRouteArgs {
  const ExpenditureItemsRouteArgs({
    required this.category,
    required this.onDeleteExpenditure,
    this.key,
  });

  final _i12.CategoryModel category;

  final _i13.Future<_i14.ExpenditureDeletionStatus> Function(String)
      onDeleteExpenditure;

  final _i11.Key? key;

  @override
  String toString() {
    return 'ExpenditureItemsRouteArgs{category: $category, onDeleteExpenditure: $onDeleteExpenditure, key: $key}';
  }
}

/// generated route for
/// [_i5.ExpenditureTab]
class ExpenditureRoute extends _i10.PageRouteInfo<void> {
  const ExpenditureRoute({List<_i10.PageRouteInfo>? children})
      : super(
          ExpenditureRoute.name,
          initialChildren: children,
        );

  static const String name = 'ExpenditureRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return const _i5.ExpenditureTab();
    },
  );
}

/// generated route for
/// [_i6.HomePage]
class HomeRoute extends _i10.PageRouteInfo<HomeRouteArgs> {
  HomeRoute({
    _i11.Key? key,
    List<_i10.PageRouteInfo>? children,
  }) : super(
          HomeRoute.name,
          args: HomeRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      final args =
          data.argsAs<HomeRouteArgs>(orElse: () => const HomeRouteArgs());
      return _i6.HomePage(key: args.key);
    },
  );
}

class HomeRouteArgs {
  const HomeRouteArgs({this.key});

  final _i11.Key? key;

  @override
  String toString() {
    return 'HomeRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i7.LoginPage]
class LoginRoute extends _i10.PageRouteInfo<void> {
  const LoginRoute({List<_i10.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return const _i7.LoginPage();
    },
  );
}

/// generated route for
/// [_i8.SettingsTab]
class SettingsRoute extends _i10.PageRouteInfo<void> {
  const SettingsRoute({List<_i10.PageRouteInfo>? children})
      : super(
          SettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingsRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return const _i8.SettingsTab();
    },
  );
}

/// generated route for
/// [_i9.SignUpPage]
class SignUpRoute extends _i10.PageRouteInfo<void> {
  const SignUpRoute({List<_i10.PageRouteInfo>? children})
      : super(
          SignUpRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignUpRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return const _i9.SignUpPage();
    },
  );
}
