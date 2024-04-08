import 'package:flutter/material.dart';
import 'package:iportal2/components/buttons/buttons.dart';
import 'package:iportal2/resources/resources.dart';
import 'package:iportal2/screens/notifications/notifications_screen.dart';

// Step 1: Define a model for list items
class ListItem<T> {
  bool isSelected = false;
  final T data;

  ListItem(this.data, {this.isSelected = false});
}

class BottomSheetSelectFilter extends StatefulWidget {
  const BottomSheetSelectFilter({
    super.key,
    required this.scrollController,
    required this.onSelectedOption,
    required this.optionList,
    required this.selectedOption,
  });

  final ScrollController scrollController;
  final String selectedOption;
  final List<String> optionList;
  final void Function(String) onSelectedOption;

  @override
  State<BottomSheetSelectFilter> createState() =>
      _BottomSheetSelectFilterState();
}

class _BottomSheetSelectFilterState extends State<BottomSheetSelectFilter> {
  List<ListItem<String>> _items = [];
  int? _selectedIndex;
  @override
  void initState() {
    super.initState();
    _items = widget.optionList
        .map((option) =>
            ListItem(option, isSelected: option == widget.selectedOption))
        .toList();
    _selectedIndex = _items.indexWhere((item) => item.isSelected);
    if (_selectedIndex == -1) {
      _selectedIndex = 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Bộ lọc',
              style: AppTextStyles.semiBold14(color: AppColors.gray800),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 32),
                child: ListView.separated(
                  controller: widget.scrollController,
                  itemBuilder: (context, index) => GestureDetector(
                    child: Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.black12,
                          ),
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _items[index].data,
                            style: const TextStyle(color: AppColors.gray800),
                          ),
                          Radio(
                            value: index,
                            groupValue: _selectedIndex,
                            onChanged: (int? value) {
                              setState(() {
                                _selectedIndex = value;
                                for (var i = 0; i < _items.length; i++) {
                                  _items[i].isSelected = false;
                                }
                                _items[value!].isSelected = true;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 0),
                  itemCount: _items.length,
                ),
              ),
            ),
            RoundedButton(
              onTap: () {
                if (_selectedIndex != null) {
                  widget.onSelectedOption(FilterType.values
                      .map((e) => e.text())
                      .toList()[_selectedIndex!]);
                } else {
                  debugPrint('Selected index is null');
                }
              },
              buttonColor: AppColors.red90001,
              borderRadius: 30,
              child: Text(
                'Áp dụng',
                style: AppTextStyles.semiBold14(color: AppColors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
