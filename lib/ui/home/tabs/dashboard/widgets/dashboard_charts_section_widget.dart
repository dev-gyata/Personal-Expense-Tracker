import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:personal_expense_tracker/config/constants/colors.dart';
import 'package:personal_expense_tracker/extensions/extensions.dart';
import 'package:personal_expense_tracker/l10n/l10n.dart';
import 'package:personal_expense_tracker/ui/home/cubits/'
    'expenditure_cubit/expenditure_cubit.dart';
import 'package:personal_expense_tracker/ui/home/cubits/'
    'income_cubit/income_cubit.dart';
import 'package:personal_expense_tracker/ui/home/tabs/dashboard'
    '/widgets/expenditure_chart.dart';
import 'package:personal_expense_tracker/ui/home/tabs/dashboard/widgets'
    '/income_chart.dart';
import 'package:personal_expense_tracker/ui/home/tabs/dashboard/widgets'
    '/sumary_card_widget.dart';
import 'package:personal_expense_tracker/utils'
    '/expenditure_utils/expenditure_utils.dart';

class DashboardChartsSectionWidget extends StatelessWidget {
  const DashboardChartsSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Gap(10),
        Text(
          l10n.charts,
          style: context.smallText,
        ),
        const Gap(20),
        SizedBox(
          height: 220,
          width: context.screenWidth,
          child: ListView(
            // padding: EdgeInsets.symmetric(
            //   horizontal: context.screenWidth * 0.05,
            // ),
            primary: false,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            children: [
              Builder(
                // return Sized
                builder: (context) {
                  final expenditureStatus =
                      context.select<ExpenditureCubit, ExpenditureState>(
                    (cubit) => cubit.state,
                  );
                  if (expenditureStatus.apiStatus.isLoading) {
                    return const LoadingSummaryCard();
                  }
                  // Group expenditures by category
                  final expendituresByCategory =
                      ExpenditureUtils.foldExpendituresIntoCategories(
                    expenditureStatus.expenditures,
                  );
                  if (expendituresByCategory.isEmpty) {
                    return const SizedBox.shrink();
                  }
                  return DecoratedBox(
                    decoration: BoxDecoration(
                      color: context.currentBrightness == Brightness.dark
                          ? null
                          : AppColors.kGhostWhite,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 8,
                      ),
                      child: ExpenditureChart(
                        expenditures: expendituresByCategory.toList(),
                      ),
                    ),
                  );
                },
              ),
              const Gap(20),
              Builder(
                builder: (context) {
                  final incomeState = context.select<IncomeCubit, IncomeState>(
                    (cubit) => cubit.state,
                  );
                  if (incomeState.apiStatus.isLoading) {
                    return const LoadingSummaryCard();
                  }
                  if (incomeState.apiStatus.isSuccess) {
                    return DecoratedBox(
                      decoration: BoxDecoration(
                        color: context.currentBrightness == Brightness.dark
                            ? null
                            : AppColors.kGhostWhite,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 8,
                        ),
                        child: IncomeChart(
                          income: incomeState.income,
                        ),
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
