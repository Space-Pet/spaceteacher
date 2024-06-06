import 'package:flutter/material.dart';
import 'package:iportal2/app_config/router_configuration.dart';
import 'package:iportal2/common_bloc/current_user/bloc/current_user_bloc.dart';
import 'package:iportal2/components/app_bar/app_bar.dart';
import 'package:iportal2/components/back_ground_container.dart';
import 'package:iportal2/screens/school_fee/bloc/school_fee_bloc.dart';
import 'package:iportal2/screens/school_fee/widget/tab_bar_school_fee.dart';
import 'package:iportal2/utils/utils_export.dart';
import 'package:repository/repository.dart';

class SchoolFeeScreen extends StatelessWidget {
  const SchoolFeeScreen({super.key});
  static const routeName = '/school-fee';
  @override
  Widget build(BuildContext context) {
    return BlocProvider<SchoolFeeBloc>(
      create: (context) => SchoolFeeBloc(
        appFetchApiRepo: context.read<AppFetchApiRepository>(),
        currentUserBloc: context.read<CurrentUserBloc>(),
      ),
      child: Scaffold(
        body: BackGroundContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ScreenAppBar(
                title: 'Học phí',
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
                    color: Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: const TabBarSchoolFee(
                    tabTitles: ['Cần thanh toán', 'Lịch sử thanh toán'],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
