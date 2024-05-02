import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:iportal2/app_config/router_configuration.dart';
import 'package:iportal2/common_bloc/current_user/bloc/current_user_bloc.dart';
import 'package:iportal2/components/app_bar/app_bar.dart';
import 'package:iportal2/components/app_skeleton.dart';
import 'package:iportal2/components/back_ground_container.dart';
import 'package:iportal2/components/custom_refresh.dart';
import 'package:iportal2/components/empty_screen.dart';
import 'package:iportal2/resources/app_colors.dart';
import 'package:iportal2/resources/app_text_styles.dart';
import 'package:iportal2/screens/bus/bloc/bus_bloc.dart';
import 'package:iportal2/screens/bus/bus_card/card_bus_item.dart';
import 'package:iportal2/screens/home/widgets/instruction_notebook/instruction_notebook_view.dart';
import 'package:repository/repository.dart';

class BusScreen extends StatelessWidget {
  const BusScreen({super.key});
  static const routeName = '/bus';
  @override
  Widget build(BuildContext context) {
    final currentUser = context.read<CurrentUserBloc>().state.user;
    return BlocProvider(
      create: (context) => BusBloc(
        context.read<AppFetchApiRepository>(),
        pupilId: currentUser.pupil_id,
        schoolId: currentUser.school_id,
        schoolBrand: currentUser.school_brand,
      ),
      child: const BusView(),
    );
  }
}

class BusView extends StatelessWidget {
  const BusView({super.key});

  @override
  Widget build(BuildContext context) {
    return BackGroundContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ScreenAppBar(
            title: 'Xe đưa rước',
            canGoback: true,
            onBack: () {
              context.pop();
            },
          ),
          Flexible(
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
              child: Column(
                children: [
                  // SelectChild(),
                  // const SizedBox(height: 12),
                  SelectDate(
                    onDateChanged: (date) => context.read<BusBloc>().add(
                          BusChangedDate(date: date),
                        ),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: BlocBuilder<BusBloc, BusState>(
                      builder: (context, state) {
                        final busSchedules = state.busSchedules;
                        final isLoading = state.status == BusStatus.loading;
                        final isEmptyData = busSchedules.isEmpty && !isLoading;

                        return CustomRefresh(
                          onRefresh: () async {
                            context.read<BusBloc>().add(BusFetchedSchedules());
                          },
                          child: Stack(
                            children: [
                              ListView(),
                              AppSkeleton(
                                isLoading: isLoading,
                                skeleton: const InstructrionSkeleton(),
                                child: isEmptyData
                                    ? const Center(
                                        child: EmptyScreen(
                                            text: 'Chưa có dữ liệu'))
                                    : ListView.builder(
                                        padding: EdgeInsets.zero,
                                        cacheExtent: 1000,
                                        itemCount: busSchedules.length,
                                        itemBuilder: (context, index) {
                                          return CardBusItem(
                                            busSchedule: busSchedules[index],
                                          );
                                        },
                                      ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class SelectDate extends StatefulWidget {
  const SelectDate({super.key, required this.onDateChanged});

  final Function(DateTime date) onDateChanged;

  @override
  State<SelectDate> createState() => _SelectDateState();
}

class _SelectDateState extends State<SelectDate> {
  DateTime now = DateTime.now();

  DateFormat formatDate = DateFormat("dd/MM/yyyy");
  late String datePicked;

  @override
  void initState() {
    super.initState();
    datePicked = formatDate.format(now);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          helpText: 'Chọn ngày',
          cancelText: 'Trở về',
          confirmText: 'Xong',
          initialDate: formatDate.parse(datePicked),
          firstDate: DateTime(now.year, now.month, now.day - 7),
          lastDate: DateTime(now.year, now.month, now.day + 7),
          builder: (context, child) {
            return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: const ColorScheme.light(
                  primary: AppColors.brand600,
                  secondary: AppColors.white,
                ),
              ),
              child: child!,
            );
          },
        );

        if (pickedDate != null) {
          String formattedDate = formatDate.format(pickedDate);
          widget.onDateChanged(pickedDate);
          setState(() {
            datePicked = formattedDate;
          });
        } else {}
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: AppColors.white,
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: AppColors.blueGray100),
            borderRadius: BorderRadius.circular(8),
          ),
          shadows: const [
            BoxShadow(
              color: AppColors.gray9000c,
              blurRadius: 2,
              offset: Offset(0, 1),
            )
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.calendar_month_outlined,
                    size: 20,
                    color: AppColors.gray500,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: SizedBox(
                      child: Text(
                        datePicked,
                        style: AppTextStyles.normal16(color: AppColors.gray500),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            const Icon(
              Icons.keyboard_arrow_down_rounded,
              size: 24,
              color: AppColors.gray900,
            ),
          ],
        ),
      ),
    );
  }
}
