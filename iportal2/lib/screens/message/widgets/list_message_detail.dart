import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:iportal2/screens/message/bloc/message_bloc.dart';

class ListMessageDetail extends StatelessWidget {
  const ListMessageDetail({
    super.key,
    this.phoneBookStudent,
    required this.messageDatail,
    required this.profileInfo,
    this.message,
    required this.isSamePeople,
  });

  final MessageDetail messageDatail;
  final Message? message;
  final LocalIPortalProfile profileInfo;
  final PhoneBookStudent? phoneBookStudent;
  final bool isSamePeople;

  @override
  Widget build(BuildContext context) {
    void pinMessage(MessageDetail message) {
      context.read<MessageBloc>().add(PinMessage(idMessage: message.id ?? 0));
    }

    Future<void> deleteMessage(MessageDetail message) async {
      context.read<MessageBloc>().add(DeleteMessageDetail(
          content: message.content ?? "",
          idMessage: message.id ?? 0,
          recipient: message.recipient.toString()));
    }

    void showMessageOptions(MessageDetail message) {
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.push_pin),
                title: const Text('Ghim tin nhắn'),
                onTap: () {
                  pinMessage(message);
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete),
                title: const Text('Xoá tin nhắn'),
                onTap: () async {
                  deleteMessage(message)
                      .whenComplete(() => Navigator.of(context).pop());
                },
              ),
              ListTile(
                leading: const Icon(Icons.copy),
                title: const Text('Copy tin nhắn'),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    return Padding(
      padding: EdgeInsets.only(
        left: 10,
        right: 10,
        top: (messageDatail.userId == profileInfo.user_id) ? 4 : 4,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: messageDatail.userId == profileInfo.user_id
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          messageDatail.userId != profileInfo.user_id && !isSamePeople
              ? Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.white,
                    border: Border.all(
                      color: AppColors.white,
                      width: 2,
                    ),
                  ),
                  child: ClipOval(
                    child: FadeInImage.assetNetwork(
                      placeholder: 'assets/images/default-user.png',
                      image: message?.avatarUrl ?? '',
                      fit: BoxFit.cover,
                      imageErrorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          'assets/images/default-user.png',
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  ),
                )
              : const SizedBox(width: 40),
          GestureDetector(
            onLongPress: () {
              showMessageOptions(messageDatail);
            },
            child: IntrinsicWidth(
              child: Column(
                crossAxisAlignment: (message?.id ?? phoneBookStudent?.userId) ==
                        profileInfo.user_id
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  if (!isSamePeople)
                    Padding(
                      padding: const EdgeInsets.only(left: 5.0, bottom: 2),
                      child: Text(
                        messageDatail.userId != profileInfo.user_id
                            ? message?.fullName ??
                                phoneBookStudent?.fullName ??
                                ''
                            : '',
                        style:
                            AppTextStyles.normal14(fontWeight: FontWeight.w600),
                      ),
                    ),
                  Container(
                    padding: messageDatail.userId == profileInfo.user_id
                        ? const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 4)
                        : const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: messageDatail.userId == profileInfo.user_id
                          ? AppColors.blue600
                          : AppColors.gray100,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Container(
                      constraints: const BoxConstraints(
                        minWidth: 5,
                        maxWidth: 300,
                      ),
                      child: Text(
                        messageDatail.content ?? "",
                        style: AppTextStyles.custom(
                          color: messageDatail.userId == profileInfo.user_id
                              ? Colors.white
                              : Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        softWrap: true,
                        overflow: TextOverflow.visible,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
