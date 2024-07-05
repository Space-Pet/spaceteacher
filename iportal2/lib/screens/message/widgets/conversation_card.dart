import 'package:core/core.dart';
import 'package:core/resources/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:iportal2/app_config/router_configuration.dart';
import 'package:iportal2/components/dialog/dialog_confirm.dart';
import 'package:iportal2/screens/message/bloc/message_bloc.dart';

class ConversationCard extends StatelessWidget {
  final Conservation? chatRoom;
  final PhoneBookStudent? newMessages;
  final VoidCallback onTap;

  const ConversationCard({
    super.key,
    this.chatRoom,
    this.newMessages,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.gray50,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Row(
                  children: [
                    CircleAvaImage(
                      urlAva: chatRoom != null
                          ? chatRoom!.avatarUrl ?? ""
                          : newMessages!.urlImage.mobile,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            chatRoom != null
                                ? chatRoom!.fullName ?? ""
                                : newMessages!.fullName,
                            maxLines: 2,
                            style: AppTextStyles.normal14(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            chatRoom != null
                                ? "${chatRoom!.content}"
                                : 'Lớp ${newMessages!.className}',
                            style: chatRoom?.unRead != null &&
                                    chatRoom!.unRead != 0
                                ? AppTextStyles.normal14(
                                    fontWeight: FontWeight.w600,
                                  )
                                : AppTextStyles.normal14(
                                    color: AppColors.textSecondary,
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              if (chatRoom != null)
                Container(
                  color: Colors.white,
                  child: PopupMenuButton<int>(
                    color: AppColors.white,
                    offset: const Offset(-12, 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              DateTime.parse(
                                chatRoom!.createAt ?? "",
                              ).hhMM,
                              style: AppTextStyles.normal12(
                                color: AppColors.gray500,
                              ),
                            ),
                            const SizedBox(height: 4),
                            if (chatRoom?.unRead != 0)
                              CircleAvatar(
                                backgroundColor: AppColors.blue500,
                                radius: 12,
                                child: Text(
                                  chatRoom!.unRead.toString(),
                                  style: AppTextStyles.normal12(
                                    color: AppColors.white,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(width: 8),
                        const Icon(
                          Icons.more_vert_outlined,
                          color: AppColors.gray400,
                        ),
                      ],
                    ),
                    onSelected: (value) {
                      if (value == 0) {
                      } else if (value == 1) {}
                    },
                    itemBuilder: (BuildContext context) =>
                        <PopupMenuEntry<int>>[
                      PopupMenuItem<int>(
                        value: 1,
                        child: GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return DialogConfirm(
                                  title:
                                      'Xác nhận xóa toàn bộ cuộc trò chuyện này',
                                  content:
                                      'Thao tác này không thể hoàn tác và sẽ xóa toàn bộ tin nhắn trong cuộc trò chuyện.',
                                  yesText: "Xác nhận",
                                  noText: "Đóng",
                                  onNo: () {
                                    context.pop();
                                  },
                                  onYes: () {
                                    context
                                        .read<MessageBloc>()
                                        .add(DeleteConservation(
                                          conservationId:
                                              chatRoom?.conversationId ?? 0,
                                        ));
                                    context.pop();
                                  },
                                );
                              },
                            );
                          },
                          child: Row(
                            children: [
                              SvgPicture.asset(Assets.icons.trash),
                              const SizedBox(width: 8),
                              const Text('Xoá cuộc trò chuyện'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
