import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../common/constants.dart';
import '../theme/theme_color.dart';

class WowAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? rightItem;
  final bool? hasBackButton;

  const WowAppBar({
    Key? key,
    required this.title,
    this.rightItem,
    this.hasBackButton = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 75,
      centerTitle: false,
      titleSpacing: 0,
      elevation: 0,
      automaticallyImplyLeading: false,
      title: Container(
        margin: const EdgeInsets.only(
          top: 28,
          right: 16,
          bottom: 24,
        ),
        child: Row(
          children: [
            if (Navigator.of(context).canPop() && hasBackButton == true)
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: SvgPicture.asset(coreImageConstant.icArrowLeft),
              )
            else
              const SizedBox(
                width: 16,
              ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(left: 8, right: 16),
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.headline6?.copyWith(
                        color: themeColor.white,
                        fontSize: 20,
                      ),
                  textAlign: TextAlign.start,
                ),
              ),
            ),
            if (rightItem != null) rightItem!,
          ],
        ),
      ),
     backgroundColor: themeColor.primaryColor,
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, 75);
}
