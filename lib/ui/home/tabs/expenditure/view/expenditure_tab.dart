import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_expense_tracker/extensions/build_context_extensions.dart';
import 'package:personal_expense_tracker/l10n/l10n.dart';
import 'package:personal_expense_tracker/ui/home/cubits/expenditure_cubit/expenditure_cubit.dart';
import 'package:personal_expense_tracker/ui/widgets/app_dialog.dart';

@RoutePage()
class ExpenditureTab extends StatelessWidget {
  const ExpenditureTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ExpenditureCubit, ExpenditureState>(
      listenWhen: (previous, current) =>
          previous.expenditureDeletionStatus !=
          current.expenditureDeletionStatus,
      listener: (context, state) {
        if (state.expenditureDeletionStatus.isSuccess) {
          context.showSuccessSnackbar(context.l10n.expenditureDeleted);
        }
        if (state.expenditureDeletionStatus.isFailure) {
          context.showErrorSnackbar(
            context.l10n.somethingWentWrongWhileDeletingExpenditure,
          );
        }
      },
      child: const ExpenditureView(),
    );
  }
}

class ExpenditureView extends StatelessWidget {
  const ExpenditureView({super.key});

  @override
  Widget build(BuildContext context) {
    final expenditureState = context.select<ExpenditureCubit, ExpenditureState>(
      (cubit) => cubit.state,
    );
    final apiStatus = expenditureState.apiStatus;
    return BlocBuilder<ExpenditureCubit, ExpenditureState>(
      buildWhen: (previous, current) =>
          previous.apiStatus != current.apiStatus ||
          previous.expenditures != current.expenditures,
      builder: (context, status) {
        if (apiStatus.isLoading) {
          return const Center(child: CircularProgressIndicator.adaptive());
        }
        if (apiStatus.isSuccess) {
          return RefreshIndicator.adaptive(
            onRefresh: () async {
              final apiResponse =
                  await context.read<ExpenditureCubit>().onRefreshExpenditure();
              if (apiResponse != null) {
                // ignore: use_build_context_synchronously
                context.showErrorSnackbar(apiResponse);
              }
            },
            child: ListView.builder(
              itemCount: expenditureState.expenditures.length,
              itemBuilder: (_, index) {
                final currentExpenditure = expenditureState.expenditures[index];
                return Dismissible(
                  // background: ,
                  onDismissed: (direction) {},
                  key: Key(currentExpenditure.id),
                  child: ListTile(
                    onTap: () {
                      _onDeleteExpenditure(
                        context: context,
                        expenditureId: currentExpenditure.id,
                      );
                    },
                    title: Text(currentExpenditure.nameOfItem),
                    subtitle: Text(
                      currentExpenditure.category,
                    ),
                    trailing: Builder(
                      builder: (context) {
                        final estimatedAmount = currentExpenditure
                            .estimatedAmount
                            .toStringAsFixed(2);
                        return Text(
                          'GHS $estimatedAmount',
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          );
        }
        if (apiStatus.isFailure) {
          return Text(expenditureState.errorMessage ?? '');
        }
        return const SizedBox.shrink();
      },
    );
  }

  Future<void> _onDeleteExpenditure({
    required BuildContext context,
    required String expenditureId,
  }) async {
    final response = await context.showConfirmationDialog(
      message: context.l10n.areYouSureYouWantToDeleteExpenditure,
    );
    if (response == ConfirmationDialogResult.ok) {
      // ignore: use_build_context_synchronously
      return context.read<ExpenditureCubit>().onDeleteExpenditure(
            id: expenditureId,
          );
    }
  }
}
