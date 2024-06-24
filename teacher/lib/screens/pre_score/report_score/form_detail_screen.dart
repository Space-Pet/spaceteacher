import 'dart:developer';

import 'package:core/core.dart';
import 'package:core/resources/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:network_data_source/network_data_source.dart';
import 'package:repository/repository.dart';
import 'package:teacher/common_bloc/current_user/current_user_bloc.dart';
import 'package:teacher/components/app_bar/screen_app_bar.dart';
import 'package:teacher/components/back_ground_container.dart';
import 'package:teacher/screens/authentication/utilites/dialog_utils.dart';
import 'package:teacher/screens/pre_score/bloc/pre_score_bloc.dart';

class FormDetailScreen extends StatelessWidget {
  FormDetailScreen({
    super.key,
    required this.listStudentFormReport,
    required this.classId,
  });
  final ListStudentFormReport listStudentFormReport;
  late int classId;
  @override
  Widget build(BuildContext context) {
    final userRepository = context.read<UserRepository>();
    final appFetchApiRepository = context.read<AppFetchApiRepository>();
    final preScoreBloc = PreScoreBloc(
      appFetchApiRepo: appFetchApiRepository,
      currentUserBloc: context.read<CurrentUserBloc>(),
      userRepository: userRepository,
    );
    preScoreBloc.add(
      GetFormDetail(
        id: int.parse(listStudentFormReport.evaluationFormId),
        pupilId: listStudentFormReport.id,
      ),
    );
    return BlocProvider.value(
      value: preScoreBloc,
      child: BlocListener<PreScoreBloc, PreScoreState>(
        listener: (context, state) {
          if (state.preScoreStatus == PreScoreStatus.loadingPostUpdateReport) {
            LoadingDialog.show(context);
          } else if (state.preScoreStatus ==
              PreScoreStatus.successPostUpdateReport) {
            LoadingDialog.hide(context);
            preScoreBloc.add(
              GetFormDetail(
                id: int.parse(listStudentFormReport.evaluationFormId),
                pupilId: listStudentFormReport.id,
              ),
            );
          }
        },
        child: FormDetailView(
          listStudentFormReport: listStudentFormReport,
          classId: classId,
        ),
      ),
    );
  }
}

class FormDetailView extends StatefulWidget {
  const FormDetailView({
    super.key,
    required this.listStudentFormReport,
    required this.classId,
  });
  final ListStudentFormReport listStudentFormReport;
  final int classId;
  @override
  State<FormDetailView> createState() => _FormDetailViewState();
}

class _FormDetailViewState extends State<FormDetailView> {
  bool edit = false;
  int? expandedIndex;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PreScoreBloc, PreScoreState>(
      builder: (context, state) {
        final formDetail = state.formDetail;
        return BackGroundContainer(
          child: Column(
            children: [
              ScreensAppBar(
                'Báo cáo học tập',
                canGoBack: true,
                actionWidget: edit == false
                    ? Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              edit = true;
                            });
                          },
                          child: SvgPicture.asset(
                            Assets.icons.editProfile,
                            color: AppColors.white,
                            width: 25,
                          ),
                        ),
                      )
                    : const SizedBox(),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: AppSkeleton(
                    isLoading: state.preScoreStatus ==
                        PreScoreStatus.loadingGetFormDetail,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SvgPicture.asset(
                                Assets.icons.features.report,
                                width: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 6),
                                child: Text(
                                  'Thang đánh giá',
                                  style: AppTextStyles.normal16(
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.brand600,
                                  ),
                                ),
                              )
                            ],
                          ),
                          EvaluatioTarget(formDetail: formDetail),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SvgPicture.asset(
                                Assets.icons.features.report,
                                width: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 6),
                                child: Text(
                                  'Mục tiêu học tập và tiêu chí đánh giá',
                                  style: AppTextStyles.normal16(
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.brand600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          ContentReport(
                            onEdit: () {
                              setState(() {
                                edit = !edit;
                              });
                            },
                            classId: widget.classId,
                            formDetail: formDetail,
                            edit: edit,
                            listStudentFormReport: widget.listStudentFormReport,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class ContentReport extends StatefulWidget {
  ContentReport({
    super.key,
    required this.formDetail,
    required this.edit,
    required this.listStudentFormReport,
    required this.classId,
    required this.onEdit,
  });

  final FormDetail formDetail;
  bool edit;
  final ListStudentFormReport listStudentFormReport;
  final int classId;
  final VoidCallback onEdit;
  @override
  State<ContentReport> createState() => _ContentReportState();
}

class _ContentReportState extends State<ContentReport> {
  List<bool> isAccordionExpanded = [];
  List<List<String?>> selectedResults = [];
  List<List<UpdateReport>> saveUpdate = [];
  String? note;
  String? namTeacher;
  @override
  void initState() {
    super.initState();
    isAccordionExpanded = List.generate(
      widget.formDetail.data.items.length,
      (index) => false,
    );
    selectedResults = List.generate(
      widget.formDetail.data.items.length,
      (index) => List.filled(
        widget.formDetail.data.items[index].listCriterial.length,
        null,
      ),
    );

    for (var item in widget.formDetail.data.items) {
      List<UpdateReport> itemUpdates = [];
      for (var criterial in item.listCriterial) {
        UpdateReport report = UpdateReport(
          criterial_id: criterial.id,
          criterial_mapping_id: criterial.criterialMappingId,
          evaluation_form_id: criterial.evaluationFormId,
          mark_id:
              criterial.result.isNotEmpty ? criterial.result.last.markId : 0,
          other_result_text: '',
          pupil_id: item.listCriterial.first.result.first.pupilId,
        );
        itemUpdates.add(report);
      }
      saveUpdate.add(itemUpdates);
    }
  }

  void updateMarkId(String? newValue, int criterialId) {
    setState(() {
      for (var itemUpdates in saveUpdate) {
        for (var updateReport in itemUpdates) {
          if (updateReport.criterial_id == criterialId) {
            updateReport.mark_id = int.parse(newValue ?? '0');
            break;
          }
        }
      }
      log('saveUpdate after updateMarkId: ${saveUpdate.first.first.mark_id}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        widget.formDetail.data.items.length,
        (index) {
          final item = widget.formDetail.data.items[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isAccordionExpanded[index] = !isAccordionExpanded[index];
                    });
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          item.title,
                          style:
                              AppTextStyles.normal14(color: AppColors.brand200),
                        ),
                      ),
                      isAccordionExpanded[index]
                          ? const Icon(Icons.keyboard_arrow_down)
                          : const Icon(Icons.keyboard_arrow_up)
                    ],
                  ),
                ),
                // Render content if accordion is expanded
                if (isAccordionExpanded[index])
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: item.listCriterial.asMap().entries.map((entry) {
                      int criterialIndex = entry.key;
                      var itemData = entry.value;

                      Color color = AppColors.red;
                      String value = '4';

                      for (var mark in itemData.listMarks) {
                        if (itemData.result.last.markId == mark.id) {
                          if (mark.id == 101) {
                            color = AppColors.red;
                            value = mark.value.toString();
                          } else if (mark.id == 102) {
                            color = AppColors.brand600;
                            value = mark.value.toString();
                          } else {
                            color = AppColors.green;
                            value = mark.value.toString();
                          }
                        }
                      }

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: IntrinsicHeight(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Container(
                                color: AppColors.brand600,
                                width: 4,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  itemData.criterialTitle,
                                ),
                              ),
                              const SizedBox(width: 8),
                              // Render DropdownButton if in edit mode
                              if (widget.edit)
                                DropdownButton<String>(
                                  hint: Text('Chọn'),
                                  value: selectedResults[index][criterialIndex],
                                  icon: const Icon(Icons.arrow_drop_down),
                                  iconSize: 24,
                                  elevation: 16,
                                  style: AppTextStyles.bold14(
                                    color: AppColors.brand600,
                                  ),
                                  underline: Container(
                                    height: 2,
                                    color: AppColors.brand600,
                                  ),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      selectedResults[index][criterialIndex] =
                                          newValue;
                                      updateMarkId(newValue, itemData.id);
                                      print('object: ${saveUpdate.toList()}');
                                    });
                                  },
                                  items: itemData.listMarks.map((mark) {
                                    return DropdownMenuItem<String>(
                                      value: mark.id.toString(),
                                      child: Text(mark.value.toString()),
                                    );
                                  }).toList(),
                                ),
                              // Render static value if not in edit mode
                              if (!widget.edit)
                                Text(
                                  value,
                                  style: AppTextStyles.normal14(
                                    fontWeight: FontWeight.w600,
                                    color: color,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                if (index + 1 == widget.formDetail.data.items.length)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        textAlign: TextAlign.left,
                        'Thang đánh giá',
                        style: AppTextStyles.normal16(
                          fontWeight: FontWeight.w600,
                          color: AppColors.brand600,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: TitleAndInputText(
                          textInputType: false,
                          hintText: 'Nhập nhận xét',
                          onChanged: (value) {
                            note = value;
                          },
                        ),
                      ),
                      Text(
                        textAlign: TextAlign.left,
                        'Các giáo viên giảng dạy',
                        style: AppTextStyles.normal16(
                          fontWeight: FontWeight.w600,
                          color: AppColors.brand600,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: TitleAndInputText(
                          textInputType: false,
                          hintText: 'Nhập tên các giáo viên giảng dạy bé',
                          onChanged: (value) {
                            namTeacher = value;
                          },
                        ),
                      ),
                    ],
                  ),
                if (widget.edit == true &&
                    (index + 1 == widget.formDetail.data.items.length))
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              if (note != null && namTeacher != null) {
                                widget.onEdit();
                                context
                                    .read<PreScoreBloc>()
                                    .add(PostUpdateReport(
                                      classId: widget.classId,
                                      commentText: note ?? '',
                                      evaluationFormId: item
                                          .listCriterial.first.evaluationFormId
                                          .toString(),
                                      pupilId: item.listCriterial.first.result
                                          .first.pupilId,
                                      teacherEvaluation: namTeacher ?? '',
                                      updateReport: saveUpdate,
                                    ));
                              } else if (note == null) {
                                Fluttertoast.showToast(
                                    msg: 'Vui lòng điền thông tin nhận xét',
                                    toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.BOTTOM,
                                    backgroundColor: AppColors.black,
                                    textColor: AppColors.white);
                              } else if (namTeacher == null) {
                                Fluttertoast.showToast(
                                    msg:
                                        'Vui long điền thông tin tên giáo viên giảng dạy',
                                    toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.BOTTOM,
                                    backgroundColor: AppColors.black,
                                    textColor: AppColors.white);
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
                                style: AppTextStyles.semiBold14(
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: widget.onEdit,
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.all(6),
                              backgroundColor: Colors.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 5, bottom: 5),
                              child: Text(
                                'Huỷ',
                                style: AppTextStyles.semiBold14(
                                    color: const Color(0xFF9C292E)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class EvaluatioTarget extends StatelessWidget {
  const EvaluatioTarget({
    super.key,
    required this.formDetail,
  });

  final FormDetail formDetail;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.gray100,
          width: 1,
        ),
      ),
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        itemCount: formDetail.listMarks.length,
        itemBuilder: (context, index) {
          final item = formDetail.listMarks[index];
          final color;
          if (index % 3 == 0) {
            color = AppColors.red;
          } else if (index % 3 == 1) {
            color = AppColors.brand600;
          } else {
            color = AppColors.green;
          }
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: color,
                  ),
                  child: Center(
                    child: Text(
                      item.value.toString(),
                      style: AppTextStyles.normal10(
                          color: AppColors.white, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      style: AppTextStyles.normal14(
                        fontWeight: FontWeight.w400,
                        color: AppColors.black,
                      ),
                      children: [
                        TextSpan(
                          text: item.title,
                          style: AppTextStyles.normal14(
                            fontWeight: FontWeight.w600,
                            color: AppColors.black,
                          ),
                        ),
                        TextSpan(
                          text: ' ${item.description}',
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
