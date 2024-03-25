import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iportal2/app_config/router_configuration.dart';
import 'package:iportal2/components/app_bar/app_bar.dart';
import 'package:iportal2/components/back_ground_container.dart';
import 'package:iportal2/components/buttons/buttons.dart';
import 'package:iportal2/screens/leave/widget/time_select_box.dart';
import 'package:iportal2/resources/assets.gen.dart';
import 'package:iportal2/resources/resources.dart';

class LeaveApplicationScreen extends StatelessWidget {
  const LeaveApplicationScreen({super.key});

  static const routeName = '/leave-application';

  @override
  Widget build(BuildContext context) {
    return const LeaveApplicationView();
  }
}

class LeaveApplicationView extends StatefulWidget {
  const LeaveApplicationView({super.key});

  @override
  State<LeaveApplicationView> createState() => LeaveApplicationViewState();
}

class LeaveApplicationViewState extends State<LeaveApplicationView> {
  bool isFullDay = true;
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  late int numsOfDaysOff;
  TimeOfDay? selectedStartTime;
  TimeOfDay? selectedEndTime;

  @override
  void initState() {
    super.initState();
    numsOfDaysOff = endDate.difference(startDate).inDays + 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: BackGroundContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ScreenAppBar(
                title: 'Xin nghỉ phép',
                canGoback: true,
                onBack: () {
                  context.pop();
                },
              ),
              Flexible(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
                  decoration: const BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 20,
                                      height: 20,
                                      decoration: BoxDecoration(
                                        color: AppColors.brand50,
                                        border: Border.all(
                                            color: AppColors.brand600),
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(6),
                                        ),
                                      ),
                                      child: Checkbox(
                                        value: isFullDay,
                                        onChanged: (bool? value) => setState(
                                          () => isFullDay = value!,
                                        ),
                                        activeColor: Colors.transparent,
                                        checkColor: AppColors.brand600,
                                        side: BorderSide.none,
                                        shape: const RoundedRectangleBorder(),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Text(
                                      'Nghỉ cả ngày',
                                      style: AppTextStyles.custom(
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.brand600,
                                        fontSize: 16,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              TimeSelectBox(
                                helpText: 'Chọn ngày bắt đầu',
                                title: 'Từ',
                                date: DateTime.now().add(Duration(days: 1)),
                                time: TimeOfDay(hour: 0, minute: 0),
                                canSelectTime: !isFullDay,
                              ),
                              const SizedBox(height: 16),
                              TimeSelectBox(
                                helpText: 'Chọn ngày kết thúc',
                                title: 'Đến',
                                date: DateTime.now().add(Duration(days: 1)),
                                time: TimeOfDay(hour: 23, minute: 59),
                                canSelectTime: !isFullDay,
                              ),
                              Text(
                                'Lý do nghỉ',
                                style: AppTextStyles.custom(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.textNormalColor,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 6),
                                child: TextField(
                                  maxLines: 5,
                                  minLines: 3,
                                  style: AppTextStyles.normal16(),
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 14),
                                    hintText: "Nhập lý do nghỉ...",
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: AppColors.gray300,
                                      ),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: AppColors.gray400,
                                      ),
                                    ),
                                    hintStyle: AppTextStyles.normal16(
                                        color: AppColors.gray500),
                                    border: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: AppColors.gray300,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 6),
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: AppColors.blueGray50,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Giáo viên duyệt',
                                              style: AppTextStyles.semiBold14(
                                                color: AppColors.gray600,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 8),
                                              child: Text(
                                                'GV: Nguyễn Minh Nhi',
                                                style: AppTextStyles.normal12(
                                                  color: AppColors.gray600,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      GestureDetector(
                                        child: Container(
                                          padding: const EdgeInsets.all(8),
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: AppColors.brand600,
                                          ),
                                          child: const Icon(
                                            Icons.phone_in_talk,
                                            color: AppColors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: RoundedButton(
                          onTap: () {
                            //TODO: Implement submit Leave application function
                          },
                          borderRadius: 70,
                          buttonColor: AppColors.primaryRedColor,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 10,
                          ),
                          child: Text(
                            'Gửi',
                            style: AppTextStyles.semiBold16(
                                color: AppColors.white),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
