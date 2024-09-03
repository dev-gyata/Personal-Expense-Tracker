import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:personal_expense_tracker/extensions/extensions.dart';
import 'package:personal_expense_tracker/l10n/l10n.dart';
import 'package:personal_expense_tracker/repositories/'
    'expenditure_repository.dart';
import 'package:personal_expense_tracker/ui/create_expenditure/'
    'cubit/create_expenditure_cubit.dart';
import 'package:personal_expense_tracker/ui/widgets/app_bar_widget.dart';
import 'package:personal_expense_tracker/ui/widgets/app_button.dart';
import 'package:personal_expense_tracker/ui/widgets/app_textfield.dart';
import 'package:personal_expense_tracker/ui/widgets/unfocus_widget.dart';

@RoutePage()
class CreateExpenditurePage extends StatelessWidget {
  const CreateExpenditurePage({this.onExpenseCreated, super.key});
  final VoidCallback? onExpenseCreated;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CreateExpenditureCubit(
        expenditureRepository: context.read<ExpenditureRepository>(),
      ),
      child: CreateExpenditureView(
        onExpenseCreated: onExpenseCreated,
      ),
    );
  }
}

class CreateExpenditureView extends StatelessWidget {
  const CreateExpenditureView({
    this.onExpenseCreated,
    super.key,
  });
  final VoidCallback? onExpenseCreated;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocListener<CreateExpenditureCubit, CreateExpenditureState>(
      listenWhen: (previous, current) =>
          previous.apiStatus != current.apiStatus,
      listener: (context, state) async {
        if (state.apiStatus.isFailure) {
          return context.showErrorSnackbar(
            l10n.somethingWentWrongWhileCreatingExpenditure,
          );
        }
        if (state.apiStatus.isSuccess) {
          log('message');
          onExpenseCreated?.call();
          log('message $onExpenseCreated');
          await context.showGeneralDialog(message: l10n.expenditureCreated);
          return context.back();
        }
      },
      child: UnfocusWidget(
        child: Scaffold(
          appBar: DefaultAppBar(
            title: l10n.newExpenditure,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              child: Column(
                children: [
                  Builder(
                    builder: (context) {
                      final isCategoryValid =
                          context.select<CreateExpenditureCubit, bool>(
                        (cubit) => cubit.state.category.displayError == null,
                      );
                      return AppTextfield.text(
                        key: const Key('create_expenditure_category_textfield'),
                        errorText: isCategoryValid ? null : l10n.categoryError,
                        hintText: l10n.enterExpenditureCategory,
                        label: l10n.expenditureCategory,
                        onChanged: context
                            .read<CreateExpenditureCubit>()
                            .onCategoryChanged,
                      );
                    },
                  ),
                  const Gap(20),
                  Builder(
                    builder: (context) {
                      final isNameOfItemValid =
                          context.select<CreateExpenditureCubit, bool>(
                        (cubit) => cubit.state.nameOfItem.displayError == null,
                      );
                      return AppTextfield.text(
                        key: const Key(
                          'create_expenditure_nameOfItem_textfield',
                        ),
                        errorText:
                            isNameOfItemValid ? null : l10n.itemNameError,
                        hintText: l10n.enterItemName,
                        label: l10n.itemName,
                        onChanged: context
                            .read<CreateExpenditureCubit>()
                            .onNameOfItemChanged,
                      );
                    },
                  ),
                  const Gap(20),
                  Builder(
                    builder: (context) {
                      final isEstimatedAmountValid =
                          context.select<CreateExpenditureCubit, bool>(
                        (cubit) =>
                            cubit.state.estimatedAmount.displayError == null,
                      );
                      return AppTextfield.amount(
                        key: const Key(
                          'create_expenditure_estimated_amount_textfield',
                        ),
                        errorText:
                            isEstimatedAmountValid ? null : l10n.amountError,
                        hintText: l10n.enterYourEstimatedAmount,
                        label: l10n.estimatedAmount,
                        onChanged: context
                            .read<CreateExpenditureCubit>()
                            .onEstimatedAmountChanged,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: Builder(
            builder: (context) {
              final isFormValid = context.select<CreateExpenditureCubit, bool>(
                (cubit) => cubit.state.isFormValid,
              );
              final isFormLoading =
                  context.select<CreateExpenditureCubit, bool>(
                (cubit) => cubit.state.apiStatus.isLoading,
              );
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: AppButton(
                  key: const Key('create_expenditure_submit_button'),
                  isValid: isFormValid,
                  label: l10n.submit,
                  isLoading: isFormLoading,
                  onPressed: context.read<CreateExpenditureCubit>().onSubmit,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
