import 'package:flutter/material.dart';
import 'package:teacher/app_config/router_configuration.dart';
import 'package:teacher/components/app_bar/app_bar.dart';
import 'package:teacher/components/back_ground_container.dart';
import 'package:core/resources/resources.dart';

class RespondCommentScreen extends StatefulWidget {
  const RespondCommentScreen({super.key});

  @override
  State<RespondCommentScreen> createState() => _RespondCommentScreenState();
}

class _RespondCommentScreenState extends State<RespondCommentScreen> {
  @override
  Widget build(BuildContext context) {
    return BackGroundContainer(
        child: GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Column(
        children: [
          ScreenAppBar(
            canGoback: true,
            onBack: () {
              context.pop();
            },
            title: 'Phản hồi ý kiến',
          ),
          Flexible(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 40, left: 16, right: 16),
                    child: TextFieldWidget(
                        hintText: 'Họ và tên', title: 'Tên cha/mẹ học sinh'),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 20, left: 16, right: 16),
                    child: TextFieldWidget(hintText: 'Email', title: 'Email'),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 20, left: 16, right: 16),
                    child: TextFieldWidget(
                        hintText: 'Số điện thoại', title: 'Số điện thoại'),
                  ),
                  Expanded(
                    child: Padding(
                        padding:
                            const EdgeInsets.only(top: 20, left: 16, right: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Phản hồi',
                              style: AppTextStyles.normal16(
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: 200, // Độ cao mong muốn
                              child: TextField(
                                onChanged: (value) {
                                  setState(() {});
                                },
                                maxLines: null,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(8),
                                  filled: true,
                                  fillColor: AppColors.white,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: AppColors.gray300,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  hintText: 'Nhập nội dung phản hồi',
                                ),
                              ),
                            ),
                          ],
                        )),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}

class TextFieldWidget extends StatefulWidget {
  const TextFieldWidget(
      {super.key, required this.hintText, required this.title});
  final String title;
  final String hintText;
  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: AppTextStyles.normal16(fontWeight: FontWeight.w600),
        ),
        TextField(
          onChanged: (value) {
            setState(() {});
          },
          maxLines: null,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(8),
            filled: true,
            fillColor: AppColors.white,
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: AppColors.gray300,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10),
            ),
            hintText: widget.hintText,
          ),
        ),
      ],
    );
  }
}
