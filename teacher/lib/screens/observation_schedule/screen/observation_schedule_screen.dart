import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:repository/repository.dart';
import 'package:teacher/app_config/router_configuration.dart';
import 'package:teacher/common_bloc/current_user/current_user_bloc.dart';

import 'package:teacher/components/app_bar/app_bar.dart';
import 'package:teacher/components/back_ground_container.dart';
import 'package:teacher/resources/assets.gen.dart';
import 'package:teacher/screens/observation_schedule/bloc/observation_schedule_bloc.dart';
import 'package:teacher/screens/observation_schedule/mock_data/subject_mock.dart';
import 'package:teacher/screens/observation_schedule/screen/create_observation/create_observation_screen.dart';
import 'package:teacher/screens/observation_schedule/screen/observation_detail/overvation_detail_screen.dart';
import 'package:teacher/screens/observation_schedule/widgets/card_observation.dart';
import 'package:teacher/screens/observation_schedule/widgets/filter_observation.dart';

class ObservationSchedule extends StatelessWidget {
  const ObservationSchedule({super.key});
  static const routeName = '/observation_schedule';

  @override
  Widget build(BuildContext context) {
    final currentUserBloc = context.read<CurrentUserBloc>().state.user;

    return BlocProvider(
      create: (context) => ObservationScheduleBloc(
        appFetchApiRepo: context.read<AppFetchApiRepository>(),
        userKey: currentUserBloc.user_key,
        schoolId: currentUserBloc.school_id,
      )..add(ObservationScheduleInit()),
      child: const ObservationScheduleView(),
    );
  }
}

class ObservationScheduleView extends StatefulWidget {
  const ObservationScheduleView({super.key});

  @override
  State<ObservationScheduleView> createState() =>
      _ObservationScheduleViewState();
}

class _ObservationScheduleViewState extends State<ObservationScheduleView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackGroundContainer(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: ScreenAppBar(
                title: 'Lịch dự giờ',
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
              child: BlocListener<ObservationScheduleBloc,
                  ObservationScheduleState>(
                listener: (context, state) {},
                child: BlocBuilder<ObservationScheduleBloc,
                    ObservationScheduleState>(
                  builder: (context, state) {
                    return AppSkeleton(
                      isLoading:
                          state.status == ObservationScheduleStatus.loading,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // seach bar & filter button
                          Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  child: TextField(
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.all(5),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: const BorderSide(
                                            color: AppColors.gray400),
                                      ),
                                      fillColor: AppColors.gray400,
                                      hintText: 'Tra cứu lịch dự giờ',
                                      prefixIcon: Image.asset(
                                        Assets.images.search.path,
                                        color: AppColors.black,
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    showGeneralDialog(
                                      context: context,
                                      routeSettings: const RouteSettings(
                                          name: FilterObservation.routeName),
                                      pageBuilder: (context, animation,
                                              secondaryAnimation) =>
                                          const FilterObservation(),
                                    );
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: AppColors.white,
                                      borderRadius: BorderRadius.circular(30),
                                      border: Border.all(
                                        color: AppColors.gray400,
                                      ),
                                    ),
                                    child: Assets.icons.filter.svg(
                                      colorFilter: const ColorFilter.mode(
                                        AppColors.gray500,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          // list of observation schedule
                          Row(
                            children: [
                              Text(
                                DateFormat('dd MMM, yyyy', 'vi_VN')
                                    .format(DateTime.now()),
                                style: AppTextStyles.bold16(
                                  color: AppColors.blueForgorPassword,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                'Thứ ${DateTime.now().weekday + 1}',
                                style: AppTextStyles.normal16(
                                  color: AppColors.gray400,
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              itemBuilder: (ctx, index) {
                                final it = listMockSubjectData[index];
                                return GestureDetector(
                                  onTap: () {
                                    context.push(
                                      ObservationDetailScreen(
                                        data: it,
                                        typeObservation: it.typeObservation!,
                                      ),
                                    );
                                  },
                                  child: CardObservation(
                                    isFirstIndex:
                                        it.id == listMockSubjectData.first.id,
                                    isLastIndex:
                                        it.id == listMockSubjectData.last.id,
                                    nameObservation: it.nameObservation ?? "",
                                    time: it.time ?? "",
                                    descriptionSubjectLesson:
                                        it.descriptionSubjectLesson ?? "",
                                    tietNum: '${it.subjectModel?.tietNum}',
                                    teacherName:
                                        it.subjectModel?.teacherName ?? "",
                                    typeObservation: it.typeObservation ?? 0,
                                  ),
                                );
                              },
                              itemCount: listMockSubjectData.length,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: Colors.transparent,
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                    onPressed: () {
                      context.push(
                        const CreateObservationScreen(),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.observationStatusMyObsBG,
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.add,
                          color: AppColors.white,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'Mở lớp dự giờ',
                          style: AppTextStyles.bold16(color: AppColors.white),
                        ),
                      ],
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
