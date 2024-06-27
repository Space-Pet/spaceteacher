import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:iportal2/screens/school_fee/bloc/school_fee_bloc.dart';
import 'package:iportal2/screens/school_fee/widget/tab_history_payment/tab_view_school_fee_history_payment.dart';
import 'package:iportal2/screens/school_fee/widget/tab_payment/tab_view_school_fee_payment.dart';

class TabBarSchoolFee extends StatefulWidget {
  final List<String> tabTitles;
  final TabController? tabController;
  const TabBarSchoolFee({
    super.key,
    required this.tabTitles,
    required this.tabController,
  });

  @override
  State<TabBarSchoolFee> createState() => _TabBarSchoolFeeState();
}

class _TabBarSchoolFeeState extends State<TabBarSchoolFee>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: context.read<SchoolFeeBloc>(),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 4, 0, 12),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.gray100,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: TabBar(
                  controller: widget.tabController,
                  labelColor: AppColors.redMenu,
                  unselectedLabelColor: AppColors.gray400,
                  dividerColor: Colors.transparent,
                  labelStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                  unselectedLabelStyle: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w400),
                  indicator: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(100),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.10),
                        offset: Offset(0.0, 5.0),
                        blurRadius: 20.0,
                      ),
                    ],
                  ),
                  indicatorPadding: const EdgeInsets.symmetric(horizontal: -15),
                  tabs: _buildTabs(),
                  onTap: (value) {
                    context
                        .read<SchoolFeeBloc>()
                        .add(UpdateTabIndexEvent(value));
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: widget.tabController,
              children: const [
                TabViewSchoolFeePayment(),
                TabViewSchoolFeeHistoryPayment(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildTabs() {
    return widget.tabTitles.map((title) {
      return SizedBox(
        height: 32,
        child: Tab(
          child: Align(
            child: Center(
                child: Text(
              title,
              textAlign: TextAlign.center,
            )),
          ),
        ),
      );
    }).toList();
  }
}
