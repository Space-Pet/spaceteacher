import 'package:core/resources/resources.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


class SwitchSetting extends StatefulWidget {
  const SwitchSetting(
      {super.key,
      required this.text,
      required this.iconAsset,
      this.onPressed,
      this.showDottedLine = true,
      this.textRight});
  final String text;
  final String? textRight;
  final String iconAsset;
  final Function()? onPressed;
  final bool showDottedLine;
  @override
  State<SwitchSetting> createState() => _SwitchSettingState();
}

class _SwitchSettingState extends State<SwitchSetting> {
  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
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
                      widget.iconAsset,
                      height: 20,
                      width: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        widget.text,
                        style: AppTextStyles.normal16(color: AppColors.gray600),
                      ),
                    )
                  ],
                ),
              ),
              if (widget.onPressed == null)
                Transform.scale(
                  scale: 0.6,
                  child: CupertinoSwitch(
                    value: isSwitched,
                    onChanged: (value) {
                      setState(() {
                        isSwitched = value;
                      });
                    },
                  ),
                ),
              if (widget.onPressed != null)
                Row(
                  children: [
                    if (widget.textRight != null)
                      Text(
                        widget.textRight!,
                        style: AppTextStyles.normal16(),
                      ),
                    IconButton(
                        onPressed: widget.onPressed,
                        icon: const Icon(
                          Icons.keyboard_arrow_right,
                          color: AppColors.gray400,
                        )),
                  ],
                ),
            ],
          ),
          if (widget.showDottedLine)
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
    );
  }
}
