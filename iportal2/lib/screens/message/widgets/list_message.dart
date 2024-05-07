import 'package:core/data/models/models.dart';
import 'package:core/resources/assets.gen.dart';
import 'package:core/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:iportal2/screens/message/conponents/card_messages.dart';

class ListMessage extends StatelessWidget {
  final List<Message> chatRooms;

  const ListMessage({super.key, required this.chatRooms});

  @override
  Widget build(BuildContext context) {
    if (chatRooms.isEmpty) {
      return Expanded(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Image(image: Assets.images.noMessagesPng.provider()),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      'Bạn chưa có tin nhắn nào',
                      style: AppTextStyles.normal16(
                          fontWeight: FontWeight.w600,
                          color: AppColors.gray600),
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    color: AppColors.primaryRedColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(60),
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      'Gửi tin nhắn',
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 16,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.only(top: 10),
        shrinkWrap: true,
        itemCount: chatRooms.length,
        itemBuilder: (BuildContext context, int index) {
          final chat = chatRooms[index];
          return ChatRoomItem(
              onTap: () {
                // context.push(ChatRoomScreen(messageChatRoom: chat));
              },
              chatRoom: chat);
        },
      ),
    );
  }
}
