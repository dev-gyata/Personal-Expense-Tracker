import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:personal_expense_tracker/extensions/extensions.dart';
import 'package:personal_expense_tracker/l10n/l10n.dart';
import 'package:personal_expense_tracker/ui/home/cubits/expenditure_cubit/expenditure_cubit.dart';
import 'package:personal_expense_tracker/ui/home/cubits/income_cubit/income_cubit.dart';
import 'package:personal_expense_tracker/ui/home/tabs/dashboard/widgets/sumary_card_widget.dart';
import 'package:personal_expense_tracker/utils/expenditure_utils/expenditure_utils.dart';
import 'package:personal_expense_tracker/utils/income_utils/income_utils.dart';

class DashboardSummarySection extends StatelessWidget {
  const DashboardSummarySection({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Gap(10),
        Text(
          l10n.summary,
          style: context.smallText,
        ),
        const Gap(20),
        SizedBox(
          height: 165,
          width: context.screenWidth,
          child: ListView(
            primary: false,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            children: [
              Builder(
                builder: (context) {
                  final incomeState = context.select<IncomeCubit, IncomeState>(
                    (cubit) => cubit.state,
                  );
                  if (incomeState.apiStatus.isLoading) {
                    return const LoadingSummaryCard();
                  }
                  if (incomeState.apiStatus.isFailure) {
                    return SizedBox.fromSize();
                  }
                  final totalIncome = IncomeUtils.calculateTotalIncome(
                    income: incomeState.income,
                  );
                  final highestIncome = IncomeUtils.getHighestIncome(
                    income: incomeState.income,
                  );
                  return SummaryCardWidget(
                    title: l10n.income,
                    total: totalIncome.toStringAsFixed(2),
                    highestAmountName: '${l10n.highestIncome}: '
                        '${highestIncome?.nameOfRevenue ?? 'N/A'}',
                    highestAmountText: '${l10n.highestIncomeAmount}: '
                        'GHS ${highestIncome?.amount ?? '0.00'}',
                  );
                },
              ),
              const Gap(20),
              Builder(
                builder: (context) {
                  final expenditureState =
                      context.select<ExpenditureCubit, ExpenditureState>(
                    (cubit) => cubit.state,
                  );
                  if (expenditureState.apiStatus.isLoading) {
                    return const LoadingSummaryCard();
                  }
                  if (expenditureState.apiStatus.isFailure) {
                    return SizedBox.fromSize();
                  }
                  final totalExpenditure =
                      ExpenditureUtils.calculateTotalIncome(
                    expenditures: expenditureState.expenditures,
                  );
                  final highestExpenditure = ExpenditureUtils.getHighest(
                    expenditures: expenditureState.expenditures,
                  );
                  final highestExpenditureCategory =
                      ExpenditureUtils.getHighestCategory(
                    expenditures: expenditureState.expenditures,
                  );
                  return SummaryCardWidget(
                    title: l10n.expenditure,
                    total: totalExpenditure.toStringAsFixed(2),
                    highestAmountName: '${l10n.highestExpenditure}: '
                        '${highestExpenditure?.nameOfItem ?? 'N/A'}',
                    highestAmountText: '${l10n.highestExpenditureAmount}: '
                        'GHS ${highestExpenditure?.estimatedAmount ?? '0.00'}',
                    highestRevenueText: '${l10n.highestExpenditureCategory}: '
                        '${highestExpenditureCategory?.name ?? 'N/A'}',
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
