import 'package:core/data/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iportal2/app_config/router_configuration.dart';
import 'package:iportal2/common_bloc/current_user/bloc/current_user_bloc.dart';
import 'package:iportal2/components/app_bar/app_bar.dart';
import 'package:iportal2/components/app_skeleton.dart';
import 'package:iportal2/components/back_ground_container.dart';
import 'package:iportal2/resources/assets.gen.dart';
import 'package:iportal2/resources/resources.dart';
import 'package:iportal2/screens/message/bloc/message_bloc.dart';
import 'package:iportal2/screens/message/list_new_messages.dart';
import 'package:iportal2/screens/message/widgets/list_message.dart';
import 'package:iportal2/components/textfield/input_text.dart';
import 'package:repository/repository.dart';
import 'package:skeletons/skeletons.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final messageBloc = MessageBloc(
        appApiRepository: context.read<AppFetchApiRepository>(),
        currentUserBloc: context.read<CurrentUserBloc>());
    messageBloc.add(GetListMessage(page: 1));
    return BlocProvider.value(
      value: messageBloc,
      child: const MessageView(),
    );
  }
}

class MessageView extends StatefulWidget {
  const MessageView({super.key});

  @override
  _MessageViewState createState() => _MessageViewState();
}

class _MessageViewState extends State<MessageView> {
  late List<Message> _chatRooms;
  var search = '';
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isScrollAtBottom()) {
      final leaveBloc = context.read<MessageBloc>();
      if (leaveBloc.state.messageStatus == MessageStatus.success) {
        const currentPage = 1;
        leaveBloc.add(GetListMessage(page: currentPage + 1));
      }
    }
  }

  bool _isScrollAtBottom() {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    return currentScroll >= maxScroll;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MessageBloc, MessageState>(
      builder: (context, state) {
        final isLoading = state.messageStatus == MessageStatus.loading;

        final message = state.messages;
        _chatRooms = message;
        final filteredChatRooms = _chatRooms.where((chatRoom) {
          final searchText = search.toLowerCase();
          return chatRoom.fullName.toLowerCase().contains(searchText);
        }).toList();

        return BackGroundContainer(
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ScreenAppBar(
                  title: 'Tin nhắn nội bộ',
                  canGoback: true,
                  onBack: () {
                    context.pop();
                  },
                  iconRight: Assets.icons.addMessage,
                  onRight: () {
                    context.push(const ListNewMessagesScreen());
                  },
                ),
                Flexible(
                  child: Container(
                    padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: AppRadius.rounded10,
                      child: AppSkeleton(
                        isLoading: isLoading,
                        skeleton: SizedBox(
                            height: 500,
                            child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              padding: const EdgeInsets.all(0),
                              itemCount: 5,
                              itemBuilder: (context, index) => Container(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 12, 0, 12),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: index == 4
                                        ? BorderSide.none
                                        : const BorderSide(
                                            color: AppColors.gray300),
                                  ),
                                ),
                                child: SkeletonItem(
                                    child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: SkeletonParagraph(
                                            style: SkeletonParagraphStyle(
                                                lineStyle: SkeletonLineStyle(
                                              randomLength: true,
                                              height: 10,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            )),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                )),
                              ),
                            )),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: TitleAndInputText(
                                obscureText: true,
                                hintText: 'Tìm kiếm',
                                onChanged: (value) {
                                  setState(() {
                                    search = value;
                                  });
                                },
                                prefixIcon: Assets.images.search.image(),
                              ),
                            ),
                            if (filteredChatRooms.isNotEmpty)
                              ListMessage(chatRooms: filteredChatRooms)
                            else
                              _buildEmptyState(search),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildEmptyState(String searchText) {
    return Expanded(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                'Không tìm thấy $searchText',
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppColors.gray600,
                  fontSize: 16,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Image(
                image: Assets.images.noMessagesPng.provider(),
                colorBlendMode: BlendMode.luminosity,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
