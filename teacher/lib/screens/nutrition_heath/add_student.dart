import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:repository/repository.dart';
import 'package:teacher/app_config/router_configuration.dart';
import 'package:teacher/common_bloc/current_user/current_user_bloc.dart';
import 'package:teacher/components/app_bar/app_bar.dart';
import 'package:teacher/components/back_ground_container.dart';
import 'package:teacher/screens/authentication/utilites/dialog_utils.dart';
import 'package:teacher/screens/nutrition_heath/bloc/nutrition_bloc.dart';
import 'package:teacher/screens/nutrition_heath/widget/select_date.dart';

class AddStudentNutritionScreen extends StatelessWidget {
  const AddStudentNutritionScreen({
    super.key,
    required this.phoneBookStudent,
  });
  final List<PhoneBookStudent> phoneBookStudent;
  @override
  Widget build(BuildContext context) {
    final nutritionBloc = NutritionBloc(
      userRepository: context.read<UserRepository>(),
      appFetchApiRepo: context.read<AppFetchApiRepository>(),
      currentUserBloc: context.read<CurrentUserBloc>(),
    );
    return BlocProvider.value(
        value: nutritionBloc,
        child: BlocListener<NutritionBloc, NutritionState>(
          listener: (context, state) {
            if (state.nutritionStatus == NutritionStatus.loadingPostUpdate) {
              LoadingDialog.show(context);
            } else if (state.nutritionStatus ==
                NutritionStatus.successPostUpdate) {
              LoadingDialog.hide(context);
              context.pop();
            } else if (state.nutritionStatus == NutritionStatus.failPost) {
              LoadingDialog.hide(context);
              Fluttertoast.showToast(
                  msg: state.statusNote,
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  backgroundColor: AppColors.black,
                  textColor: AppColors.white);
            }
          },
          child: AddStudentNutrition(
            phoneBookStudent: phoneBookStudent,
          ),
        ));
  }
}

class AddStudentNutrition extends StatelessWidget {
  const AddStudentNutrition({
    super.key,
    required this.phoneBookStudent,
  });
  final List<PhoneBookStudent> phoneBookStudent;

  @override
  Widget build(BuildContext context) {
    int? pupilId;
    TextEditingController heightController = TextEditingController();
    TextEditingController weightController = TextEditingController();
    TextEditingController bmiController = TextEditingController();
    TextEditingController noteController = TextEditingController();
    DateTime date = DateTime.now();
    return BackGroundContainer(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Column(
          children: [
            ScreenAppBar(
              title: 'Sức khoẻ dinh dưỡng',
              canGoback: true,
              onBack: () {
                context.pop();
              },
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12),
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Học sinh',
                        style: AppTextStyles.normal14(
                          color: AppColors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 6, bottom: 18),
                        child: DropdownButtonComponent(
                          optionList: phoneBookStudent,
                          hint: 'Chọn học sinh',
                          onUpdateOption: (PhoneBookStudent student) {
                            pupilId = student.pupilId;
                          },
                        ),
                      ),
                      Text(
                        'Tháng/Năm',
                        style: AppTextStyles.normal14(
                          color: AppColors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 6, bottom: 18),
                        child: SelectDateNutrition(
                          onDatePicked: (value) {
                            date = value;
                          },
                        ),
                      ),
                      Text(
                        'Chiều cao',
                        style: AppTextStyles.normal14(
                          color: AppColors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: TitleAndInputText(
                          textInputType: false,
                          hintText: 'Nhập thông tin',
                          onChanged: (value) {
                            heightController.text = value;
                          },
                        ),
                      ),
                      Text(
                        'Cân nặng',
                        style: AppTextStyles.normal14(
                          color: AppColors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: TitleAndInputText(
                          textInputType: false,
                          hintText: 'Nhập thông tin',
                          onChanged: (value) {
                            weightController.text = value;
                          },
                        ),
                      ),
                      // Text(
                      //   'BMI',
                      //   style: AppTextStyles.normal14(
                      //     color: AppColors.black,
                      //     fontWeight: FontWeight.w600,
                      //   ),
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(vertical: 10),
                      //   child: TitleAndInputText(
                      //     hintText: 'Nhập thông tin',
                      //     onChanged: (value) {
                      //       bmiController.text = value;
                      //     },
                      //   ),
                      // ),
                      // Text(
                      //   'Ghi chú',
                      //   style: AppTextStyles.normal14(
                      //     color: AppColors.black,
                      //     fontWeight: FontWeight.w600,
                      //   ),
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(vertical: 10),
                      //   child: Container(
                      //     decoration: BoxDecoration(
                      //         borderRadius: BorderRadius.circular(10),
                      //         border: Border.all(
                      //             width: 1, color: AppColors.gray300)),
                      //     child: TextField(
                      //       decoration: const InputDecoration(
                      //           contentPadding: EdgeInsets.all(8),
                      //           border: InputBorder.none,
                      //           labelText: 'Nhập thông tin'),
                      //       maxLines: null,
                      //       onChanged: (value) {
                      //         noteController.text = value;
                      //       },
                      //     ),
                      //   ),
                      // ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (pupilId != null) {
                              if (heightController.text != '' &&
                                  weightController.text != '') {
                                context.read<NutritionBloc>().add(
                                      PostNutritionUpdate(
                                        bmi: 0.0,
                                        height: heightController.text,
                                        weight: weightController.text,
                                        learnYear: date,
                                        txtMonth: int.parse(
                                            DateFormat('M').format(date)),
                                        pupilId: pupilId ?? 0,
                                        distribute: 'kkkk',
                                        typeHeight: 'm',
                                      ),
                                    );
                              } else {
                                Fluttertoast.showToast(
                                    msg: "Vui lòng điền đủ thông tin",
                                    toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.BOTTOM,
                                    backgroundColor: AppColors.black,
                                    textColor: AppColors.white);
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(6),
                            backgroundColor: const Color(0xFF9C292E),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 5, bottom: 5),
                            child: Text(
                              'Lưu',
                              style:
                                  AppTextStyles.semiBold14(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DropdownButtonComponent extends StatefulWidget {
  final List<PhoneBookStudent> optionList;
  final String hint;
  final ValueChanged<PhoneBookStudent> onUpdateOption;

  const DropdownButtonComponent({
    Key? key,
    required this.optionList,
    required this.hint,
    required this.onUpdateOption,
  }) : super(key: key);

  @override
  _DropdownButtonComponentState createState() =>
      _DropdownButtonComponentState();
}

class _DropdownButtonComponentState extends State<DropdownButtonComponent> {
  PhoneBookStudent? selectedStudent;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.gray300), // Add border if needed
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<PhoneBookStudent>(
          isExpanded: true,
          hint: Text(widget.hint),
          value: selectedStudent,
          onChanged: (PhoneBookStudent? newValue) {
            setState(() {
              selectedStudent = newValue!;
            });
            widget.onUpdateOption(newValue!);
          },
          items: widget.optionList.map<DropdownMenuItem<PhoneBookStudent>>(
              (PhoneBookStudent student) {
            return DropdownMenuItem<PhoneBookStudent>(
              value: student,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Text(student.fullName),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
