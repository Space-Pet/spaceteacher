import 'package:flutter/material.dart';
import 'package:iportal2/resources/resources.dart';
import 'package:iportal2/screens/message/models/message.dart';
import 'package:iportal2/screens/message/models/new_message.dart';

class ChatRoomItem extends StatelessWidget {
  final MessageChatRoom? chatRoom;
  final NewMessages? newMessages;
  final VoidCallback onTap;

  const ChatRoomItem(
      {super.key, this.chatRoom, this.newMessages, required this.onTap});

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
            // boxShadow: const [
            //   BoxShadow(
            //     color: AppColors.gray100,
            //     offset: Offset(0, 5),
            //   ),
            // ],
            color: AppColors.gray50,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  // Container(
                  //   height: 40,
                  //   width: 40,
                  //   decoration: BoxDecoration(
                  //       color: AppColors.white,
                  //       image: const DecorationImage(
                  //           fit: BoxFit.cover,
                  //           image: AssetImage('assets/images/avatar.png')),
                  //       borderRadius: BorderRadius.circular(20),
                  //       border: Border.all(color: AppColors.white)),
                  // ),
                  Image.asset(
                    'assets/images/default-user.png',
                    width: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          chatRoom != null ? chatRoom!.name : newMessages!.name,
                          style: AppTextStyles.normal14(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          chatRoom != null
                              ? chatRoom!.lastMessage
                              : newMessages!.description,
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
                Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          chatRoom!.lastTime,
                          style: AppTextStyles.normal12(
                            color: AppColors.gray500,
                          ),
                        ),
                        const Icon(
                          Icons.more_vert_outlined,
                          color: AppColors.gray400,
                        ),
                      ],
                    ),
                    if (chatRoom!.unRead != null)
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
            ],
          ),
        ),
      ),
    );
  }
}
