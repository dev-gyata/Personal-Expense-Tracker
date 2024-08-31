import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:personal_expense_tracker/l10n/l10n.dart';
import 'package:personal_expense_tracker/repositories/authentication_repository.dart';
import 'package:personal_expense_tracker/router/app_router.gr.dart';
import 'package:personal_expense_tracker/sign_up/cubit/sign_up_cubit.dart';
import 'package:personal_expense_tracker/widgets/app_textfield.dart';

@RoutePage()
class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SignUpCubit(
        authenticationRepository: context.read<AuthenticationRepository>(),
      ),
      child: const SignUpView(),
    );
  }
}

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Text(l10n.signup),
            Builder(
              builder: (context) {
                final isNameValid = context.select<SignUpCubit, bool>(
                  (cubit) => cubit.state.name.isValid,
                );
                return AppTextfield.text(
                  label: l10n.name,
                  hintText: l10n.nameHint,
                  prefixIcon: const Icon(Icons.person),
                  key: const Key('signup_name_textfield'),
                  errorText: isNameValid ? null : l10n.nameInvalidError,
                  onChanged: context.read<SignUpCubit>().onNameChanged,
                );
              },
            ),
            Builder(
              builder: (context) {
                final isEmailValid = context.select<SignUpCubit, bool>(
                  (cubit) => cubit.state.email.isValid,
                );
                return AppTextfield.email(
                  key: const Key('signup_email_textfield'),
                  errorText: isEmailValid ? null : l10n.emailError,
                  onChanged: context.read<SignUpCubit>().onEmailChanged,
                );
              },
            ),
            Builder(
              builder: (context) {
                final isPasswordValid = context.select<SignUpCubit, bool>(
                  (cubit) => cubit.state.password.isValid,
                );
                return AppTextfield.password(
                  key: const Key('signup_password_textfield'),
                  errorText: isPasswordValid ? null : l10n.passwordError,
                  onChanged: context.read<SignUpCubit>().onPasswordChanged,
                );
              },
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () => context.navigateTo(const LoginRoute()),
                  child: Text(l10n.signup),
                ),
              ],
            ),
            Builder(
              builder: (context) {
                final isValid = context.select<SignUpCubit, bool>(
                  (state) => state.state.isValid,
                );
                final isInProgress = context.select<SignUpCubit, bool>(
                  (state) =>
                      state.state.status == FormzSubmissionStatus.inProgress,
                );
                if (isInProgress) {
                  return const CircularProgressIndicator();
                }
                return ElevatedButton(
                  key: const Key('signup_submit_button'),
                  onPressed:
                      isValid ? context.read<SignUpCubit>().onSubmit : null,
                  child: Text(l10n.submit),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
