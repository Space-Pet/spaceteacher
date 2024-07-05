import 'package:core/core.dart' hide TitleAndInputText;
import 'package:core/resources/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:teacher/app_config/router_configuration.dart';
import 'package:teacher/components/app_bar/app_bar.dart';
import 'package:teacher/components/back_ground_container.dart';
import 'package:teacher/components/custom_refresh.dart';
import 'package:teacher/components/textfield/input_text.dart';
import 'package:teacher/screens/message/bloc/message_bloc.dart';
import 'package:teacher/screens/message/screens/conversation_list.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});
  static const String routeName = '/message_screen';

  @override
  Widget build(BuildContext context) {
    final messageBloc = context.read<MessageBloc>();
    messageBloc.add(GetListClass());

    return BlocListener<MessageBloc, MessageState>(
        listenWhen: (previous, current) {
          return previous.messageStatus != current.messageStatus;
        },
        listener: (context, state) {
          if (state.messageStatus == MessageStatus.successDeleteConservation) {
            messageBloc.add(GetConversationList());
          }
        },
        child: const MessageView());
  }
}

class MessageView extends StatefulWidget {
  const MessageView({super.key});

  @override
  State<MessageView> createState() => _MessageViewState();
}

class _MessageViewState extends State<MessageView> {
  var search = '';
  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MessageBloc, MessageState>(
      builder: (context, state) {
        final listClass = state.classTeacher;
        final isLoading =
            state.messageStatus == MessageStatus.loadingConservationList;
        final conservationList = state.conservationList;

        final filteredConservationList = conservationList.where((chatRoom) {
          final searchText = search.toLowerCase();
          return chatRoom.fullName?.toLowerCase().contains(searchText) ?? false;
        }).toList();

        return BackGroundContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ScreenAppBar(
                      title: 'Tin nhắn',
                      canGoback: true,
                      onBack: () {
                        context.pop();
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 32, right: 16),
                    child: FilterItem(
                      isFlexibleHeight: true,
                      selectedOption: listClass.isEmpty
                          ? ''
                          : 'Lớp ${listClass[0].gradeTitle}${listClass[0].className}',
                      onUpdateOption: (value) {},
                      title: 'Chọn lớp',
                      options: listClass
                          .map((e) => 'Lớp ${e.gradeTitle}${e.className}')
                          .toList(),
                      isTransparentStyle: true,
                    ),
                  )
                ],
              ),
              Expanded(
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
                    child: CustomRefresh(
                      onRefresh: () async {
                        context.read<MessageBloc>().add(GetConversationList());
                      },
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: TitleAndInputText(
                              focusNode: _focusNode,
                              obscureText: true,
                              hintText: 'Tìm kiếm',
                              onChanged: (value) {
                                setState(() {
                                  search = value;
                                });
                              },
                              onSubmit: () {
                                _focusNode.unfocus();
                              },
                              prefixIcon: Assets.images.search.image(),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                _focusNode.unfocus();
                              },
                              child: AppSkeleton(
                                isLoading: isLoading,
                                child: conservationList.isEmpty
                                    ? const EmptyScreen(
                                        text: 'Không có tin nhắn')
                                    : filteredConservationList.isEmpty
                                        ? _buildEmptyState(search)
                                        : ConversationList(
                                            conservations:
                                                filteredConservationList,
                                          ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
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
