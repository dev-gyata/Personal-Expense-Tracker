import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:personal_expense_tracker/extensions/'
    'build_context_extensions.dart';
import 'package:personal_expense_tracker/hooks/refresh_controller_hook.dart';
import 'package:personal_expense_tracker/l10n/l10n.dart';
import 'package:personal_expense_tracker/ui/home/cubits/'
    'expenditure_cubit/expenditure_cubit.dart';
import 'package:personal_expense_tracker/ui/widgets/empty_state_widget.dart';
import 'package:personal_expense_tracker/ui/widgets/error_state_widget.dart';
import 'package:personal_expense_tracker/ui/widgets/'
    'expenditure_tile_widget.dart';
import 'package:personal_expense_tracker/ui/widgets/loading_tiles_widget.dart';
import 'package:personal_expense_tracker/utils/colors/colors_generator.dart';
import 'package:personal_expense_tracker/utils/'
    'expenditure_utils/expenditure_utils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

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

class ExpenditureView extends HookWidget {
  const ExpenditureView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final refreshController = useRefreshController();
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
        if (apiStatus.isFailure) {
          return ErrorStateWidget(
            errorMessage: expenditureState.errorMessage ??
                l10n.unableToFetchYourExpenditure,
            onRetry: context.read<ExpenditureCubit>().onLoadExpenditure,
          );
        }
        if (apiStatus.isSuccess) {
          if (expenditureState.expenditures.isEmpty) {
            return SmartRefresher(
              controller: refreshController,
              header: const WaterDropHeader(),
              onRefresh: () async {
                await context.read<ExpenditureCubit>().onRefreshExpenditure();
                refreshController.refreshCompleted();
              },
              child: Center(
                child: SingleChildScrollView(
                  child: EmptyStateWidget(
                    message: l10n.noExpenditure,
                  ),
                ),
              ),
            );
          }
          final expenditureCategories =
              ExpenditureUtils.foldExpendituresIntoCategories(
            expenditureState.expenditures,
          );
          final generatedColors = ColorGenerator.generateColorList(
            expenditureCategories.length,
          );
          return SmartRefresher(
            controller: refreshController,
            header: const WaterDropHeader(),
            onRefresh: () async {
              final apiResponse =
                  await context.read<ExpenditureCubit>().onRefreshExpenditure();
              refreshController.refreshCompleted();
              if (apiResponse != null) {
                refreshController.refreshFailed();
                // ignore: use_build_context_synchronously
                context.showErrorSnackbar(apiResponse);
              }
            },
            child: ListView.separated(
              padding: const EdgeInsets.only(top: 10),
              itemCount: expenditureCategories.length,
              separatorBuilder: (context, index) => const Gap(20),
              itemBuilder: (_, index) {
                final currentCategory = expenditureCategories[index];
                return ExpenditureCategoryTileWidget(
                  categoryModel: currentCategory,
                  generatedColor: generatedColors[index],
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
}
