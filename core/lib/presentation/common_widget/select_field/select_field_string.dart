import 'package:flutter/material.dart';
import '../../../resources/resources.dart';

class SelectFieldString extends StatefulWidget {
  const SelectFieldString({required this.typeField, super.key});
  final int typeField;
  @override
  State<SelectFieldString> createState() => _SelectFieldStringState();
}

class _SelectFieldStringState extends State<SelectFieldString> {
  String _selected = 'Select Field';
  String _hintText = '';
  @override
  void initState() {
    switch (widget.typeField) {
      case 1:
        _hintText = 'Chọn';
        break;
      case 2:
        _hintText = 'Tên giáo viên';
        break;
      case 3:
        _hintText = 'Tiết học';
        break;
      case 4:
        _hintText = 'Lớp';
        break;
      default:
        _hintText = 'Chọn';
        break;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      icon: const Icon(
        Icons.keyboard_arrow_down_rounded,
        size: 24,
        color: AppColors.gray900,
      ),
      focusColor: AppColors.blueGray100,

      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.blueGray100),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.blueGray100),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.blueGray100),
        ),
        focusColor: AppColors.blueGray100,
        fillColor: AppColors.blueGray100,
        hintText: _hintText,
      ),
      // value: _selected,
      hint: Text(_hintText,
          style: AppTextStyles.normal16(color: AppColors.gray500)),
      onChanged: (String? value) {
        setState(() {
          _selected = value!;
        });
      },
      items: <String>['Select Field', 'Field 1', 'Field 2', 'Field 3']
          .map<DropdownMenuItem<String>>((String? value) {
        return DropdownMenuItem<String>(
          value: value ?? '',
          child: Text(value ?? ''),
        );
      }).toList(),
    );
  }
}
