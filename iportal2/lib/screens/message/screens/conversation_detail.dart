import 'dart:io';

import 'package:core/core.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:iportal2/app.dart';
import 'package:iportal2/app_config/router_configuration.dart';
import 'package:iportal2/common_bloc/current_user/bloc/current_user_bloc.dart';
import 'package:iportal2/components/custom_loading_logo.dart';
import 'package:iportal2/resources/assets.gen.dart';
import 'package:iportal2/screens/message/bloc/message_bloc.dart';
import 'package:iportal2/screens/message/widgets/conversation_message.dart';

class ConversationDetail extends StatelessWidget {
  const ConversationDetail({
    super.key,
    this.conversationId = '',
    this.recipientId = '',
    this.isGetById = false,
    this.fullName,
    this.urlImage,
  });

  final String conversationId;
  final String recipientId;
  final bool isGetById;
  final String? fullName;
  final String? urlImage;

  static const String routeName = '/conservation_detail';

  @override
  Widget build(BuildContext context) {
    final messageBloc = context.read<MessageBloc>();

    messageBloc.add(GetConservationDetail(
      conversationId: conversationId,
      recipientId: recipientId,
      isGetById: isGetById,
      showLoading: true,
    ));

    if (!isNullOrEmpty(conversationId)) {
      messageBloc.add(GetPinMessage(
        recipientId: recipientId,
      ));
    }

    return ConservationDetailView(
      conversationId: conversationId,
      recipientId: recipientId,
      isGetById: isGetById,
      fullName: fullName,
      urlImage: urlImage,
    );
  }
}

class ConservationDetailView extends StatefulWidget {
  const ConservationDetailView({
    super.key,
    this.conversationId = '',
    this.recipientId = '',
    this.isGetById = false,
    this.fullName,
    this.urlImage,
  });

  final String conversationId;
  final String recipientId;
  final bool isGetById;
  final String? fullName;
  final String? urlImage;

  @override
  State<ConservationDetailView> createState() => _ConservationDetailViewState();
}

class _ConservationDetailViewState extends State<ConservationDetailView> {
  final ScrollController _scrollController = ScrollController();

  final Map<int, GlobalKey> _messageKeys = {};
  final TextEditingController textFieldController = TextEditingController();
  final TextEditingController lastTextFieldController = TextEditingController();
  bool isFocus = false;
  final picker = ImagePicker();
  List<File> tempFiles = [];

  final FocusNode _focus = FocusNode();

  @override
  void initState() {
    super.initState();
    _focus.requestFocus();
    _focus.addListener(_onFocusChange);
    _scrollController.addListener(_onScrollListView);
  }

  @override
  dispose() {
    super.dispose();
    _focus.unfocus();
    _focus.removeListener(_onFocusChange);
    _focus.dispose();
    _scrollController.removeListener(_onScrollListView);
  }

  void _onFocusChange() {
    setState(() {
      isFocus = _focus.hasFocus;
    });
  }

  void _onScrollListView() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      context.read<MessageBloc>().add(GetConservationDetail(
            conversationId: widget.conversationId,
            recipientId: widget.recipientId,
            isGetById: widget.isGetById,
            isFetchNextPage: true,
          ));
    }
  }

  Future pickImages() async {
    final pickedFile = await picker.pickMultiImage(
      imageQuality: 100,
      maxHeight: 1000,
      maxWidth: 1000,
      limit: 10,
    );
    List<XFile> xfilePick = pickedFile;

    if (xfilePick.isNotEmpty) {
      for (var i = 0; i < xfilePick.length; i++) {
        tempFiles.add(File(xfilePick[i].path));
      }
      if (tempFiles.isNotEmpty) {
        context.read<MessageBloc>().add(SendMessage(
              content: 'Hình ảnh',
              recipient: widget.recipientId,
              files: tempFiles,
            ));
      }
    }
  }

  void _pickAttachment() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx', 'xls', 'xlsx', 'ppt', 'pptx'],
    );
    if (result != null) {
      for (var i = 0; i < result.files.length; i++) {
        tempFiles.add(File(result.files[i].path!));
      }
      if (tempFiles.isNotEmpty) {
        context.read<MessageBloc>().add(SendMessage(
              content: 'Tệp đính kèm',
              recipient: widget.recipientId,
              files: tempFiles,
            ));
      }
    }
  }

  void _showOptions() {
    showModalBottomSheet(
      context: context,
      builder: (_) => Container(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 24),
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.photo),
              title: const Text('Gửi ảnh'),
              onTap: () {
                Navigator.pop(context);
                pickImages();
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
      ),
    );
  }

  Future<void> _scrollToPinnedMessage() async {
    final messageState = context.read<MessageBloc>().state;
    final messagePin = messageState.messagePin;
    final conservationDetail = messageState.conservationDetail;

    if (messagePin != null && conservationDetail.isNotEmpty) {
      final index = conservationDetail
          .indexWhere((message) => message.id == messagePin.id);
      if (index != -1) {
        final key = _messageKeys[messagePin.id ?? 0];
        if (key != null && key.currentContext != null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Scrollable.ensureVisible(key.currentContext!,
                duration: const Duration(milliseconds: 300));
          });
        }
      } else if (messageState.hasMoreData) {
        if (_scrollController.hasClients) {
          _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
        }
        await Future.delayed(const Duration(milliseconds: 500));
        _scrollToPinnedMessage();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentUserBloc, CurrentUserState>(
      builder: (context, state) {
        final profileInfo = state.user;
        final userLoginId = profileInfo.user_id.toString();
        final w = SizeUtils.width;

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
                      switch (state.messageDetailStatus) {
                        case MessageStatus.successSendMessage:
                        case MessageStatus.successDeleteMessage:
                          context.read<MessageBloc>().add(GetConservationDetail(
                                conversationId: widget.conversationId,
                                recipientId: widget.recipientId,
                                isGetById: widget.isGetById,
                                isGetNewMessage: state.messageDetailStatus ==
                                    MessageStatus.successSendMessage,
                              ));
                          tempFiles.clear();

                          break;

                        default:
                          break;
                      }

                      switch (state.pinStatus) {
                        case MessageStatus.successPinMessage:
                        case MessageStatus.successUnpinMessage:
                          context.read<MessageBloc>().add(GetPinMessage(
                                recipientId: widget.recipientId,
                              ));
                          break;
                        default:
                      }
                    },
                    child: BlocBuilder<MessageBloc, MessageState>(
                      builder: (context, state) {
                        final listMessage = state.conservationDetail;
                        final messagePin = state.messagePin;
                        final userId = profileInfo.user_id;
                        final messageDetailStatus = state.messageDetailStatus;
                        final isLoading = messageDetailStatus ==
                            MessageStatus.loadingConservationDetail;

                        final isLoadingMoreData = messageDetailStatus ==
                            MessageStatus.loadingLoadMoreMessages;

                        final recipientInfo = listMessage.firstWhere(
                          (message) => message.userId != userId,
                          orElse: () => ConservationDetail.empty(),
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
                                  recipientInfo: recipientInfo,
                                  fullName: widget.fullName,
                                  urlImage: widget.urlImage,
                                ),

                                // Pin message
                                if (!isNullOrEmpty(messagePin?.content) &&
                                    messagePin?.conversationId.toString() ==
                                        widget.conversationId)
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: GestureDetector(
                                      onTap: () => _scrollToPinnedMessage(),
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
                                                    UnPinMessage(
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

                                Expanded(
                                  child: Stack(
                                    children: [
                                      ListView.builder(
                                        cacheExtent: 1200,
                                        controller: _scrollController,
                                        reverse: true,
                                        itemCount: listMessage.length,
                                        itemBuilder: (_, index) {
                                          final message = listMessage[index];
                                          final nextMessage =
                                              index + 1 < listMessage.length
                                                  ? listMessage[index + 1]
                                                  : null;

                                          final isSamePeople =
                                              nextMessage != null &&
                                                  nextMessage.userId ==
                                                      message.userId;

                                          _messageKeys.putIfAbsent(
                                              message.id ?? 0,
                                              () => GlobalKey());

                                          final messageCreatedAt = DateFormat(
                                                  'yyyy-MM-DD HH:mm:ss')
                                              .parse(message.createdAt ?? '');

                                          final nextMessageCreatedAt =
                                              nextMessage == null
                                                  ? DateTime.now()
                                                  : DateFormat(
                                                          'yyyy-MM-DD HH:mm:ss')
                                                      .parse(nextMessage
                                                              .createdAt ??
                                                          '');

                                          final timeDifference =
                                              messageCreatedAt.difference(
                                                  nextMessageCreatedAt);

                                          final showTime =
                                              timeDifference.inHours > 4;

                                          return ConversationMessage(
                                            key: _messageKeys[message.id ?? 0],
                                            isSamePeople: isSamePeople,
                                            messageDetail: message,
                                            fullName: widget.fullName,
                                            urlImage: widget.urlImage,
                                            showTime: showTime ||
                                                index == listMessage.length - 1,
                                          );
                                        },
                                      ),
                                      if (isLoadingMoreData)
                                        const Align(
                                          alignment: Alignment.topCenter,
                                          child: LoadingWithBrand(
                                              isSmallSize: true),
                                        )
                                    ],
                                  ),
                                ),

                                // New message sending..
                                if ((messageDetailStatus ==
                                        MessageStatus.loadingSendMessage ||
                                    messageDetailStatus ==
                                        MessageStatus.loadingGetNewMessage))
                                  lastTextFieldController.text.isNotEmpty
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Container(
                                              margin:
                                                  const EdgeInsets.only(top: 4),
                                              decoration: BoxDecoration(
                                                color: AppColors.blue600,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 12,
                                                        vertical: 4),
                                                child: Text(
                                                  lastTextFieldController.text,
                                                  style: AppTextStyles.custom(
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ),
                                            ),
                                            const Icon(
                                              Icons.circle_outlined,
                                              color: AppColors.blue600,
                                              size: 10,
                                            ),
                                            const SizedBox(width: 4),
                                          ],
                                        )
                                      : Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Column(
                                              children: List.generate(
                                                tempFiles.length,
                                                (index) => Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      child: Image.file(
                                                        tempFiles[index],
                                                        width: w / 2,
                                                        height: w / 2,
                                                        fit: BoxFit.cover,
                                                        errorBuilder: (context,
                                                                error,
                                                                stackTrace) =>
                                                            Container(
                                                          width: w * 0.5,
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  vertical: 4,
                                                                  horizontal:
                                                                      8),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: AppColors
                                                                .blue600,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20),
                                                          ),
                                                          child: Row(
                                                            children: [
                                                              const Icon(
                                                                Icons
                                                                    .file_present_rounded,
                                                                color: AppColors
                                                                    .white,
                                                                size: 32,
                                                              ),
                                                              const SizedBox(
                                                                  width: 5),
                                                              Expanded(
                                                                child: Text(
                                                                  'Tệp đính kèm',
                                                                  style: AppTextStyles
                                                                      .normal14(
                                                                    color: AppColors
                                                                        .white,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(height: 4),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            const Icon(
                                              Icons.circle_outlined,
                                              color: AppColors.blue600,
                                              size: 10,
                                            ),
                                            const SizedBox(width: 4),
                                          ],
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
                                context.read<MessageBloc>().add(SendMessage(
                                      content: textFieldController.text,
                                      recipient: widget.recipientId,
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
  const ChatRoomAppBar({
    super.key,
    required this.recipientInfo,
    this.fullName,
    this.urlImage,
  });

  final ConservationDetail recipientInfo;
  final String? fullName;
  final String? urlImage;

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
                        .add(GetConversationList(
                          isResetConservationDetail: true,
                        ));
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
                CircleAvaImage(
                    urlAva: urlImage ?? recipientInfo.avatarUrl ?? ''),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    fullName ?? recipientInfo.fullName ?? '',
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
