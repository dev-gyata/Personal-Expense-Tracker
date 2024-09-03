import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:gap/gap.dart';
import 'package:personal_expense_tracker/config/config.dart';
import 'package:personal_expense_tracker/extensions/build_context_extensions.dart';
import 'package:personal_expense_tracker/l10n/l10n.dart';
import 'package:personal_expense_tracker/repositories/authentication_repository.dart';
import 'package:personal_expense_tracker/router/app_router.gr.dart';
import 'package:personal_expense_tracker/ui/login/cubit/login_cubit.dart';
import 'package:personal_expense_tracker/ui/widgets/app_button.dart';
import 'package:personal_expense_tracker/ui/widgets/app_textfield.dart';
import 'package:personal_expense_tracker/ui/widgets/unfocus_widget.dart';

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
          context.showErrorSnackbar(state.errorMessage!);
        }
        if (state.status == FormzSubmissionStatus.success) {
          context.showSuccessSnackbar(l10n.loginSuccess);
        }
      },
      child: UnfocusWidget(
        child: Scaffold(
          body: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    l10n.logInToYourAccount,
                    style: context.largeText?.copyWith(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Gap(12),
                  ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: 350,
                    ),
                    child: Text(
                      l10n.provideEmailAndPassword,
                      textAlign: TextAlign.center,
                      style: context.smallText,
                    ),
                  ),
                  const Gap(20),
                  Builder(
                    builder: (context) {
                      final isEmailValid = context.select<LoginCubit, bool>(
                        (cubit) => cubit.state.email.displayError == null,
                      );
                      return AppTextfield.email(
                        key: const Key('login_email_textfield'),
                        errorText: isEmailValid ? null : l10n.emailError,
                        onChanged: context.read<LoginCubit>().onEmailChanged,
                      );
                    },
                  ),
                  const Gap(20),
                  Builder(
                    builder: (context) {
                      final isPasswordValid = context.select<LoginCubit, bool>(
                        (cubit) => cubit.state.password.displayError == null,
                      );
                      return AppTextfield.password(
                        key: const Key('login_password_textfield'),
                        errorText: isPasswordValid ? null : l10n.passwordError,
                        onChanged: context.read<LoginCubit>().onPasswordChanged,
                      );
                    },
                  ),
                  const Gap(8),
                  Row(
                    children: [
                      Builder(
                        builder: (context) {
                          final rememberMe = context.select<LoginCubit, bool>(
                            (cubit) => cubit.state.rememberMe,
                          );
                          return Checkbox(
                            value: rememberMe,
                            onChanged: (_) {
                              context.read<LoginCubit>().onToggleRememberMe();
                            },
                          );
                        },
                      ),
                      Text(
                        l10n.rememberMe,
                        style: context.smallText,
                      ),
                    ],
                  ),
                  const Gap(20),
                  Builder(
                    builder: (context) {
                      final isValid = context.select<LoginCubit, bool>(
                        (state) => state.state.isValid,
                      );
                      final isInProgress = context.select<LoginCubit, bool>(
                        (state) =>
                            state.state.status ==
                            FormzSubmissionStatus.inProgress,
                      );
                      return SizedBox(
                        width: double.infinity,
                        child: AppButton(
                          key: const Key('login_submit_button'),
                          isLoading: isInProgress,
                          onPressed: context.read<LoginCubit>().onSubmit,
                          isValid: isValid,
                          label: l10n.signIn,
                        ),
                      );
                    },
                  ),
                  const Gap(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        l10n.dontHaveAnAccount,
                        style: context.smallText,
                      ),
                      const Gap(10),
                      GestureDetector(
                        onTap: () => context.navigateTo(const SignUpRoute()),
                        child: Text(
                          l10n.signup,
                          style: context.smallText?.copyWith(
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
