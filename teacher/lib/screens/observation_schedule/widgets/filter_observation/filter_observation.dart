import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:repository/repository.dart';
import 'package:teacher/app_config/router_configuration.dart';
import 'package:teacher/common_bloc/current_user/current_user_bloc.dart';
import 'package:teacher/components/app_bar/screen_app_bar.dart';
import 'package:teacher/components/back_ground_container.dart';
import 'package:teacher/screens/observation_schedule/widgets/card_filter_observation.dart';
import 'package:teacher/screens/observation_schedule/widgets/filter_observation/bloc/filter_observation_bloc.dart';

class FilterObservation extends StatefulWidget {
  const FilterObservation({
    super.key,
  });
  static const routeName = '/filter_observation';

  @override
  State<FilterObservation> createState() => _FilterObservationState();
}

class _FilterObservationState extends State<FilterObservation> {
  @override
  Widget build(BuildContext context) {
    final currentUserBloc = context.read<CurrentUserBloc>().state.user;

    return BlocProvider(
      create: (context) => FilterObservationBloc(
        appFetchApiRepo: context.read<AppFetchApiRepository>(),
        userKey: currentUserBloc.user_key,
        schoolId: currentUserBloc.school_id,
        learnYear: currentUserBloc.learnYear,
      ),
      child: Scaffold(
        body: BackGroundContainer(
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Positioned.fill(
                top: -20,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 8, 0),
                  child: ScreensAppBar(
                    'Bộ lọc',
                    canGoBack: true,
                    onBack: () {
                      context.pop();
                    },
                    actionWidget: CircleAvatar(
                      backgroundColor: Colors.white.withOpacity(0.3),
                      maxRadius: 20,
                      child: IconButton(
                        // padding: EdgeInsets.zero,
                        icon: const Icon(Icons.refresh_outlined,
                            color: AppColors.white),
                        onPressed: () {
                          // context.pop();
                        },
                      ),
                    ),
                  ),
                ),
              ),
              BlocListener<FilterObservationBloc, FilterObservationState>(
                listener: (context, state) {},
                child: Container(
                    margin: const EdgeInsets.only(top: 100),
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    decoration: const BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Column(
                      children: [
                        BlocBuilder<FilterObservationBloc,
                            FilterObservationState>(
                          builder: (context, state) {
                            return CardFilterObservation(
                              title: 'Ngày',
                              typeField: 1,
                              onDateChanged: (date) {
                                final formattedDate =
                                    DateFormat('dd-MM-yyyy').format(date);
                                context
                                    .read<FilterObservationBloc>()
                                    .add(DateChanged(formattedDate));
                              },
                            );
                          },
                        ),
                        BlocBuilder<FilterObservationBloc,
                            FilterObservationState>(
                          builder: (context, state) {
                            return state.status ==
                                    FilterObservationStatus.loading
                                ? const SizedBox()
                                : CardFilterObservation(
                                    title: 'Giáo viên',
                                    typeField: 2,
                                    options: state.listTeacher,
                                    onTeacherChanged: (value) {
                                      context
                                          .read<FilterObservationBloc>()
                                          .add(TeacherChanged(value));
                                    },
                                  );
                          },
                        ),
                        // CardFilterObservation(
                        //   title: 'Lớp',
                        //   typeField: 3,
                        // ),
                        // CardFilterObservation(
                        //   title: 'Tiết học',
                        //   typeField: 4,
                        // ),
                      ],
                    )),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  color: Colors.transparent,
                  padding: const EdgeInsets.all(16.0),
                  child: BlocBuilder<FilterObservationBloc,
                      FilterObservationState>(
                    builder: (context, state) {
                      return ElevatedButton(
                        onPressed: () {
                          context.pop({
                            'date': state.date,
                            'teacher': state.teacher,
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.observationStatusMyObsBG,
                          minimumSize: const Size(double.infinity, 50),
                        ),
                        child: Text(
                          'Áp dụng',
                          style: AppTextStyles.bold16(color: AppColors.white),
                        ),
                      );
                    },
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
