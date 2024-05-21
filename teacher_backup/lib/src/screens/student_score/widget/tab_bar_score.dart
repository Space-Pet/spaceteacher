import 'package:core/core.dart';
import 'package:flutter/material.dart';

class TabBarScore extends StatefulWidget {
  final String selectedScoreType;
  final List<String> renderedTabs;
  const TabBarScore(
      {super.key, required this.selectedScoreType, required this.renderedTabs});
  @override
  State<TabBarScore> createState() => _TabBarScore();
}

class _TabBarScore extends State<TabBarScore> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: widget.renderedTabs.length,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 4, 12, 12),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.whiteOpacity,
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
          // Expanded(
          //     child: Padding(
          //   padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
          //   child: TabBarView(
          //     children: [
          //       TabBarViewMidTerm(
          //         selectedScoreType: widget.selectedScoreType,
          //       ),
          //       TabBarViewMidTerm(
          //         selectedScoreType: widget.selectedScoreType,
          //       ),
          //       if (widget.renderedTabs.length == 3)
          //         TabBarViewMidTerm(
          //           selectedScoreType: widget.selectedScoreType,
          //         ),
          //     ],
          //   ),
          // ))
        ],
      ),
    );
  }

  List<Widget> _buildTabs() {
    return widget.renderedTabs.map((title) {
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
