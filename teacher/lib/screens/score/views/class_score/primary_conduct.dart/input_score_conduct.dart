import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:network_data_source/network_data_source.dart';
import 'package:repository/repository.dart';
import 'package:teacher/common_bloc/current_user/current_user_bloc.dart';
import 'package:teacher/components/app_bar/app_bar.dart';
import 'package:teacher/components/back_ground_container.dart';
import 'package:teacher/screens/authentication/utilites/dialog_utils.dart';
import 'package:teacher/screens/score/views/bloc/class_score_bloc.dart';

class InputScoreConduct extends StatelessWidget {
  const InputScoreConduct({
    super.key,
    required this.phoneBookStudent,
    required this.hocKy,
    required this.hocKyTih,
    required this.learnYear,
    required this.onTap,
  });
  final List<PhoneBookStudent> phoneBookStudent;
  final int hocKy;
  final int hocKyTih;
  final String learnYear;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    final scoreBloc = ClassScoreBloc(
      userRepository: context.read<UserRepository>(),
      appFetchApiRepo: context.read<AppFetchApiRepository>(),
      currentUserBloc: context.read<CurrentUserBloc>(),
    );
    scoreBloc.add(GetFormConduct());
    return BlocProvider.value(
      value: scoreBloc,
      child: BlocListener<ClassScoreBloc, ClassScoreState>(
        listener: (context, state) {
          if (state.status == Status.laodingPostMOET) {
            LoadingDialog.show(context);
          } else if (state.status == Status.successPostMOET) {
            LoadingDialog.hide(context);
            onTap();
          } else if (state.status == Status.failPostMOET) {
            LoadingDialog.hide(context);
            Fluttertoast.showToast(
                msg: state.message,
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                backgroundColor: AppColors.black,
                textColor: AppColors.white);
          }
        },
        child: InputConductView(
          phoneBookStudent: phoneBookStudent,
          hocKy: hocKy,
          hocKyTih: hocKyTih,
          learnYear: learnYear,
        ),
      ),
    );
  }
}

class InputConductView extends StatefulWidget {
  const InputConductView({
    super.key,
    required this.phoneBookStudent,
    required this.hocKy,
    required this.hocKyTih,
    required this.learnYear,
  });
  final List<PhoneBookStudent> phoneBookStudent;
  final int hocKy;
  final int hocKyTih;
  final String learnYear;
  @override
  State<InputConductView> createState() => _InputConductViewState();
}

class _InputConductViewState extends State<InputConductView> {
  int currentIndex = 0;
  List<List<String?>> selectedValuesList = [];
  List<List<String?>> selectedNLCList = [];
  List<List<String?>> selectedNLDTList = [];
  List<ConductScore> allScores = [];
  List<String?> notesList = [];

  @override
  void initState() {
    super.initState();
    for (var student in widget.phoneBookStudent) {
      selectedValuesList.add([]);
      selectedNLCList.add([]);
      selectedNLDTList.add([]);
      notesList.add('');
    }
  }

  @override
  Widget build(BuildContext context) {
    final student = widget.phoneBookStudent[currentIndex];
    return BlocBuilder<ClassScoreBloc, ClassScoreState>(
      builder: (context, state) {
        final hanhKiemData = state.hanhKiemData;

        final listEvaluation = [
          ...hanhKiemData.dataKeyTih?.phamChatChuYeu ?? []
        ];

        if (selectedValuesList[currentIndex].isEmpty) {
          selectedValuesList[currentIndex] =
              List<String?>.filled(listEvaluation.length, null);
        }
        if (selectedNLCList[currentIndex].isEmpty) {
          selectedNLCList[currentIndex] = List<String?>.filled(
              hanhKiemData.dataKeyTih?.nangLucCotLoi?.nangLucChung?.length ?? 0,
              null);
        }
        if (selectedNLDTList[currentIndex].isEmpty) {
          selectedNLDTList[currentIndex] = List<String?>.filled(
              hanhKiemData.dataKeyTih?.nangLucCotLoi?.nangLucDacThu?.length ??
                  0,
              null);
        }
        final hanhKiemOptions = hanhKiemData.dataHanhKiemTih
                ?.map((e) => e.hanhKiemValue)
                .toList() ??
            [];
        List<ConductScore> scores = [];
        List<ConductScore> buildConductScores() {
          final student = widget.phoneBookStudent[currentIndex];

          // Thêm thông tin về hạnh kiểm chung của học sinh
          for (int i = 0; i < notesList[currentIndex]!.length; i++) {
            if (notesList[currentIndex]?[i] != null) {
              scores.add(
                ConductScore(
                  pupilId: student.pupilId,
                  hanhKiemKey: hanhKiemData
                          .dataKeyTih?.nhanXetChungCuaGvcn?.first.hanhKiemKey ??
                      '',
                  hanhKiemValue: notesList[currentIndex] ?? '',
                ),
              );
            }
          }

          // Thêm các hạnh kiểm được chọn
          for (int i = 0; i < selectedValuesList[currentIndex].length; i++) {
            if (selectedValuesList[currentIndex][i] != null) {
              scores.add(
                ConductScore(
                  pupilId: student.pupilId,
                  hanhKiemKey: listEvaluation[i].hanhKiemKey ?? '',
                  hanhKiemValue: selectedValuesList[currentIndex][i]!,
                ),
              );
            }
          }

          // Thêm các năng lực cốt lõi được chọn
          for (int i = 0; i < selectedNLCList[currentIndex].length; i++) {
            if (selectedNLCList[currentIndex][i] != null) {
              scores.add(
                ConductScore(
                  pupilId: student.pupilId,
                  hanhKiemKey: hanhKiemData.dataKeyTih?.nangLucCotLoi
                          ?.nangLucChung?[i].hanhKiemKey ??
                      '',
                  hanhKiemValue: selectedNLCList[currentIndex][i]!,
                ),
              );
            }
          }

          // Thêm các năng lực đặc thù được chọn
          for (int i = 0; i < selectedNLDTList[currentIndex].length; i++) {
            if (selectedNLDTList[currentIndex][i] != null) {
              scores.add(
                ConductScore(
                  pupilId: student.pupilId,
                  hanhKiemKey: hanhKiemData.dataKeyTih?.nangLucCotLoi
                          ?.nangLucDacThu?[i].hanhKiemKey ??
                      '',
                  hanhKiemValue: selectedNLDTList[currentIndex][i]!,
                ),
              );
            }
          }

          allScores = [...scores];
          return scores;
        }

        return BackGroundContainer(
          child: Column(
            children: [
              ScreenAppBar(
                title: 'Nhập hạnh kiểm',
                canGoback: true,
                onBack: () {
                  Navigator.of(context).pop();
                },
              ),
              Expanded(
                child: Container(
                  color: Colors.white,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Image.network(
                          student.urlImage.mobile.isNotEmpty
                              ? student.urlImage.mobile
                              : 'https://st4.depositphotos.com/14953852/24787/v/450/depositphotos_247872612-stock-illustration-no-image-available-icon-vector.jpg',
                          errorBuilder: (BuildContext context,
                              Object? exception, StackTrace? stackTrace) {
                            return Image.network(
                              'https://st4.depositphotos.com/14953852/24787/v/450/depositphotos_247872612-stock-illustration-no-image-available-icon-vector.jpg',
                            );
                          },
                        ),
                        Container(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Lớp ${student.className}',
                                    style: TextStyle(
                                      color: Colors.grey[700],
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    '${currentIndex + 1}/${widget.phoneBookStudent.length}',
                                    style: TextStyle(
                                      color: Colors.blue[600],
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    student.fullName,
                                    style: TextStyle(
                                      color: Colors.blue[600],
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    student.pupilId.toString(),
                                    style: TextStyle(
                                      color: Colors.blue[600],
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                              AppSkeleton(
                                isLoading:
                                    state.status == Status.loadingFormConduct,
                                child: Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(8),
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8)),
                                        gradient: LinearGradient(
                                          colors: [
                                            Color(0xFF78B6FF),
                                            Color(0xFF70B8FF),
                                          ],
                                          stops: [
                                            0.0189,
                                            0.9356,
                                          ],
                                        ),
                                      ),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              left: 4,
                                            ),
                                            child: Row(
                                              children: [
                                                CircleAvatar(
                                                  radius: 10,
                                                  backgroundColor:
                                                      const Color(0xFF278BEB),
                                                  child: SvgPicture.asset(
                                                    'assets/icons/emoji-normal.svg',
                                                    height: 12,
                                                    width: 12,
                                                  ),
                                                ),
                                                const SizedBox(width: 8),
                                                Text(
                                                  'Năng lực cốt lõi',
                                                  style:
                                                      AppTextStyles.semiBold14(
                                                          color:
                                                              AppColors.white),
                                                )
                                              ],
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: AppColors.white,
                                            ),
                                            child: Column(
                                              children: List.generate(
                                                  hanhKiemData
                                                          .dataKeyTih
                                                          ?.nangLucCotLoi
                                                          ?.nangLucChung
                                                          ?.length ??
                                                      0, (index) {
                                                final itemNLC = hanhKiemData
                                                    .dataKeyTih
                                                    ?.nangLucCotLoi
                                                    ?.nangLucChung?[index];
                                                return Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Expanded(
                                                      child: Text(itemNLC
                                                              ?.hanhKiemName ??
                                                          ''),
                                                    ),
                                                    DropdownButton<String>(
                                                      value: selectedNLCList[
                                                          currentIndex][index],
                                                      items: hanhKiemOptions.map<
                                                          DropdownMenuItem<
                                                              String>>((value) {
                                                        return DropdownMenuItem<
                                                            String>(
                                                          value: value,
                                                          child: Text(
                                                            value ?? '',
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                        );
                                                      }).toList(),
                                                      onChanged: (newValue) {
                                                        setState(() {
                                                          selectedNLCList[
                                                                  currentIndex][
                                                              index] = newValue;
                                                        });
                                                      },
                                                    ),
                                                  ],
                                                );
                                              }),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          Container(
                                            padding: EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: AppColors.white,
                                            ),
                                            child: Column(
                                              children: List.generate(
                                                  hanhKiemData
                                                          .dataKeyTih
                                                          ?.nangLucCotLoi
                                                          ?.nangLucDacThu
                                                          ?.length ??
                                                      0, (index) {
                                                final itemNLC = hanhKiemData
                                                    .dataKeyTih
                                                    ?.nangLucCotLoi
                                                    ?.nangLucDacThu?[index];
                                                return Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                        itemNLC?.hanhKiemName ??
                                                            ''),
                                                    DropdownButton<String>(
                                                      value: selectedNLDTList[
                                                          currentIndex][index],
                                                      items: hanhKiemOptions.map<
                                                          DropdownMenuItem<
                                                              String>>((value) {
                                                        return DropdownMenuItem<
                                                            String>(
                                                          value: value,
                                                          child:
                                                              Text(value ?? ''),
                                                        );
                                                      }).toList(),
                                                      onChanged: (newValue) {
                                                        setState(() {
                                                          selectedNLDTList[
                                                                  currentIndex][
                                                              index] = newValue;
                                                        });
                                                      },
                                                    ),
                                                  ],
                                                );
                                              }),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(8),
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8)),
                                        gradient: LinearGradient(
                                          colors: [
                                            Color(0xFF6CDAA6),
                                            Color(0xFF71E0AB),
                                          ],
                                          stops: [
                                            0.0189,
                                            0.9356,
                                          ],
                                        ),
                                      ),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              left: 4,
                                            ),
                                            child: Row(
                                              children: [
                                                CircleAvatar(
                                                  radius: 10,
                                                  backgroundColor:
                                                      const Color(0xFF15A251),
                                                  child: SvgPicture.asset(
                                                    'assets/icons/emoji-normal.svg',
                                                    height: 12,
                                                    width: 12,
                                                  ),
                                                ),
                                                const SizedBox(width: 8),
                                                Text(
                                                  'Năng lực chung',
                                                  style:
                                                      AppTextStyles.semiBold14(
                                                          color:
                                                              AppColors.white),
                                                )
                                              ],
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: AppColors.white,
                                            ),
                                            child: Column(
                                              children: List.generate(
                                                  listEvaluation.length,
                                                  (index) {
                                                return Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(listEvaluation[index]
                                                            .hanhKiemName ??
                                                        ''),
                                                    DropdownButton<String>(
                                                      value: selectedValuesList[
                                                          currentIndex][index],
                                                      items: hanhKiemOptions.map<
                                                          DropdownMenuItem<
                                                              String>>((value) {
                                                        return DropdownMenuItem<
                                                            String>(
                                                          value: value,
                                                          child:
                                                              Text(value ?? ''),
                                                        );
                                                      }).toList(),
                                                      onChanged: (newValue) {
                                                        setState(() {
                                                          selectedValuesList[
                                                                  currentIndex][
                                                              index] = newValue;
                                                        });
                                                      },
                                                    ),
                                                  ],
                                                );
                                              }),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(8),
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8)),
                                        gradient: LinearGradient(
                                          colors: [
                                            Color(0xFFFEF0C7),
                                            Color(0xFFFEF0C7),
                                          ],
                                          stops: [
                                            0.0189,
                                            0.9356,
                                          ],
                                        ),
                                      ),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              left: 4,
                                            ),
                                            child: Row(
                                              children: [
                                                CircleAvatar(
                                                  radius: 10,
                                                  backgroundColor:
                                                      const Color(0xFFF88F33),
                                                  child: SvgPicture.asset(
                                                    'assets/icons/emoji-normal.svg',
                                                    height: 12,
                                                    width: 12,
                                                  ),
                                                ),
                                                const SizedBox(width: 8),
                                                Text(
                                                  'Nhận xét',
                                                  style:
                                                      AppTextStyles.semiBold14(
                                                          color:
                                                              AppColors.white),
                                                )
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                                color: AppColors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            padding: EdgeInsets.all(8),
                                            child: TextField(
                                              maxLines: null,
                                              onChanged: (value) {
                                                setState(() {
                                                  notesList[currentIndex] =
                                                      value;
                                                });
                                              },
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText: 'Nhận xét',
                                              ),
                                              style: AppTextStyles.normal14(
                                                  color: AppColors.gray600),
                                              controller: TextEditingController(
                                                  text:
                                                      notesList[currentIndex]),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.brand500,
                                    ),
                                    onPressed: currentIndex <
                                            widget.phoneBookStudent.length - 1
                                        ? () {
                                            buildConductScores();
                                            setState(() {
                                              currentIndex++;
                                            });
                                            context.read<ClassScoreBloc>().add(
                                                AddScoreConduct(data: scores));
                                          }
                                        : () {
                                            buildConductScores();
                                            context.read<ClassScoreBloc>().add(
                                                  PostPrimaryConduct(
                                                    classid: widget
                                                        .phoneBookStudent
                                                        .first
                                                        .classId,
                                                    dataConduct:
                                                        state.conductScore ??
                                                            [],
                                                    hocKy: widget.hocKy,
                                                    hocKyTih: widget.hocKyTih,
                                                    learnYear: widget.learnYear,
                                                    userKey: context
                                                        .read<CurrentUserBloc>()
                                                        .state
                                                        .user
                                                        .user_key,
                                                  ),
                                                );
                                          },
                                    child: Text(
                                      currentIndex <
                                              widget.phoneBookStudent.length - 1
                                          ? 'Tiếp theo'
                                          : 'Hoàn thành',
                                      style: AppTextStyles.normal12(
                                        color: AppColors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
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
