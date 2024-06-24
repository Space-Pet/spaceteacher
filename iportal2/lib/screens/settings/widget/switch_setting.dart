import 'package:core/resources/resources.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AccountSetting extends StatelessWidget {
  const AccountSetting({
    super.key,
    required this.text,
    required this.iconAsset,
    this.onPressed,
    this.textRight,
    this.showDottedLine = true,
    this.isNotiSetting = false,
    this.isDisableNoti = false,
  });
  final String text;
  final String? textRight;
  final String iconAsset;
  final Function()? onPressed;
  final bool showDottedLine;
  final bool isNotiSetting;
  final bool isDisableNoti;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.only(left: 10.5, right: 10.5, bottom: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        iconAsset,
                        height: 20,
                        width: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          text,
                          style:
                              AppTextStyles.normal16(color: AppColors.gray600),
                        ),
                      )
                    ],
                  ),
                ),
                if (isNotiSetting)
                  Transform.scale(
                    scale: 0.6,
                    child: CupertinoSwitch(
                      value: isDisableNoti,
                      onChanged: (value) {
                        onPressed!();
                      },
                    ),
                  ),
                if (!isNotiSetting)
                  Row(
                    children: [
                      Text(
                        textRight ?? '',
                        style: AppTextStyles.normal16(),
                      ),
                      IconButton(
                          onPressed: onPressed,
                          icon: const Icon(
                            Icons.keyboard_arrow_right,
                            color: AppColors.gray400,
                          )),
                    ],
                  ),
              ],
            ),
            if (showDottedLine)
              const Padding(
                padding: EdgeInsets.only(top: 5),
                child: SizedBox(
                  width: double.infinity,
                  child: DottedLine(
                    dashLength: 2,
                    dashColor: AppColors.gray300,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
