import 'package:flutter/material.dart';
import 'package:iportal2/app_config/router_configuration.dart';
import 'package:iportal2/components/app_bar/app_bar.dart';
import 'package:iportal2/components/back_ground_container.dart';
import 'package:iportal2/resources/app_colors.dart';
import 'package:iportal2/resources/assets.gen.dart';
import 'package:iportal2/screens/message/list_new_messages.dart';
import 'package:iportal2/screens/message/models/message.dart';
import 'package:iportal2/screens/message/widgets/list_message.dart';
import 'package:iportal2/components/textfield/input_text.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  late List<MessageChatRoom> _filteredChatRooms;
  final search = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredChatRooms = chatRooms;
  }

  @override
  Widget build(BuildContext context) {
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
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: TitleAndInputText(
                        obscureText: true,
                        hintText: 'Tìm kiếm',
                        onChanged: (value) {
                          search.text = value;
                          searchChatRooms(value);
                        },
                        prefixIcon: Assets.images.search.image(),
                      ),
                    ),
                    if (_filteredChatRooms.isNotEmpty)
                      ListMessage(chatRooms: _filteredChatRooms)
                    else
                      _buildEmptyState(search.text),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void searchChatRooms(String searchText) {
    setState(() {
      _filteredChatRooms = chatRooms.where((chatRoom) {
        return chatRoom.name.toLowerCase().contains(searchText.toLowerCase());
      }).toList();
    });
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
