// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i3;
import 'package:personal_expense_tracker/login/view/login_page.dart' as _i1;
import 'package:personal_expense_tracker/sign_up/view/sign_up_page.dart' as _i2;

/// generated route for
/// [_i1.LoginPage]
class LoginRoute extends _i3.PageRouteInfo<void> {
  const LoginRoute({List<_i3.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static _i3.PageInfo page = _i3.PageInfo(
    name,
    builder: (data) {
      return const _i1.LoginPage();
    },
  );
}

/// generated route for
/// [_i2.SignUpPage]
class SignUpRoute extends _i3.PageRouteInfo<void> {
  const SignUpRoute({List<_i3.PageRouteInfo>? children})
      : super(
          SignUpRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignUpRoute';

  static _i3.PageInfo page = _i3.PageInfo(
    name,
    builder: (data) {
      return const _i2.SignUpPage();
    },
  );
}
