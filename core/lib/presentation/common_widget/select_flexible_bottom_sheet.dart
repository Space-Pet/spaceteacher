import 'package:core/resources/resources.dart';
import 'package:flutter/material.dart';

class SelectFlexibleBottomSheet extends StatefulWidget {
  const SelectFlexibleBottomSheet({
    super.key,
    this.scrollController,
    required this.title,
    required this.options,
    required this.onUpdateOption,
    this.selectedOption,
  });

  final ScrollController? scrollController;
  final String title;
  final List<String> options;
  final String? selectedOption;
  final void Function(String) onUpdateOption;

  @override
  State<SelectFlexibleBottomSheet> createState() =>
      _SelectFlexibleBottomSheetState();
}

class _SelectFlexibleBottomSheetState extends State<SelectFlexibleBottomSheet> {
  String selectedOption = '';

  @override
  void initState() {
    selectedOption = widget.selectedOption ?? '';
    super.initState();
  }

  void onSelectedOption(String value) {
    setState(() {
      selectedOption = value;
    });

    widget.onUpdateOption(value);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final listOption = List.generate(widget.options.length, (index) {
      final option = widget.options[index];
      return InkWell(
        onTap: () {
          onSelectedOption(option);
        },
        child: Container(
          padding: const EdgeInsets.fromLTRB(16, 6, 16, 6),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: index == widget.options.length - 1
                    ? Colors.transparent
                    : AppColors.gray100,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(option, style: AppTextStyles.semiBold14()),
              Radio(
                activeColor: AppColors.brand600,
                value: option,
                groupValue: widget.selectedOption,
                onChanged: (String? value) {
                  if (value != null) {
                    onSelectedOption(value);
                  }
                },
              )
            ],
          ),
        ),
      );
    });

    return Material(
      child: Container(
        decoration: const BoxDecoration(
          color: AppColors.gray100,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 32),
        child: SingleChildScrollView(
          controller: widget.scrollController,
          child: Column(
            children: [
              Text(widget.title,
                  style: AppTextStyles.semiBold18(
                    color: AppColors.brand600,
                  )),
              Container(
                margin: const EdgeInsets.only(top: 12),
                decoration: const BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: Column(children: listOption),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
