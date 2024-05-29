import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:iportal2/app.dart';
import 'package:iportal2/app_config/router_configuration.dart';
import 'package:iportal2/screens/message/chat_room.dart';
import 'package:iportal2/screens/message/conponents/card_messages.dart';

class ListMessage extends StatelessWidget {
  final List<Message> chatRooms;

  const ListMessage({super.key, required this.chatRooms});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.only(top: 10),
        shrinkWrap: true,
        itemCount: chatRooms.length,
        itemBuilder: (BuildContext context, int index) {
          final message = chatRooms[index];
          return ChatRoomItem(
              onTap: () {
                mainNavKey.currentContext!.pushNamed(
                  routeName: ChatRoomScreen.routeName,
                  arguments: {
                    'message': message,
                    'phoneBookStudent': PhoneBookStudent.empty(),
                  },
                );
              },
              chatRoom: message);
        },
      ),
    );
  }
}
