import 'package:core/data/models/models.dart';
import 'package:core/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:iportal2/screens/message/bloc/message_bloc.dart';
import 'package:iportal2/utils/utils_export.dart';
import 'package:network_data_source/network_data_source.dart';

class ListMessageDetail extends StatefulWidget {
  const ListMessageDetail(
      {super.key,
      this.phoneBookStudent,
      required this.messageDatail,
      required this.profileInfo,
      this.message});
  final MessageDetail messageDatail;
  final Message? message;
  final ProfileInfo profileInfo;
  final PhoneBookStudent? phoneBookStudent;

  @override
  State<ListMessageDetail> createState() => _ListMessageDetailState();
}

class _ListMessageDetailState extends State<ListMessageDetail> {
  void _showMessageOptions(MessageDetail message) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Wrap(
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.push_pin),
              title: const Text('Ghim tin nhắn'),
              onTap: () {
                Navigator.of(context).pop();
                _pinMessage(message);
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete),
              title: const Text('Xoá tin nhắn'),
              onTap: () {
                Navigator.of(context).pop();
                _deleteMessage(message);
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

  void _pinMessage(MessageDetail message) {
    context.read<MessageBloc>().add(PinMessage(idMessage: message.id));
  }

  void _deleteMessage(MessageDetail message) {
    context.read<MessageBloc>().add(DeleteMessageDetail(
        content: message.content,
        idMessage: message.id,
        recipient: message.recipient.toString()));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 10,
        right: 10,
        top: (widget.messageDatail.userId == widget.profileInfo.user_id)
            ? 0
            : 10,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment:
            widget.messageDatail.userId == widget.profileInfo.user_id
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
        children: [
          if (widget.messageDatail.userId != widget.profileInfo.user_id)
            const CircleAvatar(
              radius: 24,
              backgroundColor: Colors.transparent,
              backgroundImage: AssetImage('assets/images/image-phone-book.png'),
            ),
          GestureDetector(
            onLongPress: () {
              _showMessageOptions(widget.messageDatail);
            },
            child: IntrinsicWidth(
              child: Column(
                crossAxisAlignment:
                    (widget.message?.id ?? widget.phoneBookStudent?.userId) ==
                            widget.profileInfo.user_id
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: Text(
                      widget.messageDatail.userId != widget.profileInfo.user_id
                          ? widget.message?.fullName ??
                              widget.phoneBookStudent?.fullName ??
                              ''
                          : '',
                      style:
                          AppTextStyles.normal14(fontWeight: FontWeight.w600),
                    ),
                  ),
                  Container(
                    padding: widget.messageDatail.userId ==
                            widget.profileInfo.user_id
                        ? const EdgeInsets.all(8.0)
                        : const EdgeInsets.only(left: 5),
                    decoration: BoxDecoration(
                      color: widget.messageDatail.userId ==
                              widget.profileInfo.user_id
                          ? AppColors.blue600
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Container(
                      constraints: const BoxConstraints(
                        minWidth: 5,
                        maxWidth: 300,
                      ),
                      child: Text(
                        widget.messageDatail.content,
                        style: TextStyle(
                          color: widget.messageDatail.userId ==
                                  widget.profileInfo.user_id
                              ? Colors.white
                              : Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
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
