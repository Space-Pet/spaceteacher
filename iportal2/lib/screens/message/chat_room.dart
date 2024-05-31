// ignore_for_file: unused_field
import 'dart:io';
import 'package:core/core.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:iportal2/app.dart';
import 'package:iportal2/app_config/router_configuration.dart';
import 'package:iportal2/components/app_bar/app_bar.dart';
import 'package:iportal2/components/back_ground_container.dart';
import 'package:iportal2/resources/assets.gen.dart';
import 'package:iportal2/screens/authentication/utilites/dialog_utils.dart';
import 'package:iportal2/screens/message/bloc/message_bloc.dart';
import 'package:iportal2/screens/message/widgets/list_message_detail.dart';

class ChatRoomScreen extends StatelessWidget {
  const ChatRoomScreen(
      {super.key, this.messageChatRoom, this.phoneBookStudent});
  final Message? messageChatRoom;
  final PhoneBookStudent? phoneBookStudent;
  static const String routeName = '/chatMessages';

  @override
  Widget build(BuildContext context) {
    final messageBloc = context.read<MessageBloc>();
    final conversationId = messageChatRoom?.conversationId?.toString() ?? '';

    if (!isNullOrEmpty(conversationId)) {
      messageBloc
        ..add(GetMessageDetail(conversationId: conversationId))
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
            LoadingDialog.hide(context);
            break;
          case MessageStatus.loadingGetPinMessage:
            LoadingDialog.show(context);
          case MessageStatus.loadingDeletePinMessage:
            LoadingDialog.show(context);
            break;
          case MessageStatus.successGetPinMessage:
            LoadingDialog.hide(context);
            break;

          default:
            break;
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
  final ScrollController _scrollController = ScrollController();
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  final Map<int, GlobalKey> _messageKeys = {};
  final TextEditingController textFieldController = TextEditingController();
  List<MessageDetail> messages = [];
  File? _pickedImage, _pickedFile;
  int currentPage = 1;

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
    return PopScope(
      onPopInvoked: (didPop) =>
          didPop ? context.read<MessageBloc>().add(GetListMessage()) : null,
      child: BlocListener<MessageBloc, MessageState>(
        listener: (context, state) {
          if (state.messageStatus == MessageStatus.success) {
            messages.addAll(state.messageDetail);
            currentPage = state.currentPage ?? 1;
          } else if (state.messageStatus == MessageStatus.successRestart) {
            messages = state.messageDetail;
            currentPage = state.currentPage ?? 1;
            _scrollController.animateTo(0,
                duration: Durations.long2, curve: Curves.easeInOut);
          }
        },
        child: BlocBuilder<MessageBloc, MessageState>(
          builder: (context, state) {
            final isLoading = state.messageStatus == MessageStatus.loading;
            final profileInfo = state.profileInfo;
            final messagePin = state.messagePin;
            final userId = profileInfo?.user_id.toString();
            final recipient = messages.isNotEmpty && messages.first.id != 0
                ? (messages.first.recipient.toString() == userId
                    ? messages.first.userId.toString()
                    : messages.first.recipient.toString())
                : widget.phoneBookStudent?.userId.toString() ?? '';

            return Scaffold(
              body: BackGroundContainer(
                child: GestureDetector(
                  onTap: () => FocusScope.of(context).unfocus(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ScreenAppBar(
                        title: widget.messageChatRoom?.fullName ?? '',
                        canGoback: true,
                        onBack: () => mainNavKey.currentContext!.pop(true),
                      ),
                      Flexible(
                        child: Container(
                          decoration: const BoxDecoration(
                            color: AppColors.white,
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(20)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              if (!isNullOrEmpty(messagePin?.content) &&
                                  messagePin?.conversationId ==
                                      widget.messageChatRoom?.conversationId)
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GestureDetector(
                                    onTap: () =>
                                        _scrollToPinnedMessage(messages),
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: AppColors.blackTransparent,
                                        borderRadius: BorderRadius.circular(15),
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
                                                          messagePin?.id ?? 0));
                                            },
                                            child: const Icon(Icons.close,
                                                color: AppColors.red),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              Expanded(
                                child: AppSkeleton(
                                  isLoading: isLoading,
                                  child: SmartRefresher(
                                    controller: _refreshController,
                                    onLoading: () {
                                      if (state.hasMoreData == true) {
                                        context
                                            .read<MessageBloc>()
                                            .add(GetMessageDetail(
                                              conversationId: widget
                                                      .messageChatRoom
                                                      ?.conversationId
                                                      ?.toString() ??
                                                  '',
                                              page: currentPage += 1,
                                            ));
                                        _refreshController.loadComplete();
                                      }
                                    },
                                    enablePullUp: state.hasMoreData == true
                                        ? true
                                        : false,
                                    enablePullDown: false,
                                    header: const Loader(),
                                    child: ListView.builder(
                                      controller: _scrollController,
                                      reverse: true,
                                      itemCount: messages.length,
                                      itemBuilder: (_, index) {
                                        final message = messages[index];
                                        _messageKeys[message.id ?? 0] =
                                            GlobalKey();
                                        return ListMessageDetail(
                                          key: _messageKeys[message.id ?? 0],
                                          messageDatail: message,
                                          profileInfo: profileInfo!,
                                          message: widget.messageChatRoom,
                                          phoneBookStudent:
                                              widget.phoneBookStudent,
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              if (state.messageStatus ==
                                      MessageStatus.loadingMessage ||
                                  state.messageStatus ==
                                      MessageStatus.loadingRestart)
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: AppColors.blue600,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.all(8),
                                      child: Text(
                                        'Đang gửi',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                  ),
                                ),
                              Container(
                                height: 60,
                                padding: const EdgeInsets.all(8),
                                color: AppColors.primarySurface,
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
        ),
      ),
    );
  }
}
