import 'package:core/core.dart';
import 'package:core/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:skeletons/skeletons.dart';
import 'package:teacher/components/app_bar/app_bar.dart';
import 'package:teacher/components/app_skeleton.dart';
import 'package:teacher/components/back_ground_container.dart';
import 'package:teacher/components/custom_refresh.dart';
import 'package:teacher/components/empty_screen.dart';
import 'package:teacher/model/menu_in_week_data_model.dart';
import 'package:teacher/model/menu_in_week_model.dart';
import 'package:teacher/model/user_info.dart';
import 'package:teacher/repository/menu_repository/menu_repositories.dart';
import 'package:teacher/src/screens/menu/bloc/menu_bloc.dart';
import 'package:teacher/src/screens/menu/widgets/tab_menu.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key, required this.userInfo});
  static const routeName = '/menu';
  final UserInfo userInfo;
  @override
  Widget build(BuildContext context) {
    final menuBloc = MenuBloc(menuRepository: Injection.get<MenuRepository>());
    menuBloc.add(GetMenu(
        txtDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
        date: DateTime.now(),
        user_key: userInfo.userKey ?? ''));
    return BlocProvider.value(
      value: menuBloc,
      child: MenuView(
        userInfo: userInfo,
      ),
    );
  }
}

class MenuView extends StatefulWidget {
  const MenuView({super.key, required this.userInfo});
  final UserInfo userInfo;
  @override
  State<MenuView> createState() => _MenuViewState();
}

class _MenuViewState extends State<MenuView> {
  late String currentDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
  List<MenuInWeekDataModel?>? filteredData;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MenuBloc, MenuState>(builder: (context, state) {
      final menu = state.menu;
      final isLoading = state.menuStatus == MenuStatus.init;

      filteredData = menu.listMenuInWeekData
          ?.where((item) => item.thucDonTuanNgay == currentDate)
          .toList();
      final date = state.date;
      final screenHeight = MediaQuery.of(context).size.height;
      final desiredHeight = screenHeight * 1;
      return Scaffold(
        body: BackGroundContainer(
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
                          skeleton: SizedBox(
                              height: 500,
                              child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                padding: const EdgeInsets.all(0),
                                itemCount: 5,
                                itemBuilder: (context, index) => Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 12, 0, 12),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: index == 4
                                          ? BorderSide.none
                                          : const BorderSide(
                                              color: AppColors.gray300),
                                    ),
                                  ),
                                  child: SkeletonItem(
                                      child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: SkeletonParagraph(
                                              style: SkeletonParagraphStyle(
                                                  lineStyle: SkeletonLineStyle(
                                                randomLength: true,
                                                height: 10,
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              )),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  )),
                                ),
                              )),
                          isLoading: isLoading,
                          child: CustomRefresh(
                            onRefresh: () async {
                              context.read<MenuBloc>().add(GetMenu(
                                    txtDate: DateFormat('dd-MM-yyyy')
                                        .format(DateTime.now()),
                                    date: DateTime.now(),
                                    user_key: widget.userInfo.userKey ?? '',
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
                                        userInfo: widget.userInfo,
                                        date: date ?? DateTime.now(),
                                        weekSchedule: menu,
                                      ),
                                      const SizedBox(height: 8),
                                      if (menu.listMenuInWeekData != null)
                                        TabMenu(
                                            dataMenu:
                                                menu.listMenuInWeekData ?? []),
                                      if (menu.listMenuInWeekData == null)
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

  DateFormat formatDate = DateFormat("EEEE, dd/MM/yyyy", 'vi_VN');
  DateFormat formatDateDrill = DateFormat("dd-MM-yyyy", 'vi_VN');
  late String datePickedFormat;

  @override
  void initState() {
    super.initState();
    if (widget.datePicked != null) {
      datePickedFormat = formatDate.format(widget.datePicked!);
    } else {
      datePickedFormat = formatDate.format(now);
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
          String formattedDate = formatDate.format(pickedDate);
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
      {super.key,
      required this.weekSchedule,
      required this.date,
      required this.userInfo});
  final MenuInWeekModel weekSchedule;
  final DateTime date;
  final UserInfo userInfo;
  @override
  State<MenuSelectWidget> createState() => _MenuSelectWidgetState();
}

class _MenuSelectWidgetState extends State<MenuSelectWidget> {
  DateTime now = DateTime.now();

  DateFormat formatDate = DateFormat("dd/MM/yyyy");
  late String datePicked;

  @override
  void initState() {
    super.initState();
    datePicked = formatDate.format(DateTime.now());
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
                        txtDate: widget.weekSchedule.txtPreWeek ??
                            DateTime.now().toString(),
                        user_key: widget.userInfo.userKey ?? '',
                      ));
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
                      String formattedDate =
                          DateFormat('dd-MM-yyy').format(pickedDate);
                      setState(() {
                        datePicked = formattedDate;
                        context.read<MenuBloc>().add(GetMenu(
                              txtDate: datePicked,
                              date: pickedDate,
                              user_key: widget.userInfo.userKey ?? '',
                            ));
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
                      user_key: widget.userInfo.userKey ?? '',
                      txtDate: widget.weekSchedule.txtNextWeek ??
                          DateTime.now().toString()));
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
