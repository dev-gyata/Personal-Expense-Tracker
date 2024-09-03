import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:personal_expense_tracker/config/config.dart';
import 'package:personal_expense_tracker/extensions/extensions.dart';
import 'package:personal_expense_tracker/l10n/l10n.dart';
import 'package:personal_expense_tracker/models/models.dart';
import 'package:personal_expense_tracker/ui/home/cubits/income_cubit/income_cubit.dart';
import 'package:personal_expense_tracker/ui/widgets/app_dialog.dart';

class RevenueTileWidget extends HookWidget {
  const RevenueTileWidget({
    required this.revenue,
    super.key,
  });
  final IncomeModel revenue;

  @override
  Widget build(BuildContext context) {
    final currentBrightness = context.currentBrightness;
    final isDeleting = useState(false);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: currentBrightness == Brightness.light
            ? AppColors.kGhostWhite
            : null,
        borderRadius: BorderRadius.circular(8),
        border: Border(
          bottom: currentBrightness == Brightness.light
              ? const BorderSide(
                  color: AppColors.kGhostWhite,
                )
              : BorderSide.none,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        child: Row(
          children: [
            const Icon(
              Icons.credit_card,
            ),
            const Gap(10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    revenue.nameOfRevenue,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Gap(5),
                  Builder(
                    builder: (context) {
                      final amountOfRevenue = revenue.amount.toStringAsFixed(2);
                      return Text(
                        'GHS $amountOfRevenue',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      );
                    },
                  ),
                ],
              ),
            ),
            const Gap(10),
            Builder(
              builder: (context) {
                if (isDeleting.value) {
                  return const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator.adaptive(),
                  );
                }
                return IconButton(
                  onPressed: () async {
                    await _onDeleteRevenue(
                      context: context,
                      isDeleting: isDeleting,
                    );
                  },
                  icon: const Icon(
                    Icons.delete_outline_outlined,
                    color: AppColors.kRedColor,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onDeleteRevenue({
    required BuildContext context,
    required ValueNotifier<bool> isDeleting,
  }) async {
    final userResponse = await context.showConfirmationDialog(
      message: context.l10n.areYouSureYouWantToDeleteRevenue,
    );
    if (userResponse == ConfirmationDialogResult.cancel) return;
    isDeleting.value = true;
    final deletionResult =
        await context.read<IncomeCubit>().onDeleteExpenditure(
              id: revenue.id,
            );
    isDeleting.value = false;
    return switch (deletionResult) {
      String() => context.showErrorSnackbar(
          context.l10n.somethingWentWrongWhileDeletingIncome,
        ),
      _ => context.showSuccessSnackbar(
          context.l10n.incomeDeletedSuccessfully,
        ),
    };
  }
}
