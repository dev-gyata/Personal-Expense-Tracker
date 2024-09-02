import 'package:flutter/cupertino.dart';

class UnfocusWidget extends StatelessWidget {
  const UnfocusWidget({required this.child, super.key});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _onUnfocus(context),
      child: child,
    );
  }

  void _onUnfocus(BuildContext context) {
    FocusScope.of(context).unfocus();
  }
}
