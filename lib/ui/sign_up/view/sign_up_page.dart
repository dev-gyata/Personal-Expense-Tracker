import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:gap/gap.dart';
import 'package:personal_expense_tracker/extensions/build_context_extensions.dart';
import 'package:personal_expense_tracker/l10n/l10n.dart';
import 'package:personal_expense_tracker/repositories/authentication_repository.dart';
import 'package:personal_expense_tracker/router/app_router.gr.dart';
import 'package:personal_expense_tracker/ui/sign_up/cubit/sign_up_cubit.dart';
import 'package:personal_expense_tracker/ui/widgets/app_button.dart';
import 'package:personal_expense_tracker/ui/widgets/app_textfield.dart';

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
    return BlocListener<SignUpCubit, SignUpState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == FormzSubmissionStatus.failure &&
            state.errorMessage != null) {
          context.showErrorSnackbar(state.errorMessage!);
        }
        if (state.status == FormzSubmissionStatus.success) {
          context.showSuccessSnackbar(l10n.signupSuccess);
        }
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                l10n.createAccount.toUpperCase(),
                style: context.displayLargeText,
              ),
              const Gap(10),
              Text(l10n.fillYourInfoBelow, style: context.smallText),
              const Gap(30),
              Builder(
                builder: (context) {
                  final isNameValid = context.select<SignUpCubit, bool>(
                    (cubit) => cubit.state.name.displayError == null,
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
              const Gap(20),
              Builder(
                builder: (context) {
                  final isEmailValid = context.select<SignUpCubit, bool>(
                    (cubit) => cubit.state.email.displayError == null,
                  );
                  return AppTextfield.email(
                    key: const Key('signup_email_textfield'),
                    errorText: isEmailValid ? null : l10n.emailError,
                    onChanged: context.read<SignUpCubit>().onEmailChanged,
                  );
                },
              ),
              const Gap(20),
              Builder(
                builder: (context) {
                  final isPasswordValid = context.select<SignUpCubit, bool>(
                    (cubit) => cubit.state.password.displayError == null,
                  );
                  return AppTextfield.password(
                    key: const Key('signup_password_textfield'),
                    errorText: isPasswordValid ? null : l10n.passwordError,
                    onChanged: context.read<SignUpCubit>().onPasswordChanged,
                  );
                },
              ),
              const Gap(20),
              Builder(
                builder: (context) {
                  final isValid = context.select<SignUpCubit, bool>(
                    (state) => state.state.isValid,
                  );
                  final isInProgress = context.select<SignUpCubit, bool>(
                    (state) =>
                        state.state.status == FormzSubmissionStatus.inProgress,
                  );
                  return SizedBox(
                    width: double.infinity,
                    child: AppButton(
                      key: const Key('signup_submit_button'),
                      onPressed:
                          isValid ? context.read<SignUpCubit>().onSubmit : null,
                      label: l10n.createAccount,
                      isValid: isValid,
                      isLoading: isInProgress,
                    ),
                  );
                },
              ),
              const Gap(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    l10n.alreadyHaveAnAccount,
                    style: context.smallText,
                  ),
                  const Gap(10),
                  GestureDetector(
                    onTap: () => context.navigateTo(const LoginRoute()),
                    child: Text(
                      l10n.signIn,
                      style: context.smallText?.copyWith(
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
