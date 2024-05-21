import 'package:core/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';



class CheckBoxItem extends StatefulWidget {
  final String? title;
  final bool isChecked;
  final String? svgAssetPath;

  const CheckBoxItem({
    super.key,
    this.title,
    required this.isChecked,
    this.svgAssetPath,
  });

  @override
  _CheckBoxItemState createState() => _CheckBoxItemState();
}

class _CheckBoxItemState extends State<CheckBoxItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: widget.svgAssetPath != null
          ? BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: widget.isChecked ? AppColors.gray400 : AppColors.gray100,
              ),
            )
          : null,
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(),
                    color: widget.isChecked ? Colors.white : Colors.transparent,
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
                Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Text(
                    widget.title!,
                    style: AppTextStyles.normal16(fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
            if (widget.svgAssetPath != null)
              SvgPicture.asset(widget.svgAssetPath!),
          ],
        ),
      ),
    );
  }
}
