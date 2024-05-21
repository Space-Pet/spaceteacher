import 'package:flutter/material.dart';
import 'package:teacher/src/utils/extension_context.dart';

class LoadingDialog extends StatelessWidget {
  static void show(BuildContext context, {Key? key}) => showDialog<void>(
        context: context,
        useRootNavigator: false,
        barrierColor: Colors.black.withOpacity(0.65),
        barrierDismissible: false,
        builder: (_) => LoadingDialog(key: key),
      ).then((_) => FocusScope.of(context).requestFocus(FocusNode()));

  static void hide(BuildContext context) => context.pop();

  const LoadingDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (canpop) async => false,
      child: const Center(child: CircularProgressIndicator()),
    );
  }
}
