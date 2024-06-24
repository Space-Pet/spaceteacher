import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:repository/repository.dart';
import 'package:teacher/app_config/router_configuration.dart';
import 'package:teacher/common_bloc/current_user/current_user_bloc.dart';
import 'package:teacher/components/app_bar/app_bar.dart';
import 'package:teacher/components/back_ground_container.dart';
import 'package:teacher/components/select_date.dart';
import 'package:teacher/resources/assets.gen.dart';
import 'package:teacher/screens/register_notebook/bloc/register_notebook_bloc.dart';
import 'package:teacher/screens/register_notebook/screate_register_book/widgets/dropdow_register.dart';
import 'package:teacher/screens/register_notebook/screate_register_book/widgets/input_register.dart';

class CreateRegisterBookScreen extends StatelessWidget {
  const CreateRegisterBookScreen({
    super.key,
    required this.lessonDataItem,
  });
  final LessonDataItem lessonDataItem;
  @override
  Widget build(BuildContext context) {
    final registerBloc = RegisterNotebookBloc(
      appFetchApiRepo: context.read<AppFetchApiRepository>(),
      currentUserBloc: context.read<CurrentUserBloc>(),
    );
    registerBloc.add(GetViolationData(
      classId: lessonDataItem.classId ?? '',
      userKey: context.read<CurrentUserBloc>().state.user.user_key,
    ));
    registerBloc.add(GetListViolation());
    return BlocProvider.value(
      value: registerBloc,
      child: ScreateRegisterBookView(
        lessonDataItem: lessonDataItem,
      ),
    );
  }
}

class ScreateRegisterBookView extends StatefulWidget {
  const ScreateRegisterBookView({
    super.key,
    required this.lessonDataItem,
  });
  final LessonDataItem lessonDataItem;

  @override
  _ScreateRegisterBookViewState createState() =>
      _ScreateRegisterBookViewState();
}

class _ScreateRegisterBookViewState extends State<ScreateRegisterBookView> {
  List<Widget> containers = [];
  String? lessionTitle;
  String? lessionNote;
  String? lessionRank;
  String? homeWork;
  String? tietPpct;
  String? dateline;

  void _addContainer(
    ViolationData? violationData,
    List<ListViolation>? listViolation,
  ) {
    setState(() {
      containers.add(
        Container(
          width: double.infinity,
          padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: AppColors.gray100,
          ),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: RawMaterialButton(
                  onPressed: () {
                    setState(() {
                      containers.removeLast();
                    });
                  },
                  fillColor: AppColors.brand500,
                  constraints: const BoxConstraints(
                    maxHeight: 30,
                  ),
                  padding: EdgeInsets.zero,
                  shape: const CircleBorder(),
                  child: const Icon(
                    Icons.remove,
                    size: 20.0,
                    color: AppColors.white,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 18),
                child: DropdownButtonRegister(
                  pupilInfo: violationData?.pupils,
                  hint: ' Chọn học sinh',
                  onUpdateOption: (PupilInfo student) {},
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: DropdownButtonRegister(
                  listViolation: listViolation,
                  hint: ' Lỗi vi phạm',
                  onUpdateViolation: (ListViolation student) {},
                ),
              ),
              InputRegister(
                note: (value) {},
                labalText: 'Ghi chú',
              ),
            ],
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterNotebookBloc, RegisterNotebookState>(
        builder: (context, state) {
      final violation = state.violationData;
      final listViolation = state.listViolation;
      return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: BackGroundContainer(
          child: Column(
            children: [
              ScreenAppBar(
                canGoback: true,
                title: 'Phê sổ đầu bài',
                onBack: () {
                  context.pop();
                },
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: AppRadius.roundedTop28,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Tiết ${widget.lessonDataItem.tietNum} ${widget.lessonDataItem.subjectName}',
                          style: AppTextStyles.normal16(
                            color: AppColors.gray700,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextRegister('Tên bài học'),
                        InputRegister(
                          note: (value) {
                            lessionTitle = value;
                          },
                          labalText: 'Nhập tên bài học',
                        ),
                        TextRegister('Tiết học phân phối chương trình'),
                        InputRegister(
                          note: (value) {
                            tietPpct = value;
                          },
                          labalText: 'Nhập thông tin',
                        ),
                        TextRegister('Nhận xét tiết học'),
                        InputRegister(
                          note: (value) {
                            lessionNote = value;
                          },
                          labalText: 'Nhập thông tin',
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 6, bottom: 18),
                          child: DropdownButtonComponent(
                            optionList: widget.lessonDataItem.lessonRank,
                            hint: '  __  __',
                            onUpdateOption: (LessonRank student) {
                              lessionRank = student.lessonRankKey.toString();
                            },
                          ),
                        ),
                        TextRegister('Báo bài'),
                        InputRegister(
                          note: (value) {
                            homeWork = value;
                          },
                          labalText: 'Nhập tên bài học',
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: AppColors.gray100,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Text(
                                  'Đính kèm',
                                  style: AppTextStyles.normal12(
                                    color: AppColors.gray400,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const Icon(
                                  Icons.attach_file,
                                  color: AppColors.gray400,
                                  size: 20,
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        TextRegister('Hạn nôp bài'),
                        SelectDate(
                          datePicked: DateTime.now(),
                          onDatePicked: (date) {
                            dateline = date.ddMMyyyyDash;
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Học sinh vi phạm',
                              style: AppTextStyles.normal14(
                                color: AppColors.black,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            RawMaterialButton(
                              onPressed: () {
                                _addContainer(
                                  violation,
                                  listViolation,
                                );
                              },
                              fillColor: Colors.black,
                              constraints: const BoxConstraints(
                                maxHeight: 30,
                              ),
                              padding: EdgeInsets.zero,
                              shape: const CircleBorder(),
                              child: const Icon(
                                Icons.add,
                                size: 20.0,
                                color: AppColors.white,
                              ),
                            ),
                          ],
                        ),
                        ...containers,
                      ],
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

Padding TextRegister(String text) {
  return Padding(
    padding: const EdgeInsets.only(top: 4),
    child: Text(
      text,
      style: AppTextStyles.normal14(
        color: AppColors.gray700,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}
