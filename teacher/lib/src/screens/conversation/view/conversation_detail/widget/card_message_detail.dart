import 'package:core/core.dart';
import 'package:core/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:teacher/model/message_detail_model.dart';
import 'package:teacher/resources/assets.gen.dart';
import 'package:teacher/src/utils/user_manager.dart';

class CardMessageDetail extends StatelessWidget {
  final MessageDetailModel messageDetailModel;

  const CardMessageDetail({super.key, required this.messageDetailModel});
  @override
  Widget build(BuildContext context) {
    final isSentByMe =
        messageDetailModel.userId == UserManager.instance.user.userId;
    return Align(
      alignment: isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Container(
          padding: const EdgeInsets.all(10.0),
          width: MediaQuery.of(context).size.width * 4 / 5,
          decoration: BoxDecoration(
            color: isSentByMe
                ? AppColors.cardBackgroundChatByMe
                : AppColors.gray50,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: !isSentByMe
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: CircleAvatar(
                        backgroundImage: isNullOrEmpty(
                                messageDetailModel.avatarUrl)
                            ? Assets.images.avatar.provider()
                            : NetworkImage(messageDetailModel.avatarUrl ?? ""),
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Expanded(
                      flex: 5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            messageDetailModel.fullName ?? '',
                            style: AppTextStyles.bold14(
                                color: AppColors.blueForgorPassword),
                          ),
                          const SizedBox(height: 4.0),
                          Text(
                            messageDetailModel.content ?? '',
                            style: AppTextStyles.normal16(),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      messageDetailModel.content ?? "",
                      style: AppTextStyles.semiBold16(color: AppColors.white),
                    ),
                    const SizedBox(height: 4.0),
                  ],
                ),
        ),
      ),
    );
  }
}
