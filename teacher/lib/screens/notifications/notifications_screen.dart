import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:repository/repository.dart';
import 'package:teacher/app.dart';
import 'package:teacher/app_config/router_configuration.dart';
import 'package:teacher/common_bloc/current_user/current_user_bloc.dart';
import 'package:teacher/components/app_bar/app_bar.dart';
import 'package:teacher/components/back_ground_container.dart';
import 'package:teacher/components/custom_refresh.dart';
import 'package:teacher/screens/notifications/bloc/notification_bloc.dart';
import 'package:teacher/screens/notifications/create/noti_create_screen.dart';
import 'package:teacher/screens/notifications/detail/notification_detail_screen.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen>
    with SingleTickerProviderStateMixin {
  String selectedFilter = "";
  bool isNotRead = false;
  List<String> tabs = ['Đã nhận', 'Đã gửi'];
  late NotificationBloc notiBloc;
  late TabController tabBarController;

  @override
  void initState() {
    super.initState();
    notiBloc = NotificationBloc(
      context.read<AppFetchApiRepository>(),
      currentUserBloc: context.read<CurrentUserBloc>(),
    );
    tabBarController = TabController(
      length: 2,
      vsync: this,
    );
  }

  void handleSelectedOptionChanged(String newOption) {
    setState(() {
      selectedFilter = newOption;
    });
  }

  List<Widget> _buildTabs() {
    return tabs.map((title) {
      return Tab(
        height: 32,
        child: Center(
          child: Text(
            title,
            textAlign: TextAlign.center,
          ),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: notiBloc,
      child: BlocBuilder<NotificationBloc, NotificationState>(
        builder: (context, state) {
          final listReceivedNoti = state.notificationData.data;

          final isReiceivedLoading = state.status == NotificationStatus.loading;
          final isReiceivedEmpty =
              listReceivedNoti.isEmpty && !isReiceivedLoading;

          final listSentNoti = state.sentNoti.data;
          final isSentLoading = state.status == NotificationStatus.loadingSent;
          final isSentEmpty = listSentNoti.isEmpty && !isSentLoading;

          tabs = [
            'Đã nhận (${listReceivedNoti.length})',
            'Đã gửi (${listSentNoti.length})'
          ];

          return BackGroundContainer(
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const ScreenAppBar(
                      title: 'Thông báo ',
                    ),
                    InkWell(
                      onTap: () {
                        mainNavKey.currentContext?.push(const NotiCreateNew());
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 16, top: 40),
                        child: const Icon(
                          Icons.add_circle_outline_sharp,
                          color: AppColors.white,
                          size: 30,
                        ),
                      ),
                    )
                  ],
                ),
                DefaultTabController(
                  length: tabs.length,
                  child: TabBar(
                    padding: const EdgeInsets.all(0),
                    labelPadding: EdgeInsets.zero,
                    labelColor: AppColors.brand600,
                    tabAlignment: TabAlignment.fill,
                    unselectedLabelColor: AppColors.white,
                    dividerColor: AppColors.gray100,
                    labelStyle:
                        AppTextStyles.semiBold16(color: AppColors.brand600),
                    unselectedLabelStyle:
                        AppTextStyles.semiBold16(color: AppColors.gray500),
                    indicator: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                      ),
                      color: AppColors.gray100,
                    ),
                    tabs: _buildTabs(),
                    onTap: (value) {
                      tabBarController.animateTo(value);
                    },
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: tabBarController,
                    children: [
                      ReceivedView(
                        listNoti: listReceivedNoti,
                        isLoading: isReiceivedLoading,
                        isEmptyData: isReiceivedEmpty,
                      ),
                      ReceivedView(
                        isSentView: true,
                        listNoti: listSentNoti,
                        isLoading: isSentLoading,
                        isEmptyData: isSentEmpty,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // @override
  // bool get wantKeepAlive => true;
}

class ReceivedView extends StatefulWidget {
  const ReceivedView({
    super.key,
    required this.isLoading,
    required this.listNoti,
    required this.isEmptyData,
    this.isSentView = false,
  });

  final bool isLoading;
  final List<NotificationItem> listNoti;
  final bool isEmptyData;
  final bool isSentView;

  @override
  State<ReceivedView> createState() => _ReceiveViewState();
}

class _ReceiveViewState extends State<ReceivedView> {
  bool isNotRead = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final notiBloc = context.read<NotificationBloc>();
    final isSentView = widget.isSentView;

    final listNotiW = List.generate(widget.listNoti.length, (index) {
      final notiItem = widget.listNoti[index];
      final isNotView = (notiItem.viewedAt ?? '').isEmpty && !isSentView;
      final createdAt = DateTime.parse(notiItem.createdAt);
      final formattedDate =
          DateFormat('EEEE, dd/MM/yyyy - HH:mm', 'vi_VN').format(createdAt);

      return InkWell(
        onTap: () {
          context.push(NotiDetailScreen(
            id: notiItem.id,
          ));
        },
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: isNotView ? AppColors.gray100 : Colors.white,
                border: Border(
                  bottom: BorderSide(
                    color: index == widget.listNoti.length - 1
                        ? AppColors.white
                        : AppColors.gray300,
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      notiItem.title,
                      style: AppTextStyles.semiBold16(color: AppColors.gray800),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      formattedDate,
                      style: AppTextStyles.normal14(
                          color: AppColors.gray500, height: 18 / 14),
                    ),
                  ],
                ),
              ),
            ),
            if (isNotView)
              Positioned(
                top: 16,
                right: 12,
                child: SvgPicture.asset(
                  'assets/icons/read-indicator-noti.svg',
                  width: 8,
                  height: 8,
                ),
              ),
          ],
        ),
      );
    });

    return Container(
      decoration: const BoxDecoration(color: AppColors.white),
      child: CustomRefresh(
        onRefresh: () async {
          if (isSentView) {
            notiBloc.add(NotificationFetchSentNoti());
          } else {
            notiBloc.add(NotificationFetchData());
          }
        },
        child: Stack(
          children: [
            ListView(),
            AppSkeleton(
              isLoading: widget.isLoading,
              child: widget.isEmptyData
                  ? Center(
                      child: EmptyScreen(
                        text: isSentView
                            ? 'Bạn chưa gửi đi thông báo nào'
                            : 'Bạn chưa có thông báo mới',
                      ),
                    )
                  : Column(children: [
                      if (!isSentView)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'Chỉ thông báo chưa đọc',
                              style: AppTextStyles.semiBold14(
                                  color: AppColors.gray600),
                            ),
                            Transform.scale(
                              scale: 0.7,
                              child: Switch.adaptive(
                                value: isNotRead,
                                onChanged: (value) {
                                  setState(() {
                                    isNotRead = value;
                                  });

                                  notiBloc.add(NotificationChageViewMode(
                                    viewed:
                                        value ? ViewMode.unRead : ViewMode.all,
                                  ));
                                },
                                activeTrackColor: AppColors.brand600,
                                activeColor: AppColors.white,
                                inactiveThumbColor: AppColors.white,
                              ),
                            ),
                            const SizedBox(width: 8),
                          ],
                        ),
                      SingleChildScrollView(child: Column(children: listNotiW))
                    ]),
            ),
          ],
        ),
      ),
    );
  }
}
