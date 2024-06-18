import 'package:core/core.dart';
import 'package:core/resources/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:repository/repository.dart';
import 'package:teacher/app_config/router_configuration.dart';
import 'package:teacher/common_bloc/current_user/current_user_bloc.dart';
import 'package:teacher/components/app_bar/app_bar.dart';
import 'package:teacher/components/back_ground_container.dart';
import 'package:teacher/components/tab/tab_content.dart';
import 'package:teacher/screens/authentication/utilites/dialog_utils.dart';
import 'package:teacher/screens/nutrition_heath/bloc/nutrition_bloc.dart';

class EditNutritionScreen extends StatelessWidget {
  const EditNutritionScreen({
    required this.phoneBookStudent,
    required this.date,
  });
  final PhoneBookStudent phoneBookStudent;
  final DateTime date;

  @override
  Widget build(BuildContext context) {
    final nutritionBloc = NutritionBloc(
      userRepository: context.read<UserRepository>(),
      appFetchApiRepo: context.read<AppFetchApiRepository>(),
      currentUserBloc: context.read<CurrentUserBloc>(),
    );
    nutritionBloc.add(GetNutrition(
      userKey: phoneBookStudent.userKey,
      date: date,
    ));
    return BlocProvider.value(
      value: nutritionBloc,
      child: BlocListener<NutritionBloc, NutritionState>(
        listener: (context, state) {
          if (state.nutritionStatus == NutritionStatus.loadingPostUpdate) {
            LoadingDialog.show(context);
          } else if (state.nutritionStatus ==
              NutritionStatus.successPostUpdate) {
            LoadingDialog.hide(context);
            nutritionBloc.add(GetNutrition(
              userKey: phoneBookStudent.userKey,
              date: date,
            ));
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
        child: EditNutritionView(
          phoneBookStudent: phoneBookStudent,
          date: date,
        ),
      ),
    );
  }
}

class EditNutritionView extends StatefulWidget {
  EditNutritionView({
    super.key,
    required this.phoneBookStudent,
    required this.date,
  });
  final PhoneBookStudent phoneBookStudent;
  final DateTime date;
  @override
  State<EditNutritionView> createState() => _EditNutritionViewState();
}

class _EditNutritionViewState extends State<EditNutritionView> {
  bool edit = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NutritionBloc, NutritionState>(
        builder: (context, state) {
      final nutrition = state.nutrition;
      return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: BackGroundContainer(
          child: Column(
            children: [
              ScreenAppBar(
                title: 'Sức khoẻ dinh dưỡng',
                canGoback: true,
                onBack: () {
                  context.pop();
                },
                iconRight: Assets.icons.editProfile,
                onRight: () {
                  setState(() {
                    edit = true;
                  });
                  print('object: $edit');
                },
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(top: 18),
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: AppSkeleton(
                    isLoading: state.nutritionStatus ==
                        NutritionStatus.loadingGetNutrition,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          if (edit == false)
                            NutritionDetailsView(
                              phoneBookStudent: widget.phoneBookStudent,
                              nutrition: nutrition,
                            ),
                          if (edit == true)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                NutritionEditView(
                                  date: widget.date,
                                  phoneBookStudent: widget.phoneBookStudent,
                                  nutrition: nutrition,
                                  onSave: () {
                                    setState(() {
                                      edit = false;
                                    });
                                  },
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

class NutritionDetailsView extends StatelessWidget {
  const NutritionDetailsView({
    Key? key,
    required this.phoneBookStudent,
    required this.nutrition,
  }) : super(key: key);

  final PhoneBookStudent phoneBookStudent;
  final DataNutrition? nutrition;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RowContent(
          title: 'Học sinh',
          formSize: 16,
          content: phoneBookStudent.fullName,
        ),
        RowContent(
          title: 'Tháng/Năm',
          formSize: 16,
          content: nutrition?.month ?? '__',
        ),
        RowContent(
          title: 'Chiều cao',
          formSize: 16,
          content: nutrition?.height ?? '__',
        ),
        RowContent(
          title: 'Cân nặng',
          formSize: 16,
          content: nutrition?.weight ?? '__',
        ),
        RowContent(
          title: 'BMI',
          formSize: 16,
          content: nutrition?.bmi.toString() ?? '__',
        ),
        RowContent(
          title: 'Ghi chú',
          formSize: 16,
          content: nutrition?.ketLuan ?? '__',
        ),
      ],
    );
  }
}

class NutritionEditView extends StatelessWidget {
  const NutritionEditView({
    required this.onSave,
    required this.nutrition,
    required this.phoneBookStudent,
    required this.date,
    Key? key,
  }) : super(key: key);
  final DateTime date;
  final VoidCallback onSave;
  final PhoneBookStudent phoneBookStudent;
  final DataNutrition? nutrition;

  @override
  Widget build(BuildContext context) {
    TextEditingController heightController =
        TextEditingController(text: nutrition?.height ?? '');
    TextEditingController weightController =
        TextEditingController(text: nutrition?.weight ?? '');
    TextEditingController bmiController =
        TextEditingController(text: nutrition?.bmi.toString() ?? '');
    TextEditingController noteController =
        TextEditingController(text: nutrition?.ketLuan ?? '');

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RowContent(
            title: 'Học sinh',
            formSize: 16,
            content:
                '${phoneBookStudent.fullName} - ${phoneBookStudent.pupilId}',
          ),
          RowContent(
            title: 'Tháng/Năm',
            formSize: 16,
            content: nutrition?.month ?? '', // Example date format
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                    controller: heightController,
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
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: TitleAndInputText(
                    controller: weightController,
                    hintText: 'Nhập thông tin',
                    onChanged: (value) {
                      weightController.text = value;
                    },
                  ),
                ),
              ],
            ),
          ),
          RowContent(
            title: 'BMI',
            formSize: 16,
            content: nutrition?.bmi.toString() ?? '', // Example date format
          ),
          RowContent(
            title: 'Ghi chú',
            formSize: 16,
            content: nutrition?.ketLuan ?? '', // Example date format
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.symmetric(vertical: 12),
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Dispatch the PostNutritionUpdate event here
                  final nutritionBloc = context.read<NutritionBloc>();
                  nutritionBloc.add(PostNutritionUpdate(
                    pupilId: phoneBookStudent.pupilId,
                    learnYear: date,
                    txtMonth: int.parse(DateFormat('M').format(date)),
                    typeHeight: 'm',
                    weight: weightController.text,
                    height: heightController.text,
                    bmi: 0.0,
                    distribute: noteController.text,
                  ));
                  onSave();
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(6),
                  backgroundColor: const Color(0xFF9C292E),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 5, bottom: 5),
                  child: Text(
                    'Lưu',
                    style: AppTextStyles.semiBold14(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TitleAndInputText extends StatelessWidget {
  const TitleAndInputText({
    Key? key,
    required this.hintText,
    this.initialValue,
    required this.onChanged,
    required this.controller,
  }) : super(key: key);

  final String hintText;
  final String? initialValue;
  final ValueChanged<String> onChanged;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      onChanged: onChanged,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
      ],
    );
  }
}
