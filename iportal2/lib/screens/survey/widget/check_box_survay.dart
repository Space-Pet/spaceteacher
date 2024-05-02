import 'package:flutter/material.dart';
import 'package:iportal2/resources/app_colors.dart';
import 'package:iportal2/resources/app_text_styles.dart';

class CheckBoxItemSurvay extends StatefulWidget {
  final String title;
  final bool isChecked;
  final Function(bool)? onTap;

  const CheckBoxItemSurvay({
    super.key,
    required this.title,
    required this.isChecked,
    this.onTap,
  });

  @override
  _CheckBoxItemSurvayState createState() => _CheckBoxItemSurvayState();
}

class _CheckBoxItemSurvayState extends State<CheckBoxItemSurvay> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.onTap != null) {
          widget.onTap!(widget.isChecked);
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
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
                      border: Border.all(color: AppColors.gray300),
                      color:
                          widget.isChecked ? Colors.white : Colors.transparent,
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
                    widget.title,
                    style: AppTextStyles.normal16(fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
