import 'package:core/core.dart';
import 'package:core/resources/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:repository/repository.dart';
import 'package:teacher/app_config/router_configuration.dart';
import 'package:teacher/common_bloc/current_user/current_user_bloc.dart';
import 'package:teacher/components/app_bar/screen_app_bar.dart';
import 'package:teacher/components/back_ground_container.dart';
import 'package:teacher/screens/authentication/utilites/dialog_utils.dart';
import 'package:teacher/screens/pre_score/bloc/pre_score_bloc.dart';
import 'package:teacher/screens/pre_score/widget/select_button/select_button_feedback/select_option_button_feedback_type.dart';

class AddPreScoreScreen extends StatelessWidget {
  const AddPreScoreScreen({
    super.key,
    required this.phoneBookStudent,
  });

  final List<PhoneBookStudent> phoneBookStudent;

  @override
  Widget build(BuildContext context) {
    final userRepository = context.read<UserRepository>();
    final appFetchApiRepository = context.read<AppFetchApiRepository>();
    final preScoreBloc = PreScoreBloc(
      appFetchApiRepo: appFetchApiRepository,
      currentUserBloc: context.read<CurrentUserBloc>(),
      userRepository: userRepository,
    );
    preScoreBloc.add(GetArmorial());
    return BlocProvider.value(
      value: preScoreBloc,
      child: BlocListener<PreScoreBloc, PreScoreState>(
        listener: (context, state) {
          if (state.preScoreStatus == PreScoreStatus.loadingPostComment) {
            LoadingDialog.show(context);
          } else if (state.preScoreStatus ==
              PreScoreStatus.successPostComment) {
            LoadingDialog.hide(context);
            Fluttertoast.showToast(
                timeInSecForIosWeb: 2,
                msg: state.status,
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                backgroundColor: AppColors.green400,
                textColor: AppColors.white);
            preScoreBloc.add(GetArmorial());
          } else if (state.preScoreStatus == PreScoreStatus.failPost) {
            LoadingDialog.hide(context);
            Fluttertoast.showToast(
                timeInSecForIosWeb: 2,
                msg: state.status,
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                backgroundColor: AppColors.black,
                textColor: AppColors.white);
          }
        },
        child: AddPreScoreview(
          phoneBookStudent: phoneBookStudent,
        ),
      ),
    );
  }
}

class AddPreScoreview extends StatelessWidget {
  const AddPreScoreview({
    super.key,
    required this.phoneBookStudent,
  });

  final List<PhoneBookStudent> phoneBookStudent;

  @override
  Widget build(BuildContext context) {
    Armorial? selectArmorial;
    DateTime startDate = DateTime.now();
    DateTime endDate = DateTime.now();
    PhoneBookStudent? newStudent;
    String note = '';
    return BlocBuilder<PreScoreBloc, PreScoreState>(builder: (context, state) {
      final listArmorial = state.armorial;
      return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: BackGroundContainer(
          child: Column(
            children: [
              const ScreensAppBar(
                'Nhập nhận xét',
                canGoBack: true,
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
                  child: AppSkeleton(
                    isLoading: state.preScoreStatus ==
                        PreScoreStatus.loadingGetArmorial,
                    child: Column(
                      children: [
                        DropDowStudent(
                          onSelectStudent: (value) {
                            newStudent = value;
                          },
                          students: phoneBookStudent,
                        ),
                        Container(
                          padding: const EdgeInsets.all(12),
                          child: SelectFeedBackType(
                            onGetComment: (startDate, endDate) {
                              startDate = startDate;
                              endDate = endDate;
                            },
                            endDate: DateTime.now(),
                            startDate: DateTime.now(),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              gradient: const LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Color(0xFFDFEEFF),
                                  Color(0xFFFFFFFF),
                                  Color(0xFFFFFFFF),
                                ],
                                stops: [
                                  0.0,
                                  0.401,
                                  1.0
                                ], // The stop positions for the colors
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: SingleChildScrollView(
                                    physics: AlwaysScrollableScrollPhysics(),
                                    child: Column(
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SvgPicture.asset(
                                              Assets.icons.features.report,
                                              width: 20,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 6),
                                              child: Text(
                                                'Nhận xét của giáo viên',
                                                style: AppTextStyles.normal16(
                                                  fontWeight: FontWeight.w600,
                                                  color: AppColors.brand600,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: AppColors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                color: AppColors.white,
                                                width: 1,
                                              ),
                                            ),
                                            child: TextField(
                                              decoration: const InputDecoration(
                                                  contentPadding:
                                                      EdgeInsets.all(8),
                                                  border: InputBorder.none,
                                                  labelText: 'Nhập nhận xét'),
                                              maxLines: null,
                                              onChanged: (value) {
                                                note = value;
                                              },
                                            ),
                                          ),
                                        ),
                                        DropDowArmorial(
                                          onTapSelect: (value) {
                                            selectArmorial = value;
                                          },
                                          armorial: listArmorial,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Column(
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          context.read<PreScoreBloc>().add(
                                                PostComment(
                                                  commentMnContent: note,
                                                  commentMnTitle:
                                                      startDate.toString(),
                                                  huyHieuId: selectArmorial
                                                          ?.huyHieuId
                                                          .toString() ??
                                                      '',
                                                  pupilId:
                                                      newStudent?.pupilId ?? 0,
                                                  userKey: context
                                                      .read<CurrentUserBloc>()
                                                      .state
                                                      .user
                                                      .user_key,
                                                  weekDay:
                                                      startDate.ddMMyyyyDash,
                                                ),
                                              );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          padding: const EdgeInsets.all(6),
                                          backgroundColor:
                                              const Color(0xFF9C292E),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 5, bottom: 5),
                                          child: Text(
                                            'Lưu',
                                            style: AppTextStyles.semiBold14(
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 6),
                                      width: double.infinity,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          context.pop();
                                        },
                                        style: ElevatedButton.styleFrom(
                                          padding: const EdgeInsets.all(6),
                                          backgroundColor: AppColors.white,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 5, bottom: 5),
                                          child: Text('Huỷ',
                                              style: AppTextStyles.semiBold14(
                                                  color: AppColors.black)),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
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

class DropDowArmorial extends StatefulWidget {
  const DropDowArmorial({
    super.key,
    required this.armorial,
    required this.onTapSelect,
  });
  final List<Armorial> armorial;
  final Function(Armorial? armorial) onTapSelect;
  @override
  State<DropDowArmorial> createState() => _DropDowArmorialState();
}

class _DropDowArmorialState extends State<DropDowArmorial> {
  Armorial? selectedArmorial;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.gray400, width: 0.5),
            color: AppColors.white,
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton2<Armorial>(
              hint: Text(
                'Chọn huy hiệu',
                style: AppTextStyles.normal14(
                  fontWeight: FontWeight.w600,
                  color: AppColors.brand600,
                ),
              ),
              value: selectedArmorial,
              items: widget.armorial.isNotEmpty
                  ? widget.armorial.map((item) {
                      return DropdownMenuItem<Armorial>(
                        value: item,
                        child: Row(
                          children: [
                            Image.network(
                              item.huyHieuImg,
                              width: 24,
                              height: 24,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              item.huyHieuName,
                              style: AppTextStyles.normal14(
                                fontWeight: FontWeight.w400,
                                color: AppColors.black,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList()
                  : [],
              onChanged: (Armorial? value) {
                setState(() {
                  widget.onTapSelect(value);
                  selectedArmorial = value;
                });
              },
            ),
          ),
        ),
        if (selectedArmorial != null) ...[
          Text(
            'Tên huy hiệu: ${selectedArmorial?.huyHieuName}',
            style: AppTextStyles.normal14(
              fontWeight: FontWeight.w400,
              color: AppColors.black,
            ),
          ),
          Image.network(
            selectedArmorial?.huyHieuImg ?? '',
            width: 100,
            height: 100,
          ),
        ],
      ],
    );
  }
}

class DropDowStudent extends StatefulWidget {
  final List<PhoneBookStudent> students;
  final Function(PhoneBookStudent? armorial) onSelectStudent;
  const DropDowStudent({
    super.key,
    required this.students,
    required this.onSelectStudent,
  });

  @override
  _DropDowStudentState createState() => _DropDowStudentState();
}

class _DropDowStudentState extends State<DropDowStudent> {
  late PhoneBookStudent _selectedStudent;

  @override
  void initState() {
    super.initState();
    _selectedStudent = widget.students.isNotEmpty
        ? widget.students[0]
        : PhoneBookStudent.empty();
    widget.onSelectStudent(_selectedStudent);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          DropdownButtonHideUnderline(
            child: DropdownButton<PhoneBookStudent>(
              value: _selectedStudent,
              icon: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 100,
                  ),
                  const Icon(
                    Icons.keyboard_arrow_down,
                    color: AppColors.gray400,
                  ),
                ],
              ),
              iconSize: 24,
              iconEnabledColor: AppColors.gray400,
              onChanged: (PhoneBookStudent? newValue) {
                setState(() {
                  _selectedStudent = newValue!;
                });
                widget.onSelectStudent(newValue);
              },
              items: widget.students.map<DropdownMenuItem<PhoneBookStudent>>(
                (PhoneBookStudent student) {
                  return DropdownMenuItem<PhoneBookStudent>(
                    value: student,
                    child: Row(
                      children: [
                        CircleAvatar(
                          maxRadius: 18,
                          backgroundColor: AppColors.brand600,
                          child: SvgPicture.asset(
                            'assets/icons/send-message-bus.svg',
                            width: 20,
                            height: 20,
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              student.fullName,
                              style: AppTextStyles.normal14(
                                fontWeight: FontWeight.w600,
                                color: AppColors.brand600,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  student.className,
                                  style: AppTextStyles.normal14(
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.gray400,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 4),
                                  child: Container(
                                    height: 5,
                                    width: 5,
                                    decoration: BoxDecoration(
                                      color: AppColors.gray400,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                                Text(
                                  student.userKey,
                                  style: AppTextStyles.normal14(
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.gray400,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
