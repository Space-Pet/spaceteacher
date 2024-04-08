import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iportal2/app_config/router_configuration.dart';
import 'package:iportal2/components/app_bar/app_bar.dart';
import 'package:iportal2/components/back_ground_container.dart';
import 'package:iportal2/resources/resources.dart';
import 'package:iportal2/screens/home/models/lesson_model.dart';
import 'package:url_launcher/url_launcher.dart';

class ExerciseDetail extends StatefulWidget {
  const ExerciseDetail({
    super.key,
    required this.exerciseItem,
  });
  final ExerciseModel exerciseItem;
  static const routeName = '/exercise-detail';
  @override
  State<ExerciseDetail> createState() => ExerciseDetailState();
}

class ExerciseDetailState extends State<ExerciseDetail> {
  @override
  Widget build(BuildContext context) {
    return BackGroundContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ScreenAppBar(
                title: 'Sổ báo bài',
                canGoback: true,
                onBack: () {
                  context.pop();
                },
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 16, 12),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: const BoxDecoration(
                    color: AppColors.blueGray100,
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: Text(
                    widget.exerciseItem.subjectname,
                    style: AppTextStyles.normal12(color: AppColors.brand600),
                  ),
                ),
              )
            ],
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: AppRadius.roundedTop28,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${widget.exerciseItem.name} ",
                      style:
                          AppTextStyles.semiBold16(color: AppColors.brand600),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.blueGray,
                        borderRadius: AppRadius.rounded10,
                      ),
                      child: Text(
                        widget.exerciseItem.description,
                        style: AppTextStyles.normal12(color: AppColors.gray600),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    if (widget.exerciseItem.fileUrl.isNotEmpty)
                      GestureDetector(
                        onTap: () async {
                          launchUrl(
                            Uri.parse(widget.exerciseItem.fileUrl),
                            mode: LaunchMode.inAppBrowserView,
                          );
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: AppColors.blueGray,
                            borderRadius: AppRadius.rounded10,
                          ),
                          child: Row(
                            children: [
                              SvgPicture.asset('assets/icons/paperclip.svg'),
                              const SizedBox(width: 4),
                              Text(
                                'Baitap.docx',
                                style: AppTextStyles.normal12(
                                    color: AppColors.brand600),
                              ),
                            ],
                          ),
                        ),
                      ),
                    if (widget.exerciseItem.fileUrl.isNotEmpty)
                      const SizedBox(
                        height: 8,
                      ),
                    Text(
                      'C2. (tr42) Dùng từ thích hợp trong khung để điền vào chỗ trống:',
                      style:
                          AppTextStyles.semiBold14(color: AppColors.brand600),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      'Kéo vật lên theo phương thẳng đứng cần phải dùng một lực ít nhất ........ bằng trọng lượng của vật.',
                      style: AppTextStyles.normal14(color: AppColors.brand600),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      'C3. (tr.43) Những khó khăn trong cách kéo này:',
                      style:
                          AppTextStyles.semiBold14(color: AppColors.brand600),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      'Kéo vật lên theo phương thẳng đứng cần phải dùng một lực ít nhất ........ bằng trọng lượng của vật.',
                      style: AppTextStyles.normal14(color: AppColors.brand600),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
