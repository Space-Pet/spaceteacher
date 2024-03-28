import 'package:flutter/material.dart';

import '../theme/theme_color.dart';

class StatusWidget extends StatelessWidget {
  final bool isSuccess;

  const StatusWidget({Key? key, required this.isSuccess}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 6),
      decoration: BoxDecoration(
        color: isSuccess == true ? themeColor.green : themeColor.red,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        isSuccess == true ? 'Success' : 'Failed',
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.white,
            ),
      ),
    );
  }
}
