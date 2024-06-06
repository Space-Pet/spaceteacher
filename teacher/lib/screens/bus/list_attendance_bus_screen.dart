import 'package:core/core.dart';

import 'package:teacher/resources/assets.gen.dart';

import 'package:flutter/cupertino.dart';
import 'package:repository/repository.dart';
import 'package:teacher/app_config/router_configuration.dart';
import 'package:teacher/common_bloc/current_user/current_user_bloc.dart';
import 'package:teacher/components/app_bar/app_bar.dart';
import 'package:teacher/components/back_ground_container.dart';
import 'package:teacher/screens/bus/bloc/bus_bloc.dart';
import 'package:teacher/screens/bus/widgets/select_date.dart';

class ListAttendanceBusScreen extends StatelessWidget {
  const ListAttendanceBusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
        value: BusBloc(
          appFetchApiRepository: context.read<AppFetchApiRepository>(),
          currentUserBloc: context.read<CurrentUserBloc>(),
          userRepository: context.read<UserRepository>(),
        ),
        child: BlocBuilder<BusBloc, BusState>(builder: (context, state) {
          final detailTeacher = state.userData;
          return BackGroundContainer(
            child: Column(
              children: [
                ScreenAppBar(
                  title: 'Xem lại điểm danh',
                  canGoback: true,
                  onBack: () {
                    context.pop();
                  },
                ),
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
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          detailTeacher.info.urlImage.mobile)),
                                  shape: BoxShape.circle,
                                  color: AppColors.white,
                                  border: Border.all(
                                      color: AppColors.black, width: 1)),
                            ),
                            const SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  detailTeacher.info.fullName,
                                  style: AppTextStyles.semiBold12(
                                    color: AppColors.black,
                                  ),
                                ),
                                Text(
                                  detailTeacher.info.mainSubject,
                                  style: AppTextStyles.normal12(
                                    color: AppColors.black,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: SelectDate(),
                        ),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: Assets.images.ateendancePink.provider(),
                            ),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Center(
                                        child: Text(
                                          'Lên xe',
                                          style: AppTextStyles.normal14(
                                            color: AppColors.brand600,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 1,
                                      height: 20,
                                      color: AppColors.gray300,
                                    ),
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Text(
                                            '18',
                                            style: AppTextStyles.normal18(
                                              color: AppColors.green600,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          Text(
                                            'Có mặt',
                                            style: AppTextStyles.normal14(
                                              color: AppColors.gray500,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: 1,
                                      height: 20,
                                      color: AppColors.gray300,
                                    ),
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Text(
                                            '7',
                                            style: AppTextStyles.normal18(
                                              color: AppColors.red700,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          Text(
                                            'Vắng',
                                            style: AppTextStyles.normal14(
                                              color: AppColors.gray500,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            padding: const EdgeInsets.only(top: 16),
                            itemCount: 14,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: GestureDetector(
                                  onTap: () {},
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            height: 40,
                                            width: 40,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: AssetImage(detailTeacher
                                                    .info.urlImage.mobile),
                                              ),
                                              shape: BoxShape.circle,
                                              color: AppColors.white,
                                              border: Border.all(
                                                color: AppColors.white,
                                                width: 2,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Mel Tran',
                                                style: AppTextStyles.normal14(
                                                    fontWeight: FontWeight.w600,
                                                    color: AppColors.brand600),
                                              ),
                                              Text(
                                                'NH12393Y2',
                                                style: AppTextStyles.normal12(
                                                    color: AppColors.secondary),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          // Text(
                                          //   widget.isAbsent[index]
                                          //       ? info.leaveApplicationData
                                          //               ?.first.content ??
                                          //           'Không phép'
                                          //       : '',
                                          //   style: AppTextStyles.normal12(
                                          //       color: AppColors.orange400),
                                          // ),
                                          // widget.isAbsent[index]
                                          //     ? Assets.icons.absent.svg()
                                          //     :
                                          Assets.icons.checkDone.svg(),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }));
  }
}
