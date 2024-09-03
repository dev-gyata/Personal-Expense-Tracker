import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_expense_tracker/l10n/l10n.dart';
import 'package:personal_expense_tracker/ui/home/cubits/expenditure_cubit/expenditure_cubit.dart';
import 'package:personal_expense_tracker/ui/home/cubits/income_cubit/income_cubit.dart';
import 'package:personal_expense_tracker/ui/home/tabs/dashboard/widgets'
    '/dashboard_charts_section_widget.dart';
import 'package:personal_expense_tracker/ui/home/tabs/dashboard'
    '/widgets/dashboard_summary_section.dart';
import 'package:personal_expense_tracker/ui/home/tabs/dashboard'
    '/widgets/revenue_history_widget.dart';
import 'package:personal_expense_tracker/ui/home/tabs/settings/view/settings_tab.dart';
import 'package:personal_expense_tracker/ui/widgets/error_state_widget.dart';

@RoutePage()
class DashboardTab extends StatelessWidget {
  const DashboardTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          child: Builder(
            builder: (context) {
              final hasExpenditureFailed =
                  context.select<ExpenditureCubit, bool>(
                (cubit) => cubit.state.apiStatus.isFailure,
              );
              final hasIncomeFailed = context.select<IncomeCubit, bool>(
                (cubit) => cubit.state.apiStatus.isFailure,
              );
              if (hasIncomeFailed && hasExpenditureFailed) {
                return ErrorStateWidget(
                  errorMessage: context.l10n.weUnableToConnectToOurServer,
                  onRetry: () {
                    context.read<IncomeCubit>().onLoadIncome();
                    context.read<ExpenditureCubit>().onLoadExpenditure();
                  },
                );
              }
              return const Column(
                children: [
                  DashboardSummarySection(),
                  DashboardChartsSectionWidget(),
                  RevenueHistoryWidget(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
