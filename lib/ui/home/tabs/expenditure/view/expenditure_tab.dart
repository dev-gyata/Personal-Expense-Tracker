import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_expense_tracker/extensions/build_context_extensions.dart';
import 'package:personal_expense_tracker/l10n/l10n.dart';
import 'package:personal_expense_tracker/router/app_router.gr.dart';
import 'package:personal_expense_tracker/ui/home/cubits/expenditure_cubit/expenditure_cubit.dart';
import 'package:personal_expense_tracker/ui/widgets/loading_tiles_widget.dart';
import 'package:personal_expense_tracker/utils/colors/colors_generator.dart';
import 'package:personal_expense_tracker/utils/expenditure_utils/expenditure_utils.dart';
import 'package:personal_expense_tracker/utils/string_utils/string_utils.dart';

enum ExpenditureDeletionStatus {
  success,
  failure;
}

@RoutePage()
class ExpenditureTab extends StatelessWidget {
  const ExpenditureTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const ExpenditureView();
  }
}

class ExpenditureView extends StatelessWidget {
  const ExpenditureView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
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
          return const LoadingTilesWidget();
        }
        if (apiStatus.isSuccess) {
          final expenditureCategories =
              ExpenditureUtils.foldExpendituresIntoCategories(
            expenditureState.expenditures,
          );
          final generatedColors = ColorGenerator.generateColorList(
            expenditureCategories.length,
          );
          return RefreshIndicator.adaptive(
            onRefresh: () async {
              final apiResponse =
                  await context.read<ExpenditureCubit>().onRefreshExpenditure();
              if (apiResponse != null) {
                // ignore: use_build_context_synchronously
                context.showErrorSnackbar(apiResponse);
              }
            },
            child: ListView.separated(
              itemCount: expenditureCategories.length,
              separatorBuilder: (context, index) => const Divider(
                height: 0,
              ),
              itemBuilder: (_, index) {
                final currentCategory = expenditureCategories[index];
                return ListTile(
                  onTap: () {
                    // _onDeleteExpenditure(
                    //   context: context,
                    //   expenditureId: currentExpenditure.id,
                    // );
                    context.navigateTo(
                      ExpenditureItemsRoute(
                        category: currentCategory,
                        onDeleteExpenditure: (expenditureId) {
                          return _onDeleteExpenditure(
                            context: context,
                            expenditureId: expenditureId,
                          );
                        },
                      ),
                    );
                  },
                  leading: CircleAvatar(
                    radius: 5,
                    backgroundColor: generatedColors[index],
                  ),
                  title: Text(
                    StringUtils.capitalizeFirstCharacter(
                      currentCategory.name,
                    ),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios_rounded),
                  subtitle: Builder(
                    builder: (context) {
                      final estimatedAmount =
                          currentCategory.amount.toStringAsFixed(2);
                      return Text(
                        '${l10n.total}: GHS $estimatedAmount',
                      );
                    },
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

  Future<ExpenditureDeletionStatus> _onDeleteExpenditure({
    required BuildContext context,
    required String expenditureId,
  }) async {
    // final response = await context.showConfirmationDialog(
    //   message: context.l10n.areYouSureYouWantToDeleteExpenditure,
    // );
    // if (response == ConfirmationDialogResult.ok) {
    //   // ignore: use_build_context_synchronously
    // }
    // ignore: use_build_context_synchronously
    final deletionError =
        await context.read<ExpenditureCubit>().onDeleteExpenditure(
              id: expenditureId,
            );
    return deletionError == null
        ? ExpenditureDeletionStatus.success
        : ExpenditureDeletionStatus.failure;
  }
}
