import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iportal2/screens/notifications/notifications_screen.dart';
import 'package:iportal2/screens/notifications/select_filter/bottom_sheet_select_filter.dart';
import 'package:iportal2/resources/app_decoration.dart';

class SelectFilter extends StatefulWidget {
  const SelectFilter({
    super.key,
    required this.onSelectedOptionChanged,
    required this.selectedFilter,
  });
  final Function(String) onSelectedOptionChanged;
  final String selectedFilter;
  @override
  State<SelectFilter> createState() => _SelectFilterState();
}

class _SelectFilterState extends State<SelectFilter> {
  List<String> optionList = FilterType.values.map((e) => e.text()).toList();
  @override
  void initState() {
    super.initState();
  }

  void updateSelectedOption(String newOption) async {
    widget.onSelectedOptionChanged(newOption);
    Navigator.of(context).pop();
    await Future.delayed(const Duration(milliseconds: 500));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        showFlexibleBottomSheet(
          minHeight: 0,
          initHeight: 0.4,
          maxHeight: 0.5,
          context: context,
          builder: (
            BuildContext context,
            ScrollController scrollController,
            double bottomSheetOffset,
          ) =>
              BottomSheetSelectFilter(
            optionList: optionList,
            scrollController: scrollController,
            onSelectedOption: updateSelectedOption,
            selectedOption: widget.selectedFilter,
          ),
          anchors: [0, 0.5],
          isSafeArea: true,
          bottomSheetBorderRadius: AppRadius.roundedTop16,
        )
      },
      child: SvgPicture.asset(
        'assets/icons/sort-noti.svg',
        width: 12,
        height: 12,
      ),
    );
  }
}
