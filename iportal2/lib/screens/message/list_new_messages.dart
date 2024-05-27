import 'package:core/core.dart';
import 'package:flutter/material.dart';

import 'package:iportal2/app.dart';
import 'package:iportal2/app_config/router_configuration.dart';
import 'package:iportal2/components/app_bar/app_bar.dart';
import 'package:iportal2/components/back_ground_container.dart';
import 'package:iportal2/screens/message/bloc/message_bloc.dart';
import 'package:iportal2/screens/message/chat_room.dart';
import 'package:iportal2/screens/message/conponents/card_messages.dart';
import 'package:repository/repository.dart';

import '../../common_bloc/current_user/bloc/current_user_bloc.dart';

class ListNewMessagesScreen extends StatelessWidget {
  const ListNewMessagesScreen({super.key});
  static const routeName = '/listNewMessage';
  @override
  Widget build(BuildContext context) {
    final messageBloc = MessageBloc(
        appApiRepository: context.read<AppFetchApiRepository>(),
        currentUserBloc: context.read<CurrentUserBloc>());
    messageBloc.add(GetPhoneBookStudent());
    return BlocProvider.value(
      value: messageBloc,
      child: const ListNewMessagesView(),
    );
  }
}

class ListNewMessagesView extends StatefulWidget {
  const ListNewMessagesView({super.key});

  @override
  State<ListNewMessagesView> createState() => _ListNewMessagesViewState();
}

class _ListNewMessagesViewState extends State<ListNewMessagesView> {
  late List<PhoneBookStudent> _chatRooms;
  var search = '';
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MessageBloc, MessageState>(
      builder: (context, state) {
        final isLoading = state.messageStatus == MessageStatus.loading;
        final phoneBookStudent = state.phoneBookStudent;
        _chatRooms = phoneBookStudent;
        final filteredChatRooms = _chatRooms.where((chatRoom) {
          final searchText = search.toLowerCase();
          return chatRoom.fullName.toLowerCase().contains(searchText);
        }).toList();
        return Scaffold(
          body: BackGroundContainer(
              child: GestureDetector(
                  onTap: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                  child: Column(
                    children: [
                      ScreenAppBar(
                        title: 'Tin nhắn nội bộ',
                        canGoback: true,
                        onBack: () {
                          context.pop();
                        },
                      ),
                      Expanded(
                        child: AppSkeleton(
                          isLoading: isLoading,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 24, horizontal: 16),
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                top: 5,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10, bottom: 4),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            context.pop();
                                          },
                                          child: Text(
                                            'Huỷ',
                                            style: AppTextStyles.normal16(
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        Text(
                                          'Tin nhắn mới',
                                          style: AppTextStyles.normal16(
                                              fontWeight: FontWeight.w500),
                                        ),
                                        GestureDetector(
                                          onTap: () {},
                                          child: Text(
                                            'Huỷ',
                                            style: AppTextStyles.normal16(
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8, left: 10, right: 10),
                                    child: SizedBox(
                                      height: 55,
                                      child: TextField(
                                        onChanged: (value) {
                                          setState(() {
                                            search = value;
                                          });
                                        },
                                        decoration: InputDecoration(
                                            filled: true,
                                            fillColor: AppColors.skyLighter,
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide.none,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            hintText: 'Đến:'),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15),
                                    child: Text('Gợi ý',
                                        style: AppTextStyles.normal16(
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.gray600)),
                                  ),
                                  Expanded(
                                      child: ListView.builder(
                                          padding: EdgeInsets.zero,
                                          itemCount: filteredChatRooms.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            final newMessage =
                                                filteredChatRooms[index];
                                            return ChatRoomItem(
                                              onTap: () {
                                                mainNavKey.currentContext!
                                                    .pushNamed(
                                                  routeName:
                                                      ChatRoomScreen.routeName,
                                                  arguments: {
                                                    'message': const Message(),
                                                    'phoneBookStudent':
                                                        newMessage,
                                                  },
                                                );
                                              },
                                              newMessages: newMessage,
                                            );
                                          }))
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ))),
        );
      },
    );
  }
}
