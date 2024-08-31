import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:personal_expense_tracker/l10n/l10n.dart';
import 'package:personal_expense_tracker/login/cubit/login_cubit.dart';
import 'package:personal_expense_tracker/repositories/authentication_repository.dart';
import 'package:personal_expense_tracker/router/app_router.gr.dart';
import 'package:personal_expense_tracker/widgets/app_textfield.dart';

@RoutePage()
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginCubit(
        authenticationRepository: context.read<AuthenticationRepository>(),
      ),
      child: const LoginView(),
    );
  }
}

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocListener<LoginCubit, LoginState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == FormzSubmissionStatus.failure &&
            state.errorMessage != null) {
          // showDialog(
          //   context: context,
          //   builder: (context) {
          //     return AlertDialog(
          //       content: Text(state.errorMessage!),
          //       actions: [
          //         TextButton(
          //           onPressed: () => Navigator.of(context).pop(),
          //           child: Text(l10n.ok),
          //         ),
          //       ],
          //     );
          //   },
          // );
        }
        if (state.status == FormzSubmissionStatus.success) {}
      },
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              Text(l10n.signIn),
              Builder(
                builder: (context) {
                  final isEmailValid = context.select<LoginCubit, bool>(
                    (cubit) => cubit.state.email.isValid,
                  );
                  return AppTextfield.email(
                    key: const Key('login_email_textfield'),
                    errorText: isEmailValid ? null : l10n.emailError,
                    onChanged: context.read<LoginCubit>().onEmailChanged,
                  );
                },
              ),
              Builder(
                builder: (context) {
                  final isPasswordValid = context.select<LoginCubit, bool>(
                    (cubit) => cubit.state.password.isValid,
                  );
                  return AppTextfield.password(
                    key: const Key('login_password_textfield'),
                    errorText: isPasswordValid ? null : l10n.passwordError,
                    onChanged: context.read<LoginCubit>().onPasswordChanged,
                  );
                },
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () => context.navigateTo(const SignUpRoute()),
                    child: Text(l10n.signup),
                  ),
                ],
              ),
              Builder(
                builder: (context) {
                  final isValid = context.select<LoginCubit, bool>(
                    (state) => state.state.isValid,
                  );
                  final isInProgress = context.select<LoginCubit, bool>(
                    (state) =>
                        state.state.status == FormzSubmissionStatus.inProgress,
                  );
                  if (isInProgress) {
                    return const CircularProgressIndicator();
                  }
                  return ElevatedButton(
                    key: const Key('login_submit_button'),
                    onPressed:
                        isValid ? context.read<LoginCubit>().onSubmit : null,
                    child: Text(l10n.signIn),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
