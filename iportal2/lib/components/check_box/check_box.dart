import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../resources/app_colors.dart';
import '../../resources/app_text_styles.dart';

class CheckBoxItem extends StatefulWidget {
  final String? title;
  final bool isChecked;
  final Function(bool)? onTap;
  final String? svgAssetPath;

  const CheckBoxItem({
    super.key,
    this.title,
    required this.isChecked,
    this.svgAssetPath,
    this.onTap,
  });

  @override
  _CheckBoxItemState createState() => _CheckBoxItemState();
}

class _CheckBoxItemState extends State<CheckBoxItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.onTap != null) {
          widget.onTap!(widget.isChecked);
        }
      },
      child: Container(
        decoration: widget.svgAssetPath != null
            ? BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color:
                      widget.isChecked ? AppColors.gray400 : AppColors.gray100,
                ),
              )
            : null,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      if (widget.onTap != null) {
                        widget.onTap!(!widget.isChecked);
                      }
                    },
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(),
                        color: widget.isChecked
                            ? Colors.white
                            : Colors.transparent,
                      ),
                      child: widget.isChecked
                          ? const Padding(
                              padding: EdgeInsets.all(4),
                              child: CircleAvatar(
                                backgroundColor: AppColors.black,
                                radius: 4,
                              ),
                            )
                          : null,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Text(
                      widget.title!,
                      style:
                          AppTextStyles.normal16(fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
              if (widget.svgAssetPath != null)
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: SvgPicture.asset(
                      widget.svgAssetPath!), // Sử dụng giá trị của tham số này
                ),
            ],
          ),
        ),
      ),
    );
  }
}
