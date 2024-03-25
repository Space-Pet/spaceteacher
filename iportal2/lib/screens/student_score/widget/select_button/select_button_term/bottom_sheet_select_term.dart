import 'package:flutter/material.dart';
import 'package:iportal2/resources/resources.dart';

// Step 1: Define a model for list items
class ListItem<T> {
  bool isSelected = false;
  final T data;

  ListItem(this.data, {this.isSelected = false});
}

class BottomSheetSelectTerm extends StatefulWidget {
  const BottomSheetSelectTerm({
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
  State<BottomSheetSelectTerm> createState() => _BottomSheetSelectTermState();
}

class _BottomSheetSelectTermState extends State<BottomSheetSelectTerm> {
  // Convert the optionList to a list of ListItem objects
  List<ListItem<String>> _items = [];

  @override
  void initState() {
    super.initState();
    _items = widget.optionList
        .map((option) =>
            ListItem(option, isSelected: option == widget.selectedOption))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 32),
        child: ListView.separated(
          controller: widget.scrollController,
          itemBuilder: (context, index) => GestureDetector(
            onTap: () {
              debugPrint('setState called');
              setState(() {
                for (var i = 0; i < _items.length; i++) {
                  _items[i].isSelected = false;
                }
                _items[index].isSelected = true;
              });
              widget.onSelectedOption(_items[index].data);
            },
            child: Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.black12,
                  ),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 5),
              child: Text(
                _items[index].data,
                style: TextStyle(
                    color: _items[index].isSelected
                        ? AppColors.primaryRedColor
                        : AppColors.brand600),
              ),
            ),
          ),
          separatorBuilder: (context, index) => const SizedBox(height: 0),
          itemCount: _items.length,
        ),
      ),
    );
  }
}
