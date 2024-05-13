import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:core/resources/resources.dart';

class SwitchSetting extends StatefulWidget {
  const SwitchSetting(
      {super.key,
      required this.text,
      required this.iconAsset,
      this.onPressed,
      required this.showDottedLine,
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
                padding: const EdgeInsets.only(left: 10, top: 10),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      widget.iconAsset,
                      height: 20,
                      width: 20,
                      color: AppColors.black,
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
                  scale: 0.8,
                  child: Switch(
                    value: isSwitched,
                    onChanged: (value) {
                      setState(() {
                        isSwitched = value;
                      });
                    },
                    activeTrackColor: AppColors.green,
                    activeColor: AppColors.white,
                    inactiveThumbColor: AppColors.white,
                    inactiveTrackColor: AppColors.gray300,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
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
          if (widget.showDottedLine == true)
            const Padding(
              padding: EdgeInsets.only(top: 18),
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
