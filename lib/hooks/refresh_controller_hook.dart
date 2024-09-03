import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

RefreshController useRefreshController() {
  return use(
    const _RefreshControllerHook(),
  );
}

class _RefreshControllerHook extends Hook<RefreshController> {
  const _RefreshControllerHook();

  @override
  _RefreshControllerHookState createState() => _RefreshControllerHookState();
}

class _RefreshControllerHookState
    extends HookState<RefreshController, _RefreshControllerHook> {
  late RefreshController _controller;
  @override
  void initHook() {
    super.initHook();
    _controller = RefreshController();
  }

  @override
  RefreshController build(BuildContext context) => _controller;

  @override
  void dispose() {
    super.dispose();
  }
}
