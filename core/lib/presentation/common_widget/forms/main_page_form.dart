import 'package:flutter/material.dart';

import '../../theme/shadow.dart';
import '../../theme/theme_color.dart';

class MainPageForm extends StatelessWidget {
  final Widget? body;
  final String title;
  final List<Widget>? actions;
  final Widget? extention;

  const MainPageForm({
    Key? key,
    this.body,
    required this.title,
    this.actions,
    this.extention,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildAppBar(context),
          Expanded(child: body ?? const SizedBox()),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    final mediaData = MediaQuery.of(context);
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(top: mediaData.padding.top + 16),
      decoration: BoxDecoration(
        color: themeColor.primaryColor,
        boxShadow: boxShadowlight,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
        ),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                ),
                child: Text(
                  title,
                  style: theme.textTheme.headline3?.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            ...actions ?? const <Widget>[],
          ],
        ),
      ),
    );
  }
}
