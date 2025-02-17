import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:personal_expense_tracker/resources/resources.dart';

class EmptyStateWidget extends StatelessWidget {
  const EmptyStateWidget(
      {required this.message, super.key, this.imageHeight, this.imageWidth,});
  final String message;
  final int? imageHeight;
  final int? imageWidth;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          Images.emptyStateImage,
          height: imageHeight?.toDouble(),
          width: imageWidth?.toDouble(),
        ),
        const Gap(10),
        ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 300,
          ),
          child: Text(
            message,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
