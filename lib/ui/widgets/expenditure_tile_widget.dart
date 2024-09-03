import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:personal_expense_tracker/config/config.dart';
import 'package:personal_expense_tracker/extensions/extensions.dart';
import 'package:personal_expense_tracker/l10n/l10n.dart';
import 'package:personal_expense_tracker/models/category_model.dart';
import 'package:personal_expense_tracker/router/app_router.gr.dart';
import 'package:personal_expense_tracker/ui/home/cubits/'
    'expenditure_cubit/expenditure_cubit.dart';
import 'package:personal_expense_tracker/ui/home/'
    'tabs/expenditure/view/expenditure_tab.dart';
import 'package:personal_expense_tracker/utils/string_utils/string_utils.dart';

class ExpenditureCategoryTileWidget extends HookWidget {
  const ExpenditureCategoryTileWidget({
    required this.categoryModel,
    required this.generatedColor,
    super.key,
  });
  final CategoryModel categoryModel;
  final Color generatedColor;

  @override
  Widget build(BuildContext context) {
    final currentBrightness = context.currentBrightness;
    final l10n = context.l10n;
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: GestureDetector(
        onTap: () {
          context.navigateTo(
            ExpenditureItemsRoute(
              category: categoryModel,
              onDeleteExpenditure: (expenditureId) {
                return _onDeleteExpenditure(
                  context: context,
                  expenditureId: expenditureId,
                );
              },
            ),
          );
        },
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: currentBrightness == Brightness.light
                ? AppColors.kGhostWhite
                : null,
            borderRadius: BorderRadius.circular(8),
            border: Border(
              left: BorderSide(
                color: generatedColor,
                width: 3,
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
            child: Row(
              children: [
                Icon(
                  Icons.attach_money_rounded,
                  color: generatedColor,
                ),
                const Gap(10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        StringUtils.capitalizeFirstCharacter(
                          categoryModel.name,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const Gap(5),
                      Builder(
                        builder: (context) {
                          final total = categoryModel.amount.toStringAsFixed(2);
                          return Text(
                            '${l10n.total} GHS $total',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const Gap(10),
                const Icon(Icons.arrow_forward_ios_rounded),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<ExpenditureDeletionStatus> _onDeleteExpenditure({
    required BuildContext context,
    required String expenditureId,
  }) async {
    // final response = await context.showConfirmationDialog(
    //   message: context.l10n.areYouSureYouWantToDeleteExpenditure,
    // );
    // if (response == ConfirmationDialogResult.ok) {
    //   // ignore: use_build_context_synchronously
    // }
    // ignore: use_build_context_synchronously
    final deletionError =
        await context.read<ExpenditureCubit>().onDeleteExpenditure(
              id: expenditureId,
            );
    return deletionError == null
        ? ExpenditureDeletionStatus.success
        : ExpenditureDeletionStatus.failure;
  }
}
