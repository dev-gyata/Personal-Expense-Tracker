// ignore_for_file: cascade_invocations

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:personal_expense_tracker/config/constants/colors.dart';
import 'package:personal_expense_tracker/extensions/extensions.dart';
import 'package:personal_expense_tracker/l10n/l10n.dart';
import 'package:shimmer/shimmer.dart';

class SummaryCardWidget extends StatelessWidget {
  const SummaryCardWidget({
    super.key,
    this.title = '',
    this.total = '',
    this.highestAmountText = '',
    this.highestAmountName = '',
    this.highestRevenueText = '',
  });
  final String title;
  final String total;
  final String highestAmountText;
  final String highestAmountName;
  final String? highestRevenueText;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return SizedBox(
      width: 250,
      child: CustomPaint(
        painter: const _SummaryCardPainter(
          color: AppColors.primary,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: context.mediumText?.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.kWhiteColor,
                ),
              ),
              const Gap(5),
              Text(
                '${l10n.total}: GHS $total',
                style: context.smallText?.copyWith(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Gap(5),
              Text(
                highestAmountName,
                style: context.smallText?.copyWith(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Gap(5),
              Text(
                highestAmountText,
                style: context.smallText?.copyWith(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              if (highestRevenueText != null) ...[
                const Gap(5),
                Text(
                  highestRevenueText!,
                  style: context.smallText?.copyWith(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class LoadingSummaryCard extends StatelessWidget {
  const LoadingSummaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.baseShimmerColor,
      highlightColor: AppColors.highlightShimmerColor,
      child: const SummaryCardWidget(),
    );
  }
}

class _SummaryCardPainter extends CustomPainter {
  const _SummaryCardPainter({required this.color});

  final Color color;
  @override
  void paint(Canvas canvas, Size size) {
    final paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = color.withOpacity(1);
    canvas.drawRRect(
      RRect.fromRectAndCorners(
        Rect.fromLTWH(0, 0, size.width, size.height),
        bottomRight: Radius.circular(size.width * 0.08000000),
        bottomLeft: Radius.circular(size.width * 0.08000000),
        topLeft: Radius.circular(size.width * 0.08000000),
        topRight: Radius.circular(size.width * 0.08000000),
      ),
      paint0Fill,
    );

    final path_1 = Path();
    path_1.moveTo(size.width * 0.01413956, size.height * 0.007142408);
    path_1.cubicTo(
      size.width * 0.005222680,
      size.height * 0.03195654,
      0,
      size.height * 0.06205592,
      0,
      size.height * 0.09450154,
    );
    path_1.lineTo(0, size.height * 0.8461769);
    path_1.cubicTo(
      0,
      size.height * 0.9311462,
      size.width * 0.03581720,
      size.height * 1.000023,
      size.width * 0.08000000,
      size.height * 1.000023,
    );
    path_1.lineTo(size.width * 0.9200000, size.height * 1.000023);
    path_1.cubicTo(
      size.width * 0.9641840,
      size.height * 1.000023,
      size.width,
      size.height * 0.9311462,
      size.width,
      size.height * 0.8461769,
    );
    path_1.lineTo(size.width, size.height * 0.8415615);
    path_1.lineTo(size.width * 0.01413956, size.height * 0.007142408);
    path_1.close();

    final paint1Fill = Paint()..style = PaintingStyle.fill;
    paint1Fill.color = Colors.white.withOpacity(0.1);
    canvas.drawPath(path_1, paint1Fill);

    final path_2 = Path();
    path_2.moveTo(size.width * 0.9793520, size.height * 0.9493385);
    path_2.cubicTo(
      size.width * 0.9647120,
      size.height * 0.9804692,
      size.width * 0.9435440,
      size.height * 1.000023,
      size.width * 0.9200000,
      size.height * 1.000023,
    );
    path_2.lineTo(size.width * 0.08000000, size.height * 1.000023);
    path_2.cubicTo(
      size.width * 0.03581720,
      size.height * 1.000023,
      0,
      size.height * 0.9311462,
      0,
      size.height * 0.8461769,
    );
    path_2.lineTo(0, size.height * 0.1204292);
    path_2.lineTo(size.width * 0.9793520, size.height * 0.9493385);
    path_2.close();

    final paint2Fill = Paint()..style = PaintingStyle.fill;
    paint2Fill.color = Colors.white.withOpacity(0.1);
    canvas.drawPath(path_2, paint2Fill);

    final path_3 = Path();
    path_3.moveTo(size.width * 0.8786960, size.height * 0.9999769);
    path_3.lineTo(size.width * 0.08000000, size.height * 0.9999769);
    path_3.cubicTo(
      size.width * 0.03581720,
      size.height * 0.9999769,
      0,
      size.height * 0.9311000,
      0,
      size.height * 0.8461308,
    );
    path_3.lineTo(0, size.height * 0.2562654);
    path_3.lineTo(size.width * 0.8786960, size.height * 0.9999769);
    path_3.close();

    final paint3Fill = Paint()..style = PaintingStyle.fill;
    paint3Fill.color = Colors.white.withOpacity(0.08);
    canvas.drawPath(path_3, paint3Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
