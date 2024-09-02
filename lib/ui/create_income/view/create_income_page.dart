import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:personal_expense_tracker/extensions/extensions.dart';
import 'package:personal_expense_tracker/l10n/l10n.dart';
import 'package:personal_expense_tracker/repositories/income_repository.dart';
import 'package:personal_expense_tracker/ui/create_income/cubit/create_income_cubit.dart';
import 'package:personal_expense_tracker/ui/widgets/app_button.dart';
import 'package:personal_expense_tracker/ui/widgets/app_textfield.dart';

@RoutePage()
class CreateIncomePage extends StatelessWidget {
  const CreateIncomePage({super.key, this.onIncomeCreated});

  final VoidCallback? onIncomeCreated;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CreateIncomeCubit(
        incomeRepository: context.read<IncomeRepository>(),
      ),
      child: CreateIncomeView(onIncomeCreated: onIncomeCreated),
    );
  }
}

class CreateIncomeView extends StatelessWidget {
  const CreateIncomeView({
    super.key,
    this.onIncomeCreated,
  });
  final VoidCallback? onIncomeCreated;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocListener<CreateIncomeCubit, CreateIncomeState>(
      listenWhen: (previous, current) =>
          previous.apiStatus != current.apiStatus,
      listener: (context, state) async {
        if (state.apiStatus.isFailure) {
          return context.showErrorSnackbar(
            l10n.somethingWentWrongWhileCreatingIncome,
          );
        }
        if (state.apiStatus.isSuccess) {
          onIncomeCreated?.call();
          return context.showGeneralDialog(message: l10n.incomeCreated);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(l10n.createExpenditure),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Builder(
                builder: (context) {
                  final isNameOfRevenue =
                      context.select<CreateIncomeCubit, bool>(
                    (cubit) => cubit.state.nameOfRevenue.displayError == null,
                  );
                  return AppTextfield.text(
                    key: const Key('create_income_nameOfRevenue_textfield'),
                    errorText:
                        isNameOfRevenue ? null : l10n.nameOfRevenueOfError,
                    hintText: l10n.enterYourRevenueName,
                    label: l10n.nameOfRevenue,
                    onChanged: context
                        .read<CreateIncomeCubit>()
                        .onNameOfRevenueChanged,
                  );
                },
              ),
              const Gap(20),
              Builder(
                builder: (context) {
                  final isAmountValid = context.select<CreateIncomeCubit, bool>(
                    (cubit) => cubit.state.amount.displayError == null,
                  );
                  return AppTextfield.text(
                    key: const Key(
                      'create_income_amount_textfield',
                    ),
                    errorText: isAmountValid ? null : l10n.amountError,
                    hintText: l10n.enterYourRevenueAmount,
                    label: l10n.amount,
                    onChanged:
                        context.read<CreateIncomeCubit>().onAmountChanged,
                  );
                },
              ),
            ],
          ),
        ),
        bottomNavigationBar: Builder(
          builder: (context) {
            final isFormValid = context.select<CreateIncomeCubit, bool>(
              (cubit) => cubit.state.isFormValid,
            );
            final isFormLoading = context.select<CreateIncomeCubit, bool>(
              (cubit) => cubit.state.apiStatus.isLoading,
            );
            return AppButton(
              key: const Key('create_income_submit_button'),
              isValid: isFormValid,
              label: l10n.submit,
              isLoading: isFormLoading,
              onPressed: context.read<CreateIncomeCubit>().onSubmit,
            );
          },
        ),
      ),
    );
  }
}
