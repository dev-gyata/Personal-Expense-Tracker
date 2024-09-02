import 'package:auto_route/annotations.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_expense_tracker/models/expenditure_model.dart';
import 'package:personal_expense_tracker/ui/home/cubits/expenditure_cubit/expenditure_cubit.dart';
import 'package:personal_expense_tracker/ui/home/cubits/income_cubit/income_cubit.dart';
import 'package:personal_expense_tracker/ui/home/tabs/dashboard/widgets/expenditure_chart.dart';
import 'package:personal_expense_tracker/ui/home/tabs/dashboard/widgets/income_chart.dart';

@RoutePage()
class DashboardTab extends StatelessWidget {
  const DashboardTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          _IncomeSection(),
          _ExpenditureSection(),
          _RevenueHistorySection(),
        ],
      ),
    );
  }
}

class _IncomeSection extends StatelessWidget {
  const _IncomeSection();

  @override
  Widget build(BuildContext context) {
    final incomeStatus = context.select<IncomeCubit, IncomeState>(
      (cubit) => cubit.state,
    );
    return Column(
      children: [
        IncomeChart(
          income: incomeStatus.income,
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}

class _ExpenditureSection extends StatelessWidget {
  const _ExpenditureSection();

  @override
  Widget build(BuildContext context) {
    final expenditureStatus =
        context.select<ExpenditureCubit, ExpenditureState>(
      (cubit) => cubit.state,
    );
    return Column(
      children: [
        Builder(
          builder: (context) {
            // Group expenditures by category

            final expendituresByCategoryMap =
                expenditureStatus.expenditures.groupListsBy((e) => e.category);
            final expenditureByCategory =
                expendituresByCategoryMap.entries.map((e) {
              final category = e.key;
              final expenditures = e.value;
              final totalAmountInCategory = expenditures.fold(
                0.toDouble(),
                (previousValue, element) =>
                    previousValue + element.estimatedAmount,
              );
              return ExpenditureModel(
                id: e.key,
                category: category,
                nameOfItem: category,
                estimatedAmount: totalAmountInCategory,
              );
            });
            return ExpenditureChart(
              expenditures: expenditureByCategory.toList(),
            );
          },
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}

class _RevenueHistorySection extends StatelessWidget {
  const _RevenueHistorySection();

  @override
  Widget build(BuildContext context) {
    final incomeStatus = context.select<IncomeCubit, IncomeState>(
      (cubit) => cubit.state,
    );
    return ListView.separated(
      primary: false,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final currentIncome = incomeStatus.income[index];
        return ListTile(
          title: Text(currentIncome.nameOfRevenue),
          subtitle: Text('GHS ${currentIncome.amount.toStringAsFixed(2)}'),
        );
      },
      separatorBuilder: (_, i) => const Divider(),
      itemCount: incomeStatus.income.length,
    );
  }
}
