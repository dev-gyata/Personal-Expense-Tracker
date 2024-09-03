import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:personal_expense_tracker/hooks/refresh_controller_hook.dart';
import 'package:personal_expense_tracker/l10n/l10n.dart';
import 'package:personal_expense_tracker/ui/home/cubits/expenditure_cubit/expenditure_cubit.dart';
import 'package:personal_expense_tracker/ui/home/cubits/income_cubit/income_cubit.dart';
import 'package:personal_expense_tracker/ui/home/tabs/dashboard/widgets'
    '/dashboard_charts_section_widget.dart';
import 'package:personal_expense_tracker/ui/home/tabs/dashboard'
    '/widgets/dashboard_summary_section.dart';
import 'package:personal_expense_tracker/ui/home/tabs/dashboard'
    '/widgets/revenue_history_widget.dart';
import 'package:personal_expense_tracker/ui/widgets/error_state_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

@RoutePage()
class DashboardTab extends HookWidget {
  const DashboardTab({super.key});

  @override
  Widget build(BuildContext context) {
    final refreshController = useRefreshController();
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        child: Builder(
          builder: (context) {
            final hasExpenditureFailed = context.select<ExpenditureCubit, bool>(
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
            return SmartRefresher(
              controller: refreshController,
              onRefresh: () async {
                await context.read<ExpenditureCubit>().onRefreshExpenditure();
                await context.read<IncomeCubit>().onRefreshIncome();
                refreshController.refreshCompleted();
              },
              header: const WaterDropHeader(),
              child: const SingleChildScrollView(
                primary: false,
                child: Column(
                  children: [
                    DashboardSummarySection(),
                    DashboardChartsSectionWidget(),
                    RevenueHistoryWidget(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
