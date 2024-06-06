import 'package:core/core.dart';
import 'package:core/resources/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:iportal2/app_config/router_configuration.dart';
import 'package:iportal2/screens/message/bloc/message_bloc.dart';

class ChatRoomItem extends StatelessWidget {
  final Message? chatRoom;
  final PhoneBookStudent? newMessages;
  final VoidCallback onTap;

  const ChatRoomItem({
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
              Row(
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          chatRoom != null
                              ? chatRoom!.avatarUrl ?? ""
                              : newMessages!.urlImage.mobile,
                        ),
                      ),
                      shape: BoxShape.circle,
                      color: AppColors.white,
                      border: Border.all(
                        color: AppColors.white,
                        width: 2,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          chatRoom != null
                              ? chatRoom!.fullName ?? ""
                              : newMessages!.fullName,
                          style: AppTextStyles.normal14(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          chatRoom != null
                              ? "${chatRoom!.content}"
                              : 'Lớp ${newMessages!.className}',
                          style: AppTextStyles.normal12(
                            fontWeight: chatRoom?.unRead != null
                                ? FontWeight.w600
                                : FontWeight.w400,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              if (chatRoom != null)
                Container(
                  color: Colors.white,
                  child: PopupMenuButton<int>(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                        value: 0,
                        child: Row(
                          children: [
                            SvgPicture.asset(Assets.icons.pin),
                            const Text('Ghim'),
                          ],
                        ),
                      ),
                      const PopupMenuDivider(),
                      PopupMenuItem<int>(
                        value: 1,
                        child: GestureDetector(
                          onTap: () {
                            context.read<MessageBloc>().add(DeleteMessage(
                                  idMessage: chatRoom?.conversationId ?? 0,
                                ));
                            context.pop();
                          },
                          child: Row(
                            children: [
                              SvgPicture.asset(Assets.icons.trash),
                              const Text('Xoá tin nhắn'),
                            ],
                          ),
                        ),
                      ),
                      const PopupMenuDivider(),
                      PopupMenuItem<int>(
                        value: 1,
                        child: Center(
                          child: Text(
                            'Huỷ',
                            style: AppTextStyles.bold14(color: AppColors.red),
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
