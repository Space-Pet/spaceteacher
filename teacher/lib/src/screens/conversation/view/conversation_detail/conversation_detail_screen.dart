import 'package:core/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:teacher/components/app_bar/screen_app_bar.dart';
import 'package:teacher/components/back_ground_container.dart';

import 'package:teacher/resources/assets.gen.dart';
import 'package:teacher/src/screens/conversation/mockdata/mock_data_message.dart';
import 'package:teacher/src/screens/conversation/view/conversation_detail/widget/card_message_detail.dart';

import 'package:core/presentation/extentions/extension_context.dart';

class ConversationDetailScreen extends StatefulWidget {
  static const String routeName = '/conversation_detail';
  const ConversationDetailScreen(
      {super.key, required this.conversationId, required this.fullName});
  final int conversationId;
  final String fullName;
  @override
  State<ConversationDetailScreen> createState() =>
      _ConversationDetailScreenState();
}

class _ConversationDetailScreenState extends State<ConversationDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackGroundContainer(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Positioned.fill(
              top: -20,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 8, 8, 0),
                child: ScreensAppBar(
                  widget.fullName,
                  canGoBack: true,
                  onBack: () {
                    context.pop();
                  },
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 100),
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
              width: double.infinity,
              decoration: const BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  final message = mockDataMessage[index];

                  return CardMessageDetail(
                    messageDetailModel: message,
                  );
                },
                itemCount: mockDataMessage.length,
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: MediaQuery.of(context).viewInsets.bottom,
              child: Container(
                color: AppColors.primarySurface,
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: IconButton(
                        onPressed: () {},
                        icon: Assets.icons.paperclip.svg(),
                      ),
                    ),
                    Expanded(
                      flex: 8,
                      child: TextField(
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(10),
                          hintText: 'Nhập tin nhắn',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none,
                          ),
                          fillColor: AppColors.white,
                          filled: true,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: IconButton(
                        onPressed: () {},
                        icon: Assets.icons.send.svg(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}
