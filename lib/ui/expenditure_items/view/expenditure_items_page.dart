import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:personal_expense_tracker/config/constants/colors.dart';
import 'package:personal_expense_tracker/extensions/extensions.dart';
import 'package:personal_expense_tracker/l10n/l10n.dart';
import 'package:personal_expense_tracker/models/category_model.dart';
import 'package:personal_expense_tracker/models/expenditure_model.dart';
import 'package:personal_expense_tracker/ui/home/tabs/tabs.dart';
import 'package:personal_expense_tracker/ui/widgets/app_bar_widget.dart';
import 'package:personal_expense_tracker/ui/widgets/app_dialog.dart';
import 'package:personal_expense_tracker/utils/string_utils/string_utils.dart';

@RoutePage()
class ExpenditureItemsPage extends HookWidget {
  const ExpenditureItemsPage({
    required this.category,
    required this.onDeleteExpenditure,
    super.key,
  });
  final CategoryModel category; // ignore: unused_field
  final Future<ExpenditureDeletionStatus> Function(String expenditureId)
      onDeleteExpenditure;

  @override
  Widget build(BuildContext context) {
    final expenditures =
        useState<List<ExpenditureModel>>(category.expenditures);

    return Scaffold(
      appBar: DefaultAppBar(
        title: StringUtils.capitalizeFirstCharacter(category.name),
      ),
      body: ListView.separated(
        itemBuilder: (context, index) {
          final expenditure = expenditures.value[index];
          return _ExpenditureItem(
            index: index,
            onUpdateExpenditures: (deletedIndex) {
              _updateExpenditures(expenditures: expenditures, index: index);
            },
            expenditure: expenditure,
            onDeleteExpenditure: onDeleteExpenditure,
          );
        },
        separatorBuilder: (context, index) => const Divider(
          height: 0,
        ),
        itemCount: expenditures.value.length,
      ),
    );
  }

  void _updateExpenditures({
    required ValueNotifier<List<ExpenditureModel>> expenditures,
    required int index,
  }) {
    final updatedList = [...expenditures.value];
    updatedList.removeAt(index);
    expenditures.value = updatedList;
  }
}

class _ExpenditureItem extends HookWidget {
  const _ExpenditureItem({
    required this.onDeleteExpenditure,
    required this.expenditure,
    required this.index,
    required this.onUpdateExpenditures,
  });

  final ExpenditureModel expenditure;
  final int index;
  final Future<ExpenditureDeletionStatus> Function(String expenditureId)
      onDeleteExpenditure;

  final ValueChanged<int?> onUpdateExpenditures;

  @override
  Widget build(BuildContext context) {
    final loadingIndex = useState<bool>(false);

    return ListTile(
      trailing: loadingIndex.value
          ? const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator.adaptive(),
            )
          : IconButton(
              onPressed: () async {
                loadingIndex.value = true;
                final deletionResult = await _onDeleteExpenditure(
                  context: context,
                  expenditureId: expenditure.id,
                );
                loadingIndex.value = false;
                if (deletionResult == ExpenditureDeletionStatus.success) {
                  onUpdateExpenditures(index);
                }

                return _showSnackBar(
                  context: context,
                  deletionStatus: deletionResult,
                );
              },
              icon: const Icon(
                Icons.delete_outline_outlined,
                color: AppColors.kRedColor,
              ),
            ),
      title: Text(expenditure.nameOfItem),
      subtitle: Builder(
        builder: (context) {
          final amount = expenditure.estimatedAmount;
          final formattedAmount = amount.toStringAsFixed(2);
          return Text(
            'GHS $formattedAmount',
          );
        },
      ),
    );
  }

  Future<ExpenditureDeletionStatus?> _onDeleteExpenditure({
    required BuildContext context,
    required String expenditureId,
  }) async {
    final response = await context.showConfirmationDialog(
      message: context.l10n.areYouSureYouWantToDeleteExpenditure,
    );
    if (response == ConfirmationDialogResult.ok) {
      // ignore: use_build_context_synchronously
      final deletionStatus = await onDeleteExpenditure(expenditureId);
      return deletionStatus;
    }
    return null;
  }

  void _showSnackBar({
    required BuildContext context,
    ExpenditureDeletionStatus? deletionStatus,
  }) {
    if (deletionStatus == ExpenditureDeletionStatus.success) {
      context.showSuccessSnackbar(context.l10n.expenditureDeleted);
    }
    if (deletionStatus == ExpenditureDeletionStatus.failure) {
      context.showErrorSnackbar(
        context.l10n.somethingWentWrongWhileDeletingExpenditure,
      );
    }
  }
}
