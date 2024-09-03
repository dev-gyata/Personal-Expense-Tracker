import 'package:collection/collection.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:personal_expense_tracker/l10n/l10n.dart';
import 'package:personal_expense_tracker/models/category_model.dart';
import 'package:personal_expense_tracker/ui/home/tabs/dashboard/'
    'widgets/chart_indicator.dart';
import 'package:personal_expense_tracker/utils/colors/colors_generator.dart';

class ExpenditureChart extends HookWidget {
  const ExpenditureChart({required this.expenditures, super.key});
  final List<CategoryModel> expenditures;

  @override
  Widget build(BuildContext context) {
    final touchedIndex = useState(-1);
    final generatedColors =
        ColorGenerator.generateColorList(expenditures.length);
    final l10n = context.l10n;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.expenditureChartByCategories),
        const Gap(20),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            ),
            const Gap(10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: expenditures.mapIndexed((index, currenExpenditure) {
                return ChartIndicator(
                  color: generatedColors[index],
                  text: currenExpenditure.name,
                  isSquare: false,
                  size: touchedIndex.value == index ? 18 : 16,
                );
              }).toList(),
            ),
          ],
        ),
      ],
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
          value: currentExpenditure.amount,
          title: '${currentIncomePercentage.toInt()}%',
          radius: 80,
          showTitle: true,
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
