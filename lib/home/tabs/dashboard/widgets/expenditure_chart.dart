import 'package:collection/collection.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:personal_expense_tracker/home/tabs/dashboard/widgets/chart_indicator.dart';
import 'package:personal_expense_tracker/models/expenditure_model.dart';
import 'package:personal_expense_tracker/utils/colors/colors_generator.dart';

class ExpenditureChart extends HookWidget {
  const ExpenditureChart({required this.expenditures, super.key});
  final List<ExpenditureModel> expenditures;

  @override
  Widget build(BuildContext context) {
    final touchedIndex = useState(-1);
    final generatedColors =
        ColorGenerator.generateColorList(expenditures.length);
    return AspectRatio(
      aspectRatio: 1.3,
      child: Column(
        children: <Widget>[
          const SizedBox(
            height: 28,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: expenditures.mapIndexed((index, currenExpenditure) {
              return ChartIndicator(
                color: generatedColors[index],
                text: currenExpenditure.category,
                isSquare: false,
                size: touchedIndex.value == index ? 18 : 16,
              );
            }).toList(),
          ),
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
                  startDegreeOffset: 180,
                  borderData: FlBorderData(
                    show: false,
                  ),
                  sectionsSpace: 1,
                  centerSpaceRadius: 0,
                  sections: showingSections(
                    generatedColors: generatedColors,
                    touchedIndex: touchedIndex.value,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections({
    required List<Color> generatedColors,
    required int touchedIndex,
  }) {
    return expenditures.mapIndexed(
      (index, currentExpenditure) {
        final isTouched = index == touchedIndex;
        final currentIncomePercentage =
            currentExpenditure.calculatePercentage(expenditures: expenditures);
        return PieChartSectionData(
          color: generatedColors[index],
          value: currentExpenditure.estimatedAmount,
          title: '${currentIncomePercentage.toStringAsFixed(2)}%',
          radius: 80,
          titlePositionPercentageOffset: 0.55,
          borderSide: isTouched
              ? BorderSide(
                  color: generatedColors[index],
                  width: 6,
                )
              : BorderSide(
                  color: generatedColors[index].withOpacity(0),
                ),
        );
      },
    ).toList();
  }
}
