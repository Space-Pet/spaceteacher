// ignore_for_file: unused_field
import 'dart:io';

import 'package:core/core.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:iportal2/app.dart';
import 'package:iportal2/app_config/router_configuration.dart';
import 'package:iportal2/common_bloc/current_user/bloc/current_user_bloc.dart';
import 'package:iportal2/resources/assets.gen.dart';
import 'package:iportal2/screens/message/bloc/message_bloc.dart';
import 'package:iportal2/screens/message/widgets/list_message_detail.dart';

class ChatRoomScreen extends StatelessWidget {
  const ChatRoomScreen({
    super.key,
    required this.messageChatRoom,
  });

  final Message messageChatRoom;
  static const String routeName = '/chatMessages';

  @override
  Widget build(BuildContext context) {
    final messageBloc = context.read<MessageBloc>();
    final conversationId = messageChatRoom.conversationId.toString();

    if (!isNullOrEmpty(conversationId) && conversationId != '0') {
      messageBloc
        ..add(GetMessageDetail(
          conversationId: conversationId,
          showLoading: true,
        ))
        ..add(GetPinMessage());
    }

    return BlocListener<MessageBloc, MessageState>(
      listener: (context, state) {
        switch (state.messageStatus) {
          case MessageStatus.successMessage:
            messageBloc.add(GetMessageDetailRestart(
              conversationId: state.conversationID.toString(),
            ));

          case MessageStatus.successDelete:
            messageBloc
                .add(GetMessageDetailRestart(conversationId: conversationId));
            break;
          case MessageStatus.successPostPinMessage:
          case MessageStatus.successDeletePinMessage:
            messageBloc.add(GetPinMessage());
            // LoadingDialog.hide(context);
            break;
          case MessageStatus.loadingGetPinMessage:
          // LoadingDialog.show(context);
          case MessageStatus.loadingDeletePinMessage:
            // LoadingDialog.show(context);
            break;
          case MessageStatus.successGetPinMessage:
            // LoadingDialog.hide(context);
            break;

          default:
            break;
        }
      },
      child: ChatRoomView(
        messageChatRoom: messageChatRoom,
      ),
    );
  }
}

class ChatRoomView extends StatefulWidget {
  const ChatRoomView({super.key, required this.messageChatRoom});
  final Message messageChatRoom;

  @override
  State<ChatRoomView> createState() => _ChatRoomViewState();
}

class _ChatRoomViewState extends State<ChatRoomView> {
  final ImagePicker _picker = ImagePicker();
  final ScrollController _scrollController = ScrollController();
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  final Map<int, GlobalKey> _messageKeys = {};
  final TextEditingController textFieldController = TextEditingController();
  final TextEditingController lastTextFieldController = TextEditingController();
  File? _pickedImage, _pickedFile;
  int currentPage = 1;
  bool isFocus = false;

  final FocusNode _focus = FocusNode();

  @override
  void initState() {
    super.initState();
    _focus.requestFocus();
    _focus.addListener(_onFocusChange);
  }

  @override
  dispose() {
    super.dispose();
    _focus.unfocus();
    _focus.removeListener(_onFocusChange);
    _focus.dispose();
  }

  void _onFocusChange() {
    setState(() {
      isFocus = _focus.hasFocus;
    });
  }

  void _pickImage() async {
    final pickedImageFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImageFile != null) {
      setState(() => _pickedImage = File(pickedImageFile.path));
    }
  }

  void _pickAttachment() async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() => _pickedFile = File(result.files.single.path!));
    }
  }

  void _showOptions() {
    showModalBottomSheet(
      context: context,
      builder: (_) => Wrap(
        children: [
          ListTile(
            leading: const Icon(Icons.photo),
            title: const Text('Gửi ảnh'),
            onTap: () {
              Navigator.pop(context);
              _pickImage();
            },
          ),
          ListTile(
            leading: const Icon(Icons.attach_file),
            title: const Text('Gửi tệp đính kèm'),
            onTap: () {
              Navigator.pop(context);
              _pickAttachment();
            },
          ),
        ],
      ),
    );
  }

  void _scrollToPinnedMessage(List<MessageDetail> messageDetail) {
    final messagePin = context.read<MessageBloc>().state.messagePin;
    if (messagePin != null) {
      final index =
          messageDetail.indexWhere((message) => message.id == messagePin.id);
      if (index != -1) {
        _scrollController.animateTo(index * 50.0,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentUserBloc, CurrentUserState>(
      builder: (context, state) {
        final profileInfo = state.user;
        final userLoginId = profileInfo.user_id.toString();
        final message = widget.messageChatRoom;

        final recipientId = message.receiverId.toString() == userLoginId
            ? message.senderId.toString()
            : message.receiverId.toString();

        return Scaffold(
          body: Container(
            decoration: const BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: BlocListener<MessageBloc, MessageState>(
                    listener: (context, state) {
                      if (state.messageStatus == MessageStatus.success) {
                        currentPage = state.currentPage ?? 1;
                      } else if (state.messageStatus ==
                          MessageStatus.successRestart) {
                        currentPage = state.currentPage ?? 1;
                        _scrollController.animateTo(0,
                            duration: Durations.long2, curve: Curves.easeInOut);
                      }
                    },
                    child: BlocBuilder<MessageBloc, MessageState>(
                      builder: (context, state) {
                        final messages = state.messageDetail;
                        final messagePin = state.messagePin;
                        final userId = profileInfo.user_id;
                        final isLoading =
                            state.roomStatus == MessageStatus.loadingMessage;

                        final friendInfo = messages.firstWhere(
                          (message) => message.userId != userId,
                          orElse: () => MessageDetail.empty(),
                        );

                        return InkWell(
                          onTap: () {
                            _focus.unfocus();
                          },
                          child: AppSkeleton(
                            isLoading: isLoading,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                ChatRoomAppBar(
                                  friendInfo: friendInfo,
                                ),

                                // Pin message
                                if (!isNullOrEmpty(messagePin?.content) &&
                                    messagePin?.conversationId ==
                                        widget.messageChatRoom.conversationId)
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: GestureDetector(
                                      onTap: () =>
                                          _scrollToPinnedMessage(messages),
                                      child: Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: AppColors.blackTransparent,
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          border: Border.all(
                                              color: AppColors.gray200),
                                        ),
                                        child: Row(
                                          children: [
                                            const Icon(Icons.message),
                                            Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8),
                                                child: Text(
                                                    messagePin?.content ?? ''),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                context.read<MessageBloc>().add(
                                                    DeletePinMessage(
                                                        idMessage:
                                                            messagePin?.id ??
                                                                0));
                                              },
                                              child: const Icon(Icons.close,
                                                  color: AppColors.red),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),

                                // List of messages
                                Expanded(
                                  child: ListView.builder(
                                    controller: _scrollController,
                                    reverse: true,
                                    itemCount: messages.length,
                                    itemBuilder: (_, index) {
                                      final message = messages[index];
                                      final nextMessage =
                                          index + 1 < messages.length
                                              ? messages[index + 1]
                                              : null;

                                      final isSamePeople = nextMessage !=
                                              null &&
                                          nextMessage.userId == message.userId;

                                      _messageKeys[message.id ?? 0] =
                                          GlobalKey();

                                      return ListMessageDetail(
                                        key: _messageKeys[message.id ?? 0],
                                        isSamePeople: isSamePeople,
                                        messageDatail: message,
                                        profileInfo: profileInfo,
                                        message: widget.messageChatRoom,
                                      );
                                    },
                                  ),
                                ),

                                // New message sending..
                                if (state.messageStatus ==
                                        MessageStatus.loadingPostPinMessage ||
                                    state.messageStatus ==
                                        MessageStatus.loadingRestart)
                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: AppColors.blue600,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 4),
                                        child: Text(
                                          lastTextFieldController.text,
                                          style: AppTextStyles.custom(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),

                // TextField and Send Button
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  padding: EdgeInsets.only(bottom: isFocus ? 0 : 24),
                  color: AppColors.primarySurface,
                  child: Container(
                    height: 60,
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: GestureDetector(
                            onTap: _showOptions,
                            child: SvgPicture.asset(
                              Assets.icons.fileMessage,
                              width: 20,
                            ),
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            focusNode: _focus,
                            controller: textFieldController,
                            onChanged: (value) {
                              lastTextFieldController.text = value;
                              textFieldController.text = value;
                            },
                            decoration: InputDecoration(
                              hintText: 'Nhập tin nhắn',
                              filled: true,
                              fillColor: AppColors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: GestureDetector(
                            onTap: () {
                              if (textFieldController.text.isNotEmpty) {
                                context.read<MessageBloc>().add(PostMessage(
                                      content: textFieldController.text,
                                      recipient: recipientId,
                                    ));
                              }
                              textFieldController.clear();
                            },
                            child: SvgPicture.asset(
                              Assets.icons.sendMessage,
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
        );
      },
    );
  }
}

class ChatRoomAppBar extends StatelessWidget {
  const ChatRoomAppBar({super.key, required this.friendInfo});

  final MessageDetail friendInfo;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.fromLTRB(0, 20, 0, 4),
      decoration: BoxDecoration(
        color: AppColors.white.withOpacity(0.9),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    mainNavKey.currentContext!.pop(true);
                    mainNavKey.currentState!.context
                        .read<MessageBloc>()
                        .add(GetListMessageResert());
                  },
                  child: const Padding(
                    padding: EdgeInsets.fromLTRB(22, 0, 8, 0),
                    child: Icon(
                      Icons.arrow_back_ios_sharp,
                      size: 20,
                      color: AppColors.brand600,
                    ),
                  ),
                ),
                Container(
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
                      image: friendInfo.avatarUrl ?? '',
                      fit: BoxFit.cover,
                      imageErrorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          'assets/images/default-user.png',
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    friendInfo.fullName ?? '',
                    style: AppTextStyles.semiBold16(),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          // if (iconRight != null)
          //   GestureDetector(onTap: onRight, child: SvgPicture.asset(iconRight!))
        ],
      ),
    );
  }
}
