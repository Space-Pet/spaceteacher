// ignore_for_file: unused_field
import 'dart:io';
import 'package:core/data/models/models.dart';
import 'package:core/resources/resources.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:iportal2/components/app_bar/app_bar.dart';
import 'package:iportal2/components/back_ground_container.dart';
import 'package:iportal2/resources/assets.gen.dart';
import 'package:iportal2/screens/authentication/utilites/dialog_utils.dart';
import 'package:iportal2/screens/message/bloc/message_bloc.dart';
import 'package:iportal2/screens/message/widgets/list_message_detail.dart';
import 'package:iportal2/utils/utils_export.dart';

class ChatRoomScreen extends StatelessWidget {
  const ChatRoomScreen(
      {super.key, this.messageChatRoom, this.phoneBookStudent});
  final Message? messageChatRoom;
  final PhoneBookStudent? phoneBookStudent;
  static const String routeName = '/chatMessages';
  @override
  Widget build(BuildContext context) {
    final messageBloc = context.read<MessageBloc>();
    messageBloc.add(GetMessageDetail(
        conversationId: messageChatRoom?.conversationId != 0
            ? messageChatRoom?.conversationId.toString() ?? ''
            : ''));
    messageBloc.add(GetPinMessage());
    return BlocListener<MessageBloc, MessageState>(
      listenWhen: (previous, current) =>
          previous.messageStatus != current.messageStatus,
      listener: (context, state) {
        if (state.messageStatus == MessageStatus.successMessage) {
          messageBloc.add(GetMessageDetailRestart(
              conversationId:
                  messageChatRoom?.conversationId.toString() ?? ''));
        } else if (state.messageStatus == MessageStatus.loadingDelete) {
          // LoadingDialog.show(context);
        } else if (state.messageStatus == MessageStatus.successDelete) {
          messageBloc.add(GetMessageDetailRestart(
              conversationId:
                  messageChatRoom?.conversationId.toString() ?? ''));
        } else if (state.messageStatus == MessageStatus.successRestart) {
          // LoadingDialog.hide(context);
        } else if (state.messageStatus == MessageStatus.loadingPostPinMessage) {
        } else if (state.messageStatus == MessageStatus.successPostPinMessage) {
          messageBloc.add(GetPinMessage());
        } else if (state.messageStatus == MessageStatus.loadingGetPinMessage) {
          LoadingDialog.show(context);
        } else if (state.messageStatus == MessageStatus.successGetPinMessage) {
          LoadingDialog.hide(context);
        } else if (state.messageStatus ==
            MessageStatus.loadingDeletePinMessage) {
          LoadingDialog.show(context);
        } else if (state.messageStatus ==
            MessageStatus.successDeletePinMessage) {
          LoadingDialog.hide(context);
          messageBloc.add(GetPinMessage());
        }
      },
      child: ChatRoomView(
        messageChatRoom: messageChatRoom,
        phoneBookStudent: phoneBookStudent,
      ),
    );
  }
}

class ChatRoomView extends StatefulWidget {
  const ChatRoomView({super.key, this.messageChatRoom, this.phoneBookStudent});
  final Message? messageChatRoom;
  final PhoneBookStudent? phoneBookStudent;

  @override
  State<ChatRoomView> createState() => _ChatRoomViewState();
}

class _ChatRoomViewState extends State<ChatRoomView> {
  final ImagePicker _picker = ImagePicker();

  File? _pickedImage;
  File? _pickedFile;
  late TextEditingController textFieldController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final Map<int, GlobalKey> _messageKeys = {};

  void _pickImage() async {
    final XFile? pickedImageFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImageFile != null) {
      setState(() {
        _pickedImage = File(pickedImageFile.path);
      });
    }
  }

  void _pickAttachment() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        _pickedFile = File(result.files.single.path!);
      });
    }
  }

  void _showOptions() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Wrap(
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.photo),
              title: const Text('Gửi ảnh'),
              onTap: () {
                Navigator.of(context).pop();
                _pickImage();
              },
            ),
            ListTile(
              leading: const Icon(Icons.attach_file),
              title: const Text('Gửi tệp đính kèm'),
              onTap: () {
                Navigator.of(context).pop();
                _pickAttachment();
              },
            ),
          ],
        );
      },
    );
  }

  final double _itemExtent = 50.0;

  void _scrollToPinnedMessage(List<MessageDetail> messageDetail) {
    final messageBloc = context.read<MessageBloc>();
    final state = messageBloc.state;
    final messagePin = state.messagePin;

    if (messagePin != null) {
      final index =
          messageDetail.indexWhere((message) => message.id == messagePin.id);
      if (index != -1) {
        _scrollController.jumpTo(index * _itemExtent);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MessageBloc, MessageState>(
      builder: (context, state) {
        // ignore: unused_local_variable
        final isLoading = state.messageStatus == MessageStatus.loading;
        final List<MessageDetail> messages = state.messageDetail;
        final profileInfo = state.profileInfo;
        final messageStatus = state.messageStatus;
        final userId = state.profileInfo?.user_id.toString();
        final messagePin = state.messagePin;
        String recipient = '';
        if (messages.isNotEmpty && messages.first.id != 0) {
          if (messages.first.recipient.toString() == userId) {
            recipient = messages.first.userId.toString();
          } else {
            recipient = messages.first.recipient.toString();
          }
        } else {
          recipient = widget.phoneBookStudent?.userId.toString() ?? '';
        }

        print('ih: ${widget.phoneBookStudent?.userId.toString()}');
        print('id: ${widget.messageChatRoom!.id}');
        return Scaffold(
          body: BackGroundContainer(
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ScreenAppBar(
                    title: widget.messageChatRoom?.fullName ?? '',
                    canGoback: true,
                    onBack: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  Flexible(
                    child: Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          if (messagePin?.content != '')
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () {
                                  _scrollToPinnedMessage(messages);
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: AppColors.blackTransparent,
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(
                                      color: AppColors.gray200,
                                    ),
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Icon(Icons.message),
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8),
                                          child: Text(
                                            messagePin?.content ?? '',
                                            softWrap: true,
                                            overflow: TextOverflow.visible,
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          context.read<MessageBloc>().add(
                                              DeletePinMessage(
                                                  idMessage:
                                                      messagePin?.id ?? 0));
                                        },
                                        child: const Icon(
                                          Icons.close,
                                          color: AppColors.red,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          Expanded(
                            child: messages.isNotEmpty
                                ? ListView.builder(
                                    controller: _scrollController,
                                    padding: const EdgeInsets.only(bottom: 8),
                                    reverse: true,
                                    itemCount: messages.length,
                                    itemBuilder: (context, index) {
                                      final message = messages[index];
                                      final messageKey = GlobalKey();
                                      _messageKeys[message.id] = messageKey;
                                      return ListMessageDetail(
                                        key: messageKey,
                                        messageDatail: message,
                                        profileInfo: profileInfo!,
                                        message: widget.messageChatRoom,
                                        phoneBookStudent:
                                            widget.phoneBookStudent,
                                      );
                                    },
                                  )
                                : const Center(
                                    child: Text(
                                      'No messages yet',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ),
                          ),
                          if (messageStatus == MessageStatus.loadingMessage ||
                              messageStatus == MessageStatus.loadingRestart)
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10, top: 10),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppColors.blue600,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all((messageStatus ==
                                              MessageStatus.successMessage ||
                                          messageStatus ==
                                              MessageStatus.success)
                                      ? 0
                                      : 8),
                                  child: const Text(
                                    'Đang gửi',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          Container(
                            height: 60,
                            width: double.infinity,
                            color: AppColors.primarySurface,
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: GestureDetector(
                                      onTap: _showOptions,
                                      child: SvgPicture.asset(
                                          Assets.icons.fileMessage),
                                    ),
                                  ),
                                  Expanded(
                                    child: TextField(
                                      onChanged: (value) {
                                        textFieldController.text = value;
                                      },
                                      controller: textFieldController,
                                      decoration: InputDecoration(
                                        hintText: 'Nhập tin nhắn',
                                        filled: true,
                                        fillColor: AppColors.white,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          borderSide: BorderSide.none,
                                        ),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 16),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: GestureDetector(
                                      onTap: () {
                                        if (textFieldController
                                            .text.isNotEmpty) {
                                          context
                                              .read<MessageBloc>()
                                              .add(PostMessage(
                                                content:
                                                    textFieldController.text,
                                                recipient: recipient,
                                              ));
                                          textFieldController.clear();
                                        }
                                      },
                                      child: SvgPicture.asset(
                                          Assets.icons.sendMessage),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
