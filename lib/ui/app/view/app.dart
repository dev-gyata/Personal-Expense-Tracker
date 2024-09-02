import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_expense_tracker/config/theme/app_theme.dart';
import 'package:personal_expense_tracker/global_cubits/'
    'authentication_cubit/authentication_cubit.dart';
import 'package:personal_expense_tracker/global_cubits/theme_cubit/'
    'theme_cubit.dart';
import 'package:personal_expense_tracker/l10n/l10n.dart';
import 'package:personal_expense_tracker/repositories/'
    'authentication_repository.dart';
import 'package:personal_expense_tracker/router/app_router.dart';
import 'package:personal_expense_tracker/router/app_router.gr.dart';
import 'package:personal_expense_tracker/service_locator/service_locator.dart';
import 'package:personal_expense_tracker/services/authentication_service.dart';
import 'package:personal_expense_tracker/services/token_storage_service.dart';

class App extends StatelessWidget {
  App({super.key});

  final _appRouter = sl<AppRouter>();

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => AuthenticationRepository(
            authenticationService: sl<AuthenticationService>(),
            tokenStorageService: sl<TokenStorageService>(),
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthenticationCubit(
              authenticationRepository:
                  context.read<AuthenticationRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => ThemeCubit(),
          ),
        ],
        child: BlocListener<AuthenticationCubit, AuthenticationState>(
          listenWhen: (previous, current) => previous.status != current.status,
          listener: (context, state) {
            if (state.status == AuthStatus.authenticated) {
              _appRouter.replaceAll([
                const HomeRoute(),
              ]);
            }
            if (state.status == AuthStatus.unauthenticated) {
              _appRouter.replaceAll([
                const LoginRoute(),
              ]);
            }
          },
          child: Builder(
            builder: (context) {
              return MaterialApp.router(
                routerConfig: _appRouter.config(),
                theme: AppTheme.lightTheme,
                darkTheme: AppTheme.darkTheme,
                themeMode: context.select<ThemeCubit, ThemeMode>(
                  (cubit) => cubit.state,
                ),
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                supportedLocales: AppLocalizations.supportedLocales,
              );
            },
          ),
        ),
      ),
    );
  }
}
