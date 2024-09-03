import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:personal_expense_tracker/config/config.dart';
import 'package:personal_expense_tracker/extensions/extensions.dart';
import 'package:personal_expense_tracker/l10n/l10n.dart';

enum AppTextfieldType {
  email,
  password,
  amount,
  text;

  TextInputType get getTextInputType {
    return switch (this) {
      AppTextfieldType.email => TextInputType.emailAddress,
      AppTextfieldType.password => TextInputType.visiblePassword,
      AppTextfieldType.amount => const TextInputType.numberWithOptions(
          decimal: true,
        ),
      _ => TextInputType.text,
    };
  }

  String? getLabelText(BuildContext context) {
    return switch (this) {
      AppTextfieldType.email => context.l10n.email,
      AppTextfieldType.password => context.l10n.password,
      _ => null,
    };
  }

  String? getHintText(BuildContext context) {
    return switch (this) {
      AppTextfieldType.email => context.l10n.enterYourEmail,
      AppTextfieldType.password => context.l10n.min8Chars,
      _ => null,
    };
  }
}

class AppTextfield extends HookWidget {
  const AppTextfield({
    required this.type,
    super.key,
    this.hintText,
    this.label,
    this.onChanged,
    this.errorText,
    this.prefixIcon,
  });
  const AppTextfield.password({
    super.key,
    this.onChanged,
    this.hintText,
    this.label,
    this.errorText,
    this.prefixIcon,
  }) : type = AppTextfieldType.password;
  const AppTextfield.amount({
    super.key,
    this.onChanged,
    this.hintText,
    this.label,
    this.errorText,
    this.prefixIcon,
  }) : type = AppTextfieldType.amount;
  const AppTextfield.text({
    super.key,
    this.onChanged,
    this.hintText,
    this.label,
    this.errorText,
    this.prefixIcon,
  }) : type = AppTextfieldType.text;
  const AppTextfield.email({
    super.key,
    this.onChanged,
    this.hintText,
    this.label,
    this.errorText,
    this.prefixIcon,
  }) : type = AppTextfieldType.email;
  final AppTextfieldType type;
  final String? label;
  final ValueChanged<String>? onChanged;
  final String? hintText;
  final String? errorText;
  final Widget? prefixIcon;

  @override
  Widget build(BuildContext context) {
    final obscureText = useState(type == AppTextfieldType.password);
    final labelToShow = label ?? type.getLabelText(context);
    final currentBrightness = context.currentBrightness;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelToShow != null) ...[
          Row(
            children: [
              Text(labelToShow),
              Text(
                '*',
                style: context.smallText?.copyWith(
                  color: AppColors.kRedColor,
                ),
              ),
            ],
          ),
          const Gap(10),
        ],
        DecoratedBox(
          decoration: BoxDecoration(
            // color: AppColors.kGreyColor,
            color: currentBrightness == Brightness.light
                ? AppColors.kGhostWhite
                : null,
            boxShadow: const [
              BoxShadow(
                offset: Offset(0, 1),
                blurRadius: 2,
                color: AppColors.kShadowColor,
                // blurStyle: BlurStyle.solid,
              ),
            ],
            border: Border.all(
              color: AppColors.kWhiteColor,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextField(
            onChanged: onChanged,
            keyboardType: type.getTextInputType,
            obscureText: obscureText.value,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              hintText: hintText ?? type.getHintText(context),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: AppColors.primary,
                ),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(8),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: AppColors.kRedColor,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: AppColors.kRedColor,
                ),
              ),
              suffixIcon: Builder(
                builder: (context) {
                  return switch (type) {
                    AppTextfieldType.password => GestureDetector(
                        onTap: () => obscureText.value = !obscureText.value,
                        child: Icon(
                          obscureText.value
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_rounded,
                        ),
                      ),
                    _ => const SizedBox.shrink(),
                  };
                },
              ),
            ),
          ),
        ),
        if (errorText != null) ...[
          Text(
            errorText ?? '',
            style: context.smallText?.copyWith(
              color: AppColors.kRedColor,
              fontSize: 12,
            ),
          ),
        ],
      ],
    );
  }
}
