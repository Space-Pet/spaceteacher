import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';

import 'package:core/resources/resources.dart';
import 'package:dotted_line/dotted_line.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:teacher/model/message_model.dart';
import 'package:teacher/resources/assets.gen.dart';

class CardMessage extends StatelessWidget {
  const CardMessage({super.key, required this.message});

  final MessageModel message;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.gray100,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.zero,
      child: ListTile(
        leading: CircleAvatar(
          maxRadius: 25,
          backgroundImage: isNullOrEmpty(message.avatarUrl)
              ? Assets.images.avatar.provider()
              : CachedNetworkImageProvider(message.avatarUrl ?? ""),
        ),
        title: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  message.fullName ?? "",
                  style: AppTextStyles.bold14(color: AppColors.textPrimary),
                ),
                Text(
                  message.content ?? "",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.normal12(color: AppColors.gray500),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      DateFormat(DateFormat.HOUR)
                          .format(DateTime.parse(message.createdAt ?? "")),
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    if (!isNullOrEmpty(message.unRead))
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: const BoxDecoration(
                            color: AppColors.blue500, shape: BoxShape.circle),
                        child: Text(
                          '${message.unRead}',
                          style: AppTextStyles.semiBold12(
                            color: AppColors.white,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ],
        ),
        contentPadding: const EdgeInsets.all(10),
        trailing: PopupMenuButton<String>(
          icon: const Icon(
            Icons.more_vert,
            color: AppColors.gray500,
          ),
          splashRadius: 10,
          color: AppColors.white,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 1,
          surfaceTintColor: Colors.transparent,
          itemBuilder: (ctx) {
            return [
              PopupMenuItem(
                value: 'pin',
                child: PopupMenuItemMessage(
                  title: 'Ghim tin nhắn',
                  svg:
                      Assets.icons.pin.svg(color: AppColors.blueForgorPassword),
                ),
              ),
              PopupMenuItem(
                value: 'delete',
                child: PopupMenuItemMessage(
                  title: 'Xóa tin nhắn',
                  svg: Assets.icons.trashBin
                      .svg(color: AppColors.blueForgorPassword),
                ),
              ),
              const PopupMenuItem(
                value: 'cancel',
                child: PopupMenuItemMessage(
                  title: 'Hủy',
                  isLast: true,
                  colorText: AppColors.red,
                ),
              ),
            ];
          },
          offset: const Offset(0, 40),
        ),
      ),
    );
  }
}

class PopupMenuItemMessage extends StatelessWidget {
  const PopupMenuItemMessage({
    super.key,
    required this.title,
    this.svg,
    this.isLast = false,
    this.colorText,
  });
  final String title;
  final SvgPicture? svg;
  final bool? isLast;
  final Color? colorText;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: MediaQuery.of(context).size.width * 1 / 3,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: isLast == true
            ? CrossAxisAlignment.center
            : CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (!isNullOrEmpty(svg)) svg ?? const SizedBox(),
              if (!isLast!) const SizedBox(width: 10),
              Text(
                title,
                style: AppTextStyles.normal12(
                  color: colorText ?? AppColors.black,
                ),
              ),
            ],
          ),
          if (!isLast!) const SizedBox(height: 10),
          if (!isLast!)
            const DottedLine(
              dashLength: 5,
              dashColor: AppColors.gray500,
            ),
        ],
      ),
    );
  }
}
