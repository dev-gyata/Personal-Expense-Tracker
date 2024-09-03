import 'package:collection/collection.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:personal_expense_tracker/extensions/'
    'build_context_extensions.dart';
import 'package:personal_expense_tracker/l10n/l10n.dart';
import 'package:personal_expense_tracker/models/income_model.dart';
import 'package:personal_expense_tracker/ui/home/tabs/dashboard/'
    'widgets/chart_indicator.dart';
import 'package:personal_expense_tracker/utils/colors/colors_generator.dart';

class IncomeChart extends HookWidget {
  const IncomeChart({
    required this.income,
    super.key,
  });
  final List<IncomeModel> income;
  @override
  Widget build(BuildContext context) {
    final touchedIndex = useState(-1);
    final generatedColors = ColorGenerator.generateColorList(income.length);
    final l10n = context.l10n;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.incomeChart),
        const Gap(20),
        Row(
          children: <Widget>[
            SizedBox(
              height: 150,
              child: Center(
                child: AspectRatio(
                  aspectRatio: 1,
                  child: PieChart(
                    PieChartData(
                      pieTouchData: PieTouchData(
                        touchCallback: (FlTouchEvent event, pieTouchResponse) {
                          if (!event.isInterestedForInteractions ||
                              pieTouchResponse == null ||
                              pieTouchResponse.touchedSection == null) {
                            touchedIndex.value = -1;
                            return;
                          }
                          touchedIndex.value = pieTouchResponse
                              .touchedSection!.touchedSectionIndex;
                        },
                      ),
                      borderData: FlBorderData(
                        show: true,
                      ),
                      sectionsSpace: 0,
                      centerSpaceRadius: 30,
                      sections: showingSections(
                        context: context,
                        generatedColors: generatedColors,
                        touchedIndex: touchedIndex.value,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const Gap(10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: income
                  .mapIndexed(
                    (index, currentIncome) => ChartIndicator(
                      color: generatedColors[index],
                      text: currentIncome.nameOfRevenue,
                      isSquare: false,
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ],
    );
  }

  List<PieChartSectionData> showingSections({
    required int touchedIndex,
    required List<Color> generatedColors,
    required BuildContext context,
  }) {
    return income.mapIndexed(
      (index, currentIncome) {
        final isTouched = index == touchedIndex;
        final fontSize = isTouched ? 18.0 : 14.0;
        final radius = isTouched ? 60.0 : 50.0;
        final currentIncomePercentage =
            currentIncome.calculatePercentage(allIncome: income);
        return PieChartSectionData(
          color: generatedColors[index],
          value: currentIncome.amount,
          title: '${currentIncomePercentage.toInt()}%',
          radius: radius,
          titleStyle: context.smallText?.copyWith(
            fontSize: fontSize,
            fontWeight: isTouched ? FontWeight.w600 : FontWeight.w400,
          ),
        );
      },
    ).toList();
  }
}
