import 'package:collection/collection.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:personal_expense_tracker/extensions/build_context_extensions.dart';
import 'package:personal_expense_tracker/models/income_model.dart';
import 'package:personal_expense_tracker/ui/home/tabs/dashboard/widgets/chart_indicator.dart';
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
    return AspectRatio(
      aspectRatio: 1.3,
      child: Row(
        children: <Widget>[
          const SizedBox(
            height: 18,
          ),
          Expanded(
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
                      touchedIndex.value =
                          pieTouchResponse.touchedSection!.touchedSectionIndex;
                    },
                  ),
                  borderData: FlBorderData(
                    show: false,
                  ),
                  sectionsSpace: 0,
                  centerSpaceRadius: 40,
                  sections: showingSections(
                    context: context,
                    generatedColors: generatedColors,
                    touchedIndex: touchedIndex.value,
                  ),
                ),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
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
          const SizedBox(
            width: 28,
          ),
        ],
      ),
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
        const shadows = [Shadow(blurRadius: 2)];
        final currentIncomePercentage =
            currentIncome.calculatePercentage(allIncome: income);
        return PieChartSectionData(
          color: generatedColors[index],
          value: currentIncome.amount,
          title: '${currentIncomePercentage.toStringAsFixed(2)}%',
          radius: radius,
          titleStyle: context.mediumText?.copyWith(
            fontSize: fontSize,
            // fontWeight: fontSize,
            fontWeight: FontWeight.w600,
            shadows: shadows,
          ),
        );
      },
    ).toList();
  }
}
