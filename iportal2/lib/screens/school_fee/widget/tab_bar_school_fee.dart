import 'package:core/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:iportal2/screens/school_fee/widget/tab_history_payment/tab_view_school_fee_history_payment.dart';
import 'package:iportal2/screens/school_fee/widget/tab_payment/tab_view_school_fee_payment.dart';

class TabBarSchoolFee extends StatefulWidget {
  final List<String> tabTitles;

  const TabBarSchoolFee({
    super.key,
    required this.tabTitles,
  });
  @override
  State<TabBarSchoolFee> createState() => _TabBarSchoolFee();
}

class _TabBarSchoolFee extends State<TabBarSchoolFee> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: widget.tabTitles.length,
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
                ),
              ),
            ),
          ),
          const Expanded(
            child: TabBarView(
              children: [
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
