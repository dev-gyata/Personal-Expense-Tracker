import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:personal_expense_tracker/l10n/l10n.dart';

enum AppTextfieldType {
  email,
  password,
  text;

  TextInputType get getTextInputType {
    return switch (this) {
      AppTextfieldType.email => TextInputType.emailAddress,
      AppTextfieldType.password => TextInputType.text,
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
  });
  const AppTextfield.password({
    super.key,
    this.onChanged,
    this.hintText,
    this.label,
    this.errorText,
  }) : type = AppTextfieldType.password;
  const AppTextfield.email({
    super.key,
    this.onChanged,
    this.hintText,
    this.label,
    this.errorText,
  }) : type = AppTextfieldType.email;
  final AppTextfieldType type;
  final String? label;
  final ValueChanged<String>? onChanged;
  final String? hintText;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    final obscureText = useState(type == AppTextfieldType.password);
    return TextField(
      onChanged: onChanged,
      keyboardType: type.getTextInputType,
      obscureText: obscureText.value,
      decoration: InputDecoration(
        errorText: errorText,
        labelText: label ?? type.getLabelText(context),
        hintText: hintText ?? type.getHintText(context),
        prefixIcon: Builder(
          builder: (context) {
            return switch (type) {
              AppTextfieldType.email => const Icon(Icons.email),
              AppTextfieldType.password => const Icon(Icons.key),
              _ => const SizedBox.expand(),
            };
          },
        ),
        suffixIcon: Builder(
          builder: (context) {
            return switch (type) {
              AppTextfieldType.password => GestureDetector(
                  onTap: () => obscureText.value = !obscureText.value,
                  child: Icon(
                    obscureText.value ? Icons.visibility_off : Icons.visibility,
                  ),
                ),
              _ => const SizedBox.shrink(),
            };
          },
        ),
      ),
    );
  }
}
