import 'package:flutter/material.dart';
import 'package:iportal2/app_config/router_configuration.dart';
import 'package:iportal2/components/back_ground_container.dart';
import 'package:iportal2/resources/app_colors.dart';
import 'package:iportal2/resources/app_text_styles.dart';
import 'package:iportal2/screens/message/conponents/card_messages.dart';
import 'package:iportal2/screens/message/models/new_message.dart';

class ListNewMessagesScreen extends StatelessWidget {
  const ListNewMessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BackGroundContainer(
        child: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: SafeArea(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        padding:
                            const EdgeInsets.only(top: 8, left: 10, right: 10),
                        child: SizedBox(
                          height: 55,
                          child: TextField(
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: AppColors.skyLighter,
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(10)),
                                hintText: 'Đến:'),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Text('Gợi ý',
                            style: AppTextStyles.normal16(
                                fontWeight: FontWeight.w600,
                                color: AppColors.gray600)),
                      ),
                      Expanded(
                          child: ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: newMessages.length,
                              itemBuilder: (BuildContext context, int index) {
                                final newMessage = newMessages[index];
                                return ChatRoomItem(
                                    onTap: () {}, newMessages: newMessage);
                              }))
                    ],
                  ),
                ),
              ),
            )));
  }
}
