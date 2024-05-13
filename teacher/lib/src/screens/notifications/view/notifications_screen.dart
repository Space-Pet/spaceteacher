import 'package:core/core.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teacher/components/app_bar/app_bar.dart';
import 'package:teacher/components/back_ground_container.dart';
import 'package:teacher/repository/notification_repository/notification_repositories.dart';
import 'package:teacher/resources/assets.gen.dart';
import 'package:teacher/resources/resources.dart';
import 'package:teacher/src/screens/notifications/bloc/notification_bloc.dart';
import 'package:teacher/src/settings/settings.dart';
import 'package:teacher/src/utils/user_manager.dart';

class NotificationsScreen extends StatefulWidget {
  static const routeName = '/notifications';
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final bloc = NotificationBloc(
      notificationRepository: Injection.get<NotificationRepository>());

  Future<void> _init() async {
    final userInfo =
        await UserManager.instance.getUser(Injection.get<Settings>());

    bloc.add(GetListNotification(
      orderBy: 'desc',
      schoolId: userInfo?.schoolId ?? 0,
      schoolBrand: userInfo?.schoolBrand ?? "ischool",
    ));

    // bloc.add(const GetListNotification(
    //   orderBy: 'desc',
    //   schoolId: 129,
    //   schoolBrand: "uka",
    // ));
  }

  @override
  void initState() {
    _init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationBloc, NotificationState>(
      bloc: bloc,
      builder: (context, state) {
        if (state.status == NotificationStatus.loading) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state.status == NotificationStatus.loaded) {
          if (isNullOrEmpty(state.listNotification)) {
            return BackGroundContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const ScreenAppBar(
                    title: 'Thông báo',
                  ),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: AppColors.white,
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Không có thông báo nào',
                          style: AppTextStyles.semiBold14(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return BackGroundContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ScreenAppBar(
                        title: 'Thông báo (${state.listNotification?.length})',
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                        child: Row(
                          children: [
                            // SvgPicture.asset(
                            //   'assets/icons/list-check-noti.svg',
                            //   width: 24,
                            //   height: 24,
                            // ),
                            Text(
                              'Chỉ hiện chưa đọc ',
                              style: AppTextStyles.normal16(
                                  color: AppColors.white, height: 20 / 16),
                            ),
                            // Transform.scale(
                            //   scale: 0.7,
                            //   child: Switch.adaptive(
                            //     value: isNotRead,
                            //     onChanged: (value) {
                            //       setState(() {
                            //         isNotRead = value;
                            //       });
                            //     },
                            //     activeTrackColor: AppColors.green400,
                            //     activeColor: AppColors.white,
                            //     inactiveThumbColor: AppColors.white,
                            //   ),
                            // ),
                          ],
                        ),
                      )
                    ],
                  ),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: AppColors.white,
                      ),
                      child: ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: state.listNotification?.length,
                          itemBuilder: (BuildContext context, index) {
                            final notiItem = state.listNotification![index];
                            return Stack(
                              children: [
                                Container(
                                  decoration: const BoxDecoration(
                                    color: AppColors.gray100,
                                    border: Border(
                                      bottom: BorderSide(
                                        color: AppColors.gray300,
                                      ),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: AppColors.green100,
                                          maxRadius: 16,
                                          child: Assets.icons.check.svg(
                                            width: 24,
                                            height: 24,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 12,
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                notiItem.title ?? "",
                                                style: AppTextStyles.semiBold14(
                                                    color: AppColors.gray800),
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              Text(
                                                notiItem.content ?? "",
                                                style: AppTextStyles.normal14(
                                                    color: AppColors.gray600,
                                                    height: 24 / 14),
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              Text(
                                                notiItem.updatedAt ?? "",
                                                style: AppTextStyles.normal12(
                                                    color: AppColors.gray400,
                                                    height: 18 / 14),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                // if (!notiItem.isRead)
                                Positioned(
                                  top: 8,
                                  left: 8,
                                  child: Assets.icons.check.svg(
                                    width: 8,
                                    height: 8,
                                  ),
                                ),
                              ],
                            );
                          }),
                    ),
                  ),
                ],
              ),
            );
          }
        }
        return Center(
          child: Text('${state.errorMessage}'),
        );
      },
    );
  }
}

/*


 */
