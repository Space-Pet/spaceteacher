import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:teacher/components/app_bar/app_bar.dart';
import 'package:teacher/components/back_ground_container.dart';
import 'package:teacher/components/dialog/dilaog_yes_no.dart';
import 'package:core/resources/resources.dart';
import 'package:teacher/src/screens/observation_schedule/mock_data/subject_mock.dart';
import 'package:teacher/src/screens/observation_schedule/screen/create_observation/widget/card_info_add_observation.dart';
import 'package:teacher/src/screens/observation_schedule/widgets/select_field.dart';
import 'package:core/presentation/extentions/extension_context.dart';

class CreateObservationScreen extends StatefulWidget {
  static const routeName = '/create_observation';
  const CreateObservationScreen({super.key});

  @override
  State<CreateObservationScreen> createState() =>
      _CreateObservationScreenState();
}

class _CreateObservationScreenState extends State<CreateObservationScreen> {
  final TextEditingController _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (event) {
        final currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus && currentFocus.hasFocus) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: BackGroundContainer(
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: ScreenAppBar(
                  title: 'Đăng ký dự giờ',
                  canGoback: true,
                  onBack: () {
                    context.pop();
                  },
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
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Thời gian',
                      style: AppTextStyles.bold16(
                          color: AppColors.blueForgorPassword),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SelectDate(
                      isHideIcon: true,
                      onDateChanged: (date) {},
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SelectFiledRadio(
                        onValueChanged: (value) {},
                        data: mockSubjectData,
                        hintText: 'Môn'),
                    const SizedBox(
                      height: 10,
                    ),
                    SelectFiledRadio(
                        onValueChanged: (value) {},
                        data: mockClassData,
                        hintText: 'Lớp'),
                    const SizedBox(
                      height: 10,
                    ),
                    SelectFiledRadio(
                        onValueChanged: (value) {},
                        data: mockTietData,
                        hintText: 'Tiết'),

                    const SizedBox(
                      height: 10,
                    ),
                    // Thong tin du gio
                    Text(
                      'Thông tin dự giờ',
                      style: AppTextStyles.bold16(
                          color: AppColors.blueForgorPassword),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.15,
                      width: double.infinity,
                      child: TextField(
                        controller: _contentController,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(10.0),
                          isDense: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                const BorderSide(color: AppColors.blueGray100),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                const BorderSide(color: AppColors.blueGray100),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                const BorderSide(color: AppColors.blueGray100),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                const BorderSide(color: AppColors.blueGray100),
                          ),
                          fillColor: AppColors.gray400,
                          hintText: 'Nội dung dự giờ',
                          hintStyle: AppTextStyles.semiBold14(
                            color: AppColors.gray400,
                          ),
                        ),
                        maxLines: null,
                        expands: true,
                        textAlign: TextAlign.start,
                        textAlignVertical: TextAlignVertical.top,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    // Giao vien tham gia
                    Text(
                      'Giáo viên tham gia',
                      style: AppTextStyles.bold16(
                          color: AppColors.blueForgorPassword),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    DottedBorder(
                      padding: const EdgeInsets.all(15.0),
                      color: AppColors.blueGray300,
                      borderType: BorderType.RRect,
                      dashPattern: const [6, 7],
                      radius: const Radius.circular(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: AppColors.blueForgorPassword,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: const Icon(
                              Icons.add,
                              color: AppColors.white,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Thêm người tham gia',
                            style:
                                AppTextStyles.bold16(color: AppColors.gray400),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.only(bottom: 50),
                        itemBuilder: (ctx, index) {
                          final it = mockTeacherInfoData[index];
                          return CardInfoAddObservation(
                            teacherInfo: it,
                          );
                        },
                        itemCount: mockTeacherInfoData.length,
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  color: Colors.transparent,
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (ctx) {
                              return DialogYesNo(
                                title: 'Mở lớp dự giờ thành công',
                                content: 'Giáo viên Anh Văn - Nguyễn Tấn Lộc',
                                typeDialog: 1,
                                onYes: () {
                                  context.pop();
                                },
                              );
                            });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.observationStatusMyObsBG,
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.add_circle_outline,
                            color: AppColors.white,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'Đăng ký dự giờ',
                            style: AppTextStyles.bold16(color: AppColors.white),
                          ),
                        ],
                      )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
