import 'package:core/core.dart';
import 'package:flutter/material.dart';

import 'package:iportal2/common_bloc/current_user/bloc/current_user_bloc.dart';
import 'package:iportal2/components/app_bar/app_bar.dart';
import 'package:iportal2/components/back_ground_container.dart';
import 'package:iportal2/components/custom_refresh.dart';
import 'package:iportal2/screens/menu/bloc/menu_bloc.dart';
import 'package:iportal2/screens/menu/widgets/tab_menu.dart';
import 'package:repository/repository.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});
  static const routeName = '/menu';
  @override
  Widget build(BuildContext context) {
    final userRepository = context.read<UserRepository>();
    final appFetchApiRepository = context.read<AppFetchApiRepository>();
    final menuBloc = MenuBloc(
        appFetchApiRepo: appFetchApiRepository,
        currentUserBloc: context.read<CurrentUserBloc>(),
        userRepository: userRepository);
    menuBloc.add(GetMenu(
      txtDate: DateTime.now().ddMMyyyyDash,
      date: DateTime.now(),
    ));
    return BlocProvider.value(
      value: menuBloc,
      child: const MenuView(),
    );
  }
}

class MenuView extends StatefulWidget {
  const MenuView({super.key});

  @override
  State<MenuView> createState() => _MenuViewState();
}

class _MenuViewState extends State<MenuView> {
  late String currentDate = DateTime.now().ddMMyyyyDash;
  List<DataMenu?>? filteredData;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MenuBloc, MenuState>(builder: (context, state) {
      final menu = state.menu;
      final isLoading = state.menuStatus == MenuStatus.init;

      filteredData =
          menu.data.where((item) => item.thucDonNgay == currentDate).toList();
      final date = state.date;
      final screenHeight = MediaQuery.of(context).size.height;
      final desiredHeight = screenHeight * 1;
      return BackGroundContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ScreenAppBar(
              title: 'Thực đơn',
              canGoback: true,
              onBack: () {
                Navigator.pop(context);
              },
            ),
            Flexible(
              child: Container(
                padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
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
                    Expanded(
                      child: AppSkeleton(
                        isLoading: isLoading,
                        child: CustomRefresh(
                          onRefresh: () async {
                            context.read<MenuBloc>().add(GetMenu(
                                  txtDate: DateTime.now().ddMMyyyyDash,
                                  date: DateTime.now(),
                                ));
                          },
                          child: Stack(
                            children: [
                              SizedBox(
                                height: desiredHeight,
                                width: double.infinity,
                                child: Column(
                                  children: [
                                    MenuSelectWidget(
                                      date: date ?? DateTime.now(),
                                      weekSchedule: menu,
                                    ),
                                    const SizedBox(height: 8),
                                    if (menu.data.isNotEmpty)
                                      TabMenu(dataMenu: menu.data),
                                    if (menu.data.isEmpty)
                                      const Expanded(
                                        child: Center(
                                          child: EmptyScreen(
                                              text: 'Bạn chưa thực đơn mới'),
                                        ),
                                      )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      );
    });
  }
}

class SelectDate extends StatefulWidget {
  const SelectDate({
    super.key,
    this.onDatePicked,
    this.datePicked,
  });

  final Function(DateTime date)? onDatePicked;
  final DateTime? datePicked;

  @override
  State<SelectDate> createState() => _SelectDateState();
}

class _SelectDateState extends State<SelectDate> {
  DateTime now = DateTime.now();

  // DateFormat formatDate = DateFormat("EEEE, dd/MM/yyyy", 'vi_VN');
  // DateFormat formatDateDrill = DateFormat("dd-MM-yyyy", 'vi_VN');
  late String datePickedFormat;

  @override
  void initState() {
    super.initState();
    if (widget.datePicked != null) {
      datePickedFormat = widget.datePicked!.EEEEddMMyyyyVN;
    } else {
      datePickedFormat = now.EEEEddMMyyyyVN;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        DateTime now = DateTime.now();
        DateTime firstDayOfWeek = now.subtract(Duration(days: now.weekday - 1));
        DateTime lastDayOfWeek = now.add(Duration(days: 7 - now.weekday));

        DateTime? pickedDate = await showDatePicker(
          context: context,
          helpText: 'Chọn ngày',
          cancelText: 'Trở về',
          confirmText: 'Xong',
          initialDate: now,
          firstDate: firstDayOfWeek,
          lastDate: lastDayOfWeek,
          initialEntryMode: DatePickerEntryMode.calendarOnly,
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
          String formattedDate = pickedDate.EEEEddMMyyyyVN;
          setState(() {
            datePickedFormat = formattedDate;
          });
          widget.onDatePicked?.call(pickedDate);
        } else {}
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: AppColors.white,
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: AppColors.gray300),
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
                        datePickedFormat,
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

class MenuSelectWidget extends StatefulWidget {
  const MenuSelectWidget(
      {super.key, required this.weekSchedule, required this.date});
  final Menu weekSchedule;
  final DateTime date;
  @override
  State<MenuSelectWidget> createState() => _MenuSelectWidgetState();
}

class _MenuSelectWidgetState extends State<MenuSelectWidget> {
  DateTime now = DateTime.now();

  late String datePicked;

  @override
  void initState() {
    super.initState();
    datePicked = DateTime.now().ddMMyyyyDash;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
          decoration: const BoxDecoration(
            color: AppColors.gray100,
            borderRadius: BorderRadius.all(Radius.circular(40)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  // context.read<WeekScheduleBloc>().add(GetWeekSchedule(
                  //     date: DateTime.now(),
                  //     txtDate: widget.weekSchedule?.txtPreWeek ?? ''));
                  context.read<MenuBloc>().add(GetMenu(
                      date: DateTime.now(),
                      txtDate: widget.weekSchedule.txtPreWeek));
                },
                child: const Padding(
                  padding: EdgeInsets.all(4),
                  child: Icon(
                    Icons.arrow_back_ios_rounded,
                    size: 20,
                    color: AppColors.gray400,
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      helpText: 'Chọn ngày',
                      cancelText: 'Trở về',
                      confirmText: 'Xong',
                      initialDate: widget.date,
                      firstDate: DateTime(now.year - 3, now.month),
                      lastDate: DateTime(now.year + 1, now.month),
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
                      String formattedDate = pickedDate.ddMMyyyyDash;
                      setState(() {
                        datePicked = formattedDate;
                        context.read<MenuBloc>().add(
                            GetMenu(txtDate: datePicked, date: pickedDate));
                      });
                    } else {}
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Tuần ${widget.weekSchedule.txtWeek} ',
                          style: AppTextStyles.semiBold14(
                              color: AppColors.brand600)),
                      Text(
                        '(${widget.weekSchedule.txtBeginDay} - ${widget.weekSchedule.txtEndDay})',
                        style: AppTextStyles.normal14(color: AppColors.gray500),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  context.read<MenuBloc>().add(GetMenu(
                      date: DateTime.now(),
                      txtDate: widget.weekSchedule.txtNexrWeek));
                },
                child: const Padding(
                  padding: EdgeInsets.all(4),
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 20,
                    color: AppColors.gray400,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
