import 'package:core/core.dart';
import 'package:core/resources/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:iportal2/app.dart';
import 'package:iportal2/app_config/router_configuration.dart';
import 'package:iportal2/components/app_bar/app_bar.dart';
import 'package:iportal2/components/back_ground_container.dart';
import 'package:iportal2/components/custom_refresh.dart';
import 'package:iportal2/screens/authentication/utilites/dialog_utils.dart';
import 'package:iportal2/screens/message/bloc/message_bloc.dart';
import 'package:iportal2/screens/message/list_new_messages.dart';
import 'package:iportal2/screens/message/widgets/list_message.dart';
import 'package:iportal2/components/textfield/input_text.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});
  static const String routeName = '/messages';
  @override
  Widget build(BuildContext context) {
    final messageBloc = context.read<MessageBloc>();
    messageBloc.add(GetListMessage());
    return BlocListener<MessageBloc, MessageState>(
        listenWhen: (previous, current) {
          return previous.messageStatus != current.messageStatus;
        },
        listener: (context, state) {
          if (state.messageStatus == MessageStatus.loadingDelete) {
            LoadingDialog.show(context);
          } else if (state.messageStatus == MessageStatus.successDelete) {
            messageBloc.add(GetListMessageResert());
            LoadingDialog.hide(context);
          } else if (state.messageStatus == MessageStatus.success) {
          } else if (state.messageStatus == MessageStatus.loading) {}
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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MessageBloc, MessageState>(
      builder: (context, state) {
        final isLoading = state.messageStatus == MessageStatus.loading;

        final message = state.messages;

        final filteredChatRooms = message.where((chatRoom) {
          final searchText = search.toLowerCase();
          return chatRoom.fullName?.toLowerCase().contains(searchText) ?? false;
        }).toList();

        return Scaffold(
          body: BackGroundContainer(
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
                      mainNavKey.currentContext!.pushNamed(
                          routeName: ListNewMessagesScreen.routeName);
                    },
                  ),
                  Expanded(
                    child: Container(
                      padding:
                          const EdgeInsets.only(left: 16, right: 16, top: 8),
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
                            context
                                .read<MessageBloc>()
                                .add(GetListMessageResert());
                          },
                          child: AppSkeleton(
                            isLoading: isLoading,
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
                    ),
                  )
                ],
              ),
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
