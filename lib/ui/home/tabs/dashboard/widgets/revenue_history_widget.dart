import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:personal_expense_tracker/extensions/extensions.dart';
import 'package:personal_expense_tracker/l10n/l10n.dart';
import 'package:personal_expense_tracker/ui/home/cubits'
    '/income_cubit/income_cubit.dart';
import 'package:personal_expense_tracker/ui/widgets/empty_state_widget.dart';
import 'package:personal_expense_tracker/ui/widgets/error_state_widget.dart';
import 'package:personal_expense_tracker/ui/widgets/loading_tiles_widget.dart';
import 'package:personal_expense_tracker/ui/widgets/revenue_tile_widget.dart';

class RevenueHistoryWidget extends StatelessWidget {
  const RevenueHistoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final incomeStatus = context.select<IncomeCubit, IncomeState>(
      (cubit) => cubit.state,
    );
    final l10n = context.l10n;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Gap(10),
        Text(
          l10n.revenueHistory,
          style: context.smallText,
        ),
        const Gap(20),
        Builder(
          builder: (context) {
            if (incomeStatus.apiStatus.isLoading) {
              return const LoadingTilesWidget(
                shrinkWrap: true,
                primary: false,
                padding: EdgeInsets.zero,
              );
            }
            if (incomeStatus.apiStatus.isFailure) {
              return ErrorStateWidget(
                onRetry: context.read<IncomeCubit>().onLoadIncome,
                errorMessage: l10n.unableToFetchYourRevenueHistory,
              );
            }
            if (incomeStatus.apiStatus.isSuccess) {
              if (incomeStatus.income.isEmpty) {
                return EmptyStateWidget(message: l10n.noRevenueHistory);
              }
              return ListView.separated(
                primary: false,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final currentIncome = incomeStatus.income[index];
                  return RevenueTileWidget(
                    revenue: currentIncome,
                  );
                },
                separatorBuilder: (context, i) =>
                    context.currentBrightness == Brightness.light
                        ? const Gap(5)
                        : const Divider(
                            height: 0,
                          ),
                itemCount: incomeStatus.income.length,
              );
            }
            return const SizedBox.shrink();
          },
        ),
        const Gap(60),
      ],
    );
  }
}
