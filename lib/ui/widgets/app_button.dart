import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    required this.isValid,
    required this.label,
    super.key,
    this.onPressed,
    this.isLoading = false,
  });
  final VoidCallback? onPressed;
  final String label;
  final bool isValid;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      style: FilledButton.styleFrom(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
      ),
      onPressed: isValid
          ? () {
              if (!isLoading) {
                onPressed?.call();
              }
            }
          : null,
      label: Text(label),
      icon: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        child: !isLoading
            ? const SizedBox.shrink()
            : const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  backgroundColor: Colors.white,
                ),
              ),
      ),
    );
  }
}
