import 'package:flutter/material.dart';
import 'package:personal_expense_tracker/config/constants/colors.dart';
import 'package:personal_expense_tracker/ui/widgets/shimmer_placeholders.dart';
import 'package:shimmer/shimmer.dart';

class BannerShimmerLoadingWidget extends StatelessWidget {
  const BannerShimmerLoadingWidget({super.key, this.height});
  final int? height;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.baseShimmerColor,
      highlightColor: AppColors.highlightShimmerColor,
      child: BannerPlaceholder(
        height: height,
      ),
    );
  }
}
