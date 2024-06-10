import 'package:core/core.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:repository/repository.dart';
import 'package:teacher/common_bloc/current_user/current_user_bloc.dart';
import 'package:teacher/components/app_bar/app_bar.dart';
import 'package:teacher/components/back_ground_container.dart';
import 'package:teacher/components/dialog/dialog_yes_no.dart';
import 'package:teacher/screens/observation_schedule/mock_data/subject_mock.dart';
import 'package:teacher/screens/observation_schedule/screen/create_observation/bloc/create_observation_bloc.dart';
import 'package:teacher/screens/observation_schedule/screen/create_observation/widget/card_info_add_observation.dart';
import 'package:teacher/screens/observation_schedule/screen/observation_detail/widget/select_field.dart';
import 'package:teacher/utils/extension_context.dart';

class CreateObservationScreen extends StatelessWidget {
  static const routeName = '/create_observation';
  const CreateObservationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUserBloc = context.read<CurrentUserBloc>().state.user;

    return BlocProvider(
      create: (context) => CreateObservationBloc(
        appFetchApiRepo: context.read<AppFetchApiRepository>(),
        userKey: currentUserBloc.user_key,
        schoolId: currentUserBloc.school_id,
      )..add(CreateObservationInit()),
      child: const CreateObservationView(),
    );
  }
}

class CreateObservationView extends StatefulWidget {
  const CreateObservationView({super.key});

  @override
  State<CreateObservationView> createState() => _CreateObservationViewState();
}

class _CreateObservationViewState extends State<CreateObservationView> {
  final TextEditingController _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final currentUserBloc = context.read<CurrentUserBloc>().state.user;
    final createBloc = context.watch<CreateObservationBloc>();

    return BlocListener<CreateObservationBloc, CreateObservationState>(
      listener: (context, state) {
        if (state.status == CreateObservationStatus.success) {
          showDialog(
              context: context,
              builder: (ctx) {
                return DialogYesNo(
                  title: 'Mở lớp dự giờ thành công',
                  content: 'Giáo viên Anh Văn - ${currentUserBloc.name}',
                  typeDialog: 1,
                  yesText: 'Xác nhận',
                  onYes: () {
                    context.pop();
                  },
                );
              });
        }
      },
      child: Listener(
        onPointerDown: (event) {
          final currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus && currentFocus.hasFocus) {
            FocusManager.instance.primaryFocus?.unfocus();
          }
        },
        child: Scaffold(
          body: BackGroundContainer(
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 100),
                  height: SizeUtils.height,
                  padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                  decoration: const BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: SingleChildScrollView(
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
                        BlocBuilder<CreateObservationBloc,
                            CreateObservationState>(
                          builder: (context, state) {
                            return SelectDate(
                              isHideIcon: true,
                              onDateChanged: (date) {
                                createBloc.add(DateChanged(time: date));
                              },
                            );
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        BlocBuilder<CreateObservationBloc,
                            CreateObservationState>(
                          builder: (context, state) {
                            return SelectFiledRadio(
                              onValueChanged: (value) {
                                createBloc.add(SubjectChanged(subject: value));
                              },
                              data: mockSubjectData,
                              hintText: 'Môn',
                            );
                          },
                        ),
                        const SizedBox(height: 10),
                        BlocBuilder<CreateObservationBloc,
                            CreateObservationState>(
                          builder: (context, state) {
                            return SelectFiledRadio(
                                onValueChanged: (value) {
                                  createBloc
                                      .add(ClassChanged(className: value));
                                },
                                data: mockClassData,
                                hintText: 'Lớp');
                          },
                        ),
                        const SizedBox(height: 10),
                        BlocBuilder<CreateObservationBloc,
                            CreateObservationState>(
                          builder: (context, state) {
                            return SelectFiledRadio(
                              onValueChanged: (value) {
                                createBloc.add(PeriodChanged(period: value));
                              },
                              data: mockTietData,
                              hintText: 'Tiết',
                            );
                          },
                        ),

                        const SizedBox(height: 10),
                        // Thong tin du gio
                        Text(
                          'Thông tin dự giờ',
                          style: AppTextStyles.bold16(
                              color: AppColors.blueForgorPassword),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.15,
                          width: double.infinity,
                          child: BlocBuilder<CreateObservationBloc,
                              CreateObservationState>(
                            builder: (context, state) {
                              return TextField(
                                onChanged: (value) {
                                  createBloc.add(InfoChanged(info: value));
                                },
                                controller: _contentController,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(10.0),
                                  isDense: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        color: AppColors.blueGray100),
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        color: AppColors.blueGray100),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        color: AppColors.blueGray100),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        color: AppColors.blueGray100),
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
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 10),
                        // Giao vien tham gia
                        Text(
                          'GV: ${currentUserBloc.name}',
                          style: AppTextStyles.normal14(
                            color: AppColors.gray600,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Giáo viên tham gia',
                          style: AppTextStyles.bold16(
                              color: AppColors.blueForgorPassword),
                        ),
                        const SizedBox(height: 10),
                        BlocBuilder<CreateObservationBloc,
                            CreateObservationState>(
                          builder: (context, state) {
                            return GestureDetector(
                              onTap: () {
                                //TODO: Show dialog select teachers
                                showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: const BoxDecoration(
                                        color: AppColors.white,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20),
                                        ),
                                      ),
                                      height: SizeUtils.height * 0.5,
                                      child: ListView.builder(
                                        // itemCount: state.teacherList.length,
                                        itemCount: mockTeacherItems.length,
                                        itemBuilder: (context, index) {
                                          return GestureDetector(
                                            onTap: () {
                                              createBloc.add(
                                                TeacherSelected(
                                                  teacher:
                                                      // state.teacherList[index],
                                                      mockTeacherItems[index],
                                                ),
                                              );
                                              Navigator.pop(context);
                                            },
                                            child: CardInfoAddObservation(
                                              teacherInfo:
                                                  mockTeacherItems[index],
                                            ),
                                          );
                                        },
                                      ),
                                    );
                                  },
                                );
                              },
                              child: DottedBorder(
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
                                      style: AppTextStyles.bold16(
                                          color: AppColors.gray400),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 10),
                        BlocBuilder<CreateObservationBloc,
                            CreateObservationState>(
                          buildWhen: (previous, current) =>
                              previous.selectedTeachers !=
                              current.selectedTeachers,
                          builder: (context, state) {
                            return state.selectedTeachers.isEmpty
                                ? const SizedBox()
                                : Padding(
                                    padding: const EdgeInsets.only(bottom: 80),
                                    child: Column(
                                      children: state.selectedTeachers.map(
                                        (item) {
                                          return CardInfoAddObservation(
                                            teacherInfo: item,
                                            onRemove: () {
                                              //TODO: Handle remove teacher from selected list
                                              createBloc.add(
                                                TeacherRemoved(teacher: item),
                                              );
                                            },
                                          );
                                        },
                                      ).toList(),
                                    ),
                                  );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
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
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    color: Colors.transparent,
                    padding: const EdgeInsets.all(16.0),
                    child: BlocBuilder<CreateObservationBloc,
                        CreateObservationState>(
                      builder: (context, state) {
                        return ElevatedButton(
                            onPressed: () {
                              context
                                  .read<CreateObservationBloc>()
                                  .add(ObservationCreated());
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  AppColors.observationStatusMyObsBG,
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
                                  style: AppTextStyles.bold16(
                                      color: AppColors.white),
                                ),
                              ],
                            ));
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
