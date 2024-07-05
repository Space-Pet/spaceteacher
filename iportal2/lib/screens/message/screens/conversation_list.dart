import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:iportal2/app.dart';
import 'package:iportal2/app_config/router_configuration.dart';
import 'package:iportal2/common_bloc/current_user/bloc/current_user_bloc.dart';
import 'package:iportal2/screens/message/screens/conversation_detail.dart';
import 'package:iportal2/screens/message/widgets/conversation_card.dart';

class ConversationList extends StatelessWidget {
  final List<Conservation> conservations;

  const ConversationList({super.key, required this.conservations});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentUserBloc, CurrentUserState>(
      builder: (context, state) {
        final userLoginId = state.user.user_id.toString();
    
        return ListView.builder(
          padding: const EdgeInsets.only(top: 10),
          shrinkWrap: true,
          itemCount: conservations.length,
          itemBuilder: (BuildContext context, int index) {
            final message = conservations[index];
            return ConversationCard(
              onTap: () {
                mainNavKey.currentContext!.pushNamed(
                  routeName: ConversationDetail.routeName,
                  arguments: {
                    'conversationId': message.conversationId.toString(),
                    'recipientId':
                        message.receiverId.toString() == userLoginId
                            ? message.senderId.toString()
                            : message.receiverId.toString(),
                    'isGetById': false,
                    'fullName': message.fullName,
                    'urlImage': message.avatarUrl,
                  },
                );
              },
              chatRoom: message,
            );
          },
        );
      },
    );
  }
}
