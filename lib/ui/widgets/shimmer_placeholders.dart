import 'package:flutter/widgets.dart';
import 'package:personal_expense_tracker/config/constants/colors.dart';

class BannerPlaceholder extends StatelessWidget {
  const BannerPlaceholder({super.key, this.height});
  final int? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height?.toDouble() ?? 200,
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.kWhiteColor,
      ),
    );
  }
}

class TitlePlaceholder extends StatelessWidget {
  const TitlePlaceholder({
    required this.width,
    super.key,
  });
  final double width;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: width,
            height: 12,
            color: AppColors.kWhiteColor,
          ),
          const SizedBox(height: 8),
          Container(
            width: width,
            height: 12,
            color: AppColors.kWhiteColor,
          ),
        ],
      ),
    );
  }
}

enum ContentLineType {
  twoLines,
  threeLines,
}

class ContentPlaceholder extends StatelessWidget {
  const ContentPlaceholder({
    required this.lineType,
    super.key,
  });
  final ContentLineType lineType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: AppColors.kWhiteColor,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 10,
                  color: AppColors.kWhiteColor,
                  margin: const EdgeInsets.only(bottom: 8),
                ),
                if (lineType == ContentLineType.threeLines)
                  Container(
                    width: double.infinity,
                    height: 10,
                    color: AppColors.kWhiteColor,
                    margin: const EdgeInsets.only(bottom: 8),
                  ),
                Container(
                  width: 100,
                  height: 10,
                  color: AppColors.kWhiteColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
