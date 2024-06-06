import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:repository/repository.dart';
import 'package:teacher/app_config/router_configuration.dart';
import 'package:teacher/common_bloc/current_user/current_user_bloc.dart';
import 'package:teacher/components/app_bar/app_bar.dart';
import 'package:teacher/components/back_ground_container.dart';
import 'package:teacher/screens/bus/bloc/bus_bloc.dart';
import 'package:teacher/screens/bus/bus_card/card_bus.dart';
import 'package:teacher/screens/bus/widgets/week_select.dart';

class BusScreen extends StatelessWidget {
  const BusScreen({super.key});
  static const routeName = '/bus';
  @override
  Widget build(BuildContext context) {
    final currentUserBloc = context.read<CurrentUserBloc>();
    final appFetchApiRepository = context.read<AppFetchApiRepository>();
    return BlocProvider.value(
      value: BusBloc(
        userRepository: context.read<UserRepository>(),
        appFetchApiRepository: appFetchApiRepository,
        currentUserBloc: currentUserBloc,
      ),
      child: const BusView(),
    );
  }
}

class BusView extends StatefulWidget {
  const BusView({super.key});

  @override
  State<BusView> createState() => _BusViewState();
}

class _BusViewState extends State<BusView> {
  late DateTime dateSelect = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BusBloc, BusState>(builder: (context, state) {
      final busData = state.busSchedules;
      final isLoading = state.status == BusStatus.loading;

      return BackGroundContainer(
        child: Column(
          children: [
            ScreenAppBar(
              title: 'Lịch xe đưa đón',
              canGoback: true,
              onBack: () {
                context.pop();
              },
            ),
            const SizedBox(height: 6),
            Expanded(
              child: Container(
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
                decoration: const BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    WeekSelect(
                      date: DateTime.now(),
                      onDatePicked: (date) {
                        setState(() {
                          dateSelect = date;
                          context
                              .read<BusBloc>()
                              .add(BusChangedDate(date: date.yyyyMMdd));
                        });
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      child: Row(
                        children: [
                          Text(
                            dateSelect.ddMMyyyyDash,
                            style: AppTextStyles.normal16(
                              color: AppColors.brand600,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Text(
                              dateSelect.eeee,
                              style: AppTextStyles.normal14(
                                color: AppColors.gray400,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: AppSkeleton(
                        isLoading: isLoading,
                        child: busData.isNotEmpty
                            ? ListView.builder(
                                padding: EdgeInsets.zero,
                                itemCount: busData.length,
                                itemBuilder: (context, index) {
                                  final busScheduleData = busData[index];
                                  return CardBus(
                                    busScheduleTeacher: busScheduleData,
                                  );
                                },
                              )
                            : const Center(
                                child: EmptyScreen(
                                    text: 'Bạn không có lịch xe đưa đón'),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
