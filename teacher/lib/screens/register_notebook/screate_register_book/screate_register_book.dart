import 'dart:io';

import 'package:core/core.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:repository/repository.dart';
import 'package:teacher/app_config/router_configuration.dart';
import 'package:teacher/common_bloc/current_user/current_user_bloc.dart';
import 'package:teacher/components/app_bar/app_bar.dart';
import 'package:teacher/components/back_ground_container.dart';
import 'package:teacher/components/select_date.dart';
import 'package:teacher/screens/authentication/utilites/dialog_utils.dart';
import 'package:teacher/screens/register_notebook/bloc/register_notebook_bloc.dart';
import 'package:teacher/screens/register_notebook/screate_register_book/widgets/dropdow_register.dart';
import 'package:teacher/screens/register_notebook/screate_register_book/widgets/input_register.dart';
import 'package:teacher/screens/register_notebook/screate_register_book/widgets/register_select.dart';

class CreateRegisterBookScreen extends StatelessWidget {
  const CreateRegisterBookScreen({
    super.key,
    required this.lessonDataItem,
    required this.onBack,
  });
  final LessonDataItem lessonDataItem;
  final VoidCallback onBack;
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
    return Material(
      child: BlocProvider.value(
        value: registerBloc,
        child: BlocListener<RegisterNotebookBloc, RegisterNotebookState>(
          listener: (context, state) {
            if (state.status == RegisterNotebookStatus.loadingPostRegister) {
              LoadingDialog.show(context);
            } else if (state.status ==
                RegisterNotebookStatus.successPostRegister) {
              if (state.containerData != null) {
                registerBloc
                    .add(PostViolation(containerData: state.containerData));
              } else {
                LoadingDialog.hide(context);
                onBack();
              }
            } else if (state.status ==
                RegisterNotebookStatus.successPostViolation) {
              LoadingDialog.hide(context);
              onBack();
            } else if (state.status == RegisterNotebookStatus.failPost) {
              Fluttertoast.showToast(
                  timeInSecForIosWeb: 2,
                  msg: state.message,
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  backgroundColor: AppColors.black,
                  textColor: AppColors.white);
            }
          },
          child: ScreateRegisterBookView(
            lessonDataItem: lessonDataItem,
          ),
        ),
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
  List<Map<String, dynamic>> containersData = [];
  List<Widget> containers = [];
  String? lessionTitle;
  String? lessionNote;
  String? lessionRank;
  String? homeWork;
  String? tietPpct;
  String? dateline = DateTime.now().ddMMyyyyDash;
  File? attachedFile;
  String? linkBaoBai;
  int containerCounter = 0;

  void _addContainer(
    ViolationData? violationData,
    List<ListViolation>? listViolation,
  ) {
    setState(() {
      final newIndex = containerCounter++;
      containersData.add({
        'id': newIndex,
        'lesson_id': widget.lessonDataItem.lessonId,
        'user_key': context.read<CurrentUserBloc>().state.user.user_key,
        'pupil_id': null,
        'vi_pham_id': null,
        'vi_pham_note': null,
      });
      containers.add(
        Padding(
          key: ValueKey(newIndex),
          padding: const EdgeInsets.only(bottom: 8, top: 8),
          child: Container(
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
                        containers.removeWhere(
                            (element) => element.key == ValueKey(newIndex));
                        containersData.removeWhere(
                            (element) => element['id'] == newIndex);
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
                RegisterSelect(
                  title: 'Chọn học sinh',
                  hintText: 'Chọn học sinh',
                  options: violationData!.pupils.map((e) {
                    return e.pupilName;
                  }).toList(),
                  onUpdateOption: (value) {
                    // TODO: update this func
                    // old func:
                    // setState(() {
                    //   containersData.firstWhere((element) =>
                    //       element['id'] == newIndex)['pupil_id'] = value;
                    // });
                  },
                ),
                const SizedBox(height: 12),
                RegisterSelect(
                  title: 'Chọn lỗi vi phạm',
                  hintText: 'Chọn lỗi vi phạm',
                  options: listViolation!.map((e) {
                    return e.viPhamName;
                  }).toList(),
                  onUpdateOption: (value) {
                    // TODO: update this func
                    // old func:
                    //       setState(() {
                    //         containersData.firstWhere((element) =>
                    //                 element['id'] == newIndex)['vi_pham_id'] =
                    //             violation.viPhamId;
                    //       });
                  },
                ),

                // Old code:
                // Padding(
                //   padding: const EdgeInsets.only(bottom: 8),
                //   child: DropdownButtonRegister(
                //     listViolation: listViolation,
                //     hint: ' Lỗi vi phạm',
                //     onUpdateViolation: (ListViolation violation) {
                //       setState(() {
                //         containersData.firstWhere((element) =>
                //                 element['id'] == newIndex)['vi_pham_id'] =
                //             violation.viPhamId;
                //       });
                //     },
                //   ),
                // ),
                InputRegister(
                  noLabel: true,
                  note: (value) {
                    setState(() {
                      containersData.firstWhere((element) =>
                          element['id'] == newIndex)['vi_pham_note'] = value;
                    });
                  },
                  hintText: 'Nhập ghi chú',
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null && result.files.single.path != null) {
      setState(() {
        attachedFile = File(result.files.single.path!);
      });
    } else {
      // User canceled the picker
    }
  }

  bool _validateContainers() {
    for (var container in containersData) {
      if (container['pupil_id'] == null ||
          container['vi_pham_id'] == null ||
          container['vi_pham_note'] == null) {
        return false;
      }
    }
    return true;
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
                title:
                    'Tiết ${widget.lessonDataItem.tietNum} ${widget.lessonDataItem.subjectName}',
                onBack: () {
                  context.pop();
                },
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: AppRadius.roundedTop28,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InputRegister(
                          label: 'Tên bài học',
                          note: (value) {
                            lessionTitle = value;
                          },
                          hintText: 'Nhập tên bài học',
                        ),
                        InputRegister(
                          label: 'Tiết học phân phối chương trình',
                          note: (value) {
                            tietPpct = value;
                          },
                          hintText: '',
                        ),
                        InputRegister(
                          label: 'Nhận xét tiết học',
                          note: (value) {
                            lessionNote = value;
                          },
                          hintText: 'Nhập nhận xét',
                        ),
                        Text(
                          'Đánh giá',
                          style: AppTextStyles.normal14(
                            color: AppColors.gray700,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6.0),
                          child: FilterItem(
                            title: 'Chọn học kỳ',
                            options: widget.lessonDataItem.lessonRank.map((e) {
                              return e.lessonRankName;
                            }).toList(),
                            selectedOption: lessionRank,
                            onUpdateOption: (value) {
                              lessionRank = value;
                            },
                          ),
                        ),
                        InputRegister(
                          label: 'Báo bài',
                          note: (value) {
                            homeWork = value;
                          },
                          hintText: 'Nhập lời dặn',
                        ),
                        GestureDetector(
                          onTap: _pickFile,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 6),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: AppColors.gray100,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Đính kèm',
                                      style: AppTextStyles.normal14(
                                        color: AppColors.gray600,
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    const Icon(
                                      Icons.attach_file,
                                      color: AppColors.gray600,
                                      size: 20,
                                    ),
                                  ],
                                ),
                                if (attachedFile != null)
                                  Row(
                                    children: [
                                      const Icon(Icons.file_copy_sharp),
                                      IconButton(
                                        padding: EdgeInsets.zero,
                                        onPressed: () {
                                          setState(() {
                                            attachedFile = null;
                                          });
                                        },
                                        icon: const Icon(
                                          Icons.remove_circle,
                                          color: AppColors.brand500,
                                        ),
                                      ),
                                    ],
                                  ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        InputRegister(
                          label: 'Đường dẫn báo bài',
                          note: (value) {
                            linkBaoBai = value;
                          },
                          hintText: 'Nhập vào đường dẫn báo bài',
                        ),
                        Text(
                          'Hạn nộp bài',
                          style: AppTextStyles.normal14(
                            color: AppColors.gray700,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
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
                        Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              _validateContainers();
                              if (lessionNote != null &&
                                  _validateContainers()) {
                                context.read<RegisterNotebookBloc>().add(
                                      PostRegister(
                                        containerData: containersData.isEmpty
                                            ? null
                                            : containersData,
                                        danDoBaoBai: homeWork ?? '',
                                        fileBaoBai: attachedFile,
                                        hanNop: dateline ?? '',
                                        lessionId:
                                            widget.lessonDataItem.lessonId,
                                        lessionNote: lessionNote ?? '',
                                        lessionRank: lessionRank ?? '',
                                        lessionTitle: lessionTitle ?? '',
                                        linkBaoBai: linkBaoBai,
                                        tietPpct: tietPpct ?? '',
                                        userKey: context
                                            .read<CurrentUserBloc>()
                                            .state
                                            .user
                                            .user_key,
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
