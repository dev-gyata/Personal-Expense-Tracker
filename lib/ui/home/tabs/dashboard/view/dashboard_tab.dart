import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:personal_expense_tracker/ui/home/tabs/dashboard/widgets/dashboard_charts_section_widget.dart';
import 'package:personal_expense_tracker/ui/home/tabs/dashboard/widgets/dashboard_summary_section.dart';
import 'package:personal_expense_tracker/ui/home/tabs/dashboard/widgets/revenue_history_widget.dart';

@RoutePage()
class DashboardTab extends StatelessWidget {
  const DashboardTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        child: Column(
          children: [
            DashboardSummarySection(),
            DashboardChartsSectionWidget(),
            RevenueHistoryWidget(),
          ],
        ),
      ),
    );
  }
}

// class _IncomeSection extends StatelessWidget {
//   const _IncomeSection();

//   @override
//   Widget build(BuildContext context) {
//     final incomeStatus = context.select<IncomeCubit, IncomeState>(
//       (cubit) => cubit.state,
//     );
//     return Column(
//       children: [
//         IncomeChart(
//           income: incomeStatus.income,
//         ),
//         const SizedBox(
//           height: 20,
//         ),
//       ],
//     );
//   }
// }
