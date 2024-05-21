import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:teacher/resources/assets.gen.dart';

class TabContent extends StatelessWidget {
  const TabContent(
      {super.key,
      required this.content,
      this.isShowIcon,
      required this.title,
      this.isShowDottedLine = true,
      this.onTap});
  final String title;
  final String content;
  final bool? isShowIcon;
  final Function()? onTap;
  final bool isShowDottedLine;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Inter',
                      ),
                    ),
                    Container(
                      constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.6),
                      child: Text(
                        content,
                        style: const TextStyle(
                            color: AppColors.gray500, fontSize: 12),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                      ),
                    ),
                  ],
                ),
              ),
              if (isShowIcon!)
                GestureDetector(
                  onTap: onTap,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Assets.icons.editProfile.svg(
                      height: 24,
                      width: 24,
                    ),
                  ),
                )
            ],
          ),
          const SizedBox(height: 10),
          if (isShowDottedLine)
            const DottedLine(
              dashLength: 2,
              dashColor: AppColors.gray300,
            ),
        ],
      ),
    );
  }
}
