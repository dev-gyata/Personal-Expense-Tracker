import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:personal_expense_tracker/config/constants/colors.dart';
import 'package:personal_expense_tracker/ui/widgets/shimmer_placeholders.dart';
import 'package:shimmer/shimmer.dart';

class LoadingTilesWidget extends StatelessWidget {
  const LoadingTilesWidget({
    super.key,
    this.count,
    this.padding,
    this.shrinkWrap,
    this.primary,
  });
  final int? count;
  final bool? shrinkWrap;
  final bool? primary;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.baseShimmerColor,
      highlightColor: AppColors.highlightShimmerColor,
      child: ListView.separated(
        shrinkWrap: shrinkWrap ?? false,
        primary: primary,
        padding: padding ?? const EdgeInsets.symmetric(vertical: 16),
        itemCount: count ?? 10,
        separatorBuilder: (context, index) => const Gap(16),
        itemBuilder: (context, index) {
          return const ContentPlaceholder(
            lineType: ContentLineType.twoLines,
          );
        },
      ),
    );
  }
}
