import 'package:core/core.dart';
import 'package:core/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:teacher/components/app_bar/screen_app_bar.dart';

import 'package:teacher/components/back_ground_container.dart';
import 'package:teacher/model/message_model.dart';
import 'package:teacher/repository/conversation_repository/conversation_repositories.dart';
import 'package:teacher/resources/assets.gen.dart';
import 'package:teacher/src/screens/conversation/bloc/conversation_bloc.dart';
import 'package:teacher/src/screens/conversation/widget/w_card_message.dart';
import 'package:teacher/src/utils/extension_context.dart';

class ConversationScreen extends StatefulWidget {
  static const String routeName = '/message';
  const ConversationScreen({super.key});

  @override
  State<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  final _bloc = ConversationBloc(
      conversationRepository: Injection.get<ConversationRepository>());

  @override
  void initState() {
    _bloc.add(const GetConversation(userId: 10118527, classId: 1));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConversationBloc, ConversationState>(
      bloc: _bloc,
      builder: (context, state) {
        final it = state.conversation?.messages;

        if (state.status == ConversationStatus.loading) {
          return const Scaffold(
            body: BackGroundContainer(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }
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
                      'Tin nhắn',
                      canGoBack: true,
                      onBack: () {
                        context.pop();
                      },
                      actionWidget: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.add_circle_outline,
                              color: AppColors.white)),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 100),
                  padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                  decoration: const BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // seach bar & filter button
                      Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 09,
                          child: TextField(
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(5),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    const BorderSide(color: AppColors.gray400),
                              ),
                              fillColor: AppColors.gray400,
                              hintText: 'Tìm kiếm',
                              prefixIcon: Image.asset(
                                Assets.images.search.path,
                                color: AppColors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      Expanded(
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          itemBuilder: (ctx, index) {
                            return GestureDetector(
                              onTap: () {
                                Fluttertoast.showToast(
                                    msg: '${it?[index].fullName}',
                                    gravity: ToastGravity.BOTTOM);
                              },
                              child: CardMessage(
                                message: it?[index] ?? MessageModel(),
                              ),
                            );
                          },
                          itemCount: it?.length,
                        ),
                      ),
                    ],
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
