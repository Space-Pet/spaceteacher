import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iportal2/resources/app_colors.dart';

class DropdownButtonComponent extends StatefulWidget {
  final String title;
  final List<String> optionList;

  const DropdownButtonComponent({
    super.key,
    required this.title,
    required this.optionList,
  });

  @override
  State<DropdownButtonComponent> createState() =>
      _DropdownButtonComponentState();
}

class _DropdownButtonComponentState extends State<DropdownButtonComponent> {
  String? dropdownValue;

  @override
  void initState() {
    super.initState();
    dropdownValue = widget.optionList.first;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: const Color(0xFFEAECF0),
        ),
      ),
      // width: 160,
      child: DropdownButton<String>(
        value: dropdownValue,
        isDense: true,
        icon: SvgPicture.asset(
          'assets/icons/chevron-down.svg',
          height: 14,
          width: 14,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        onChanged: (String? value) {
          setState(() {
            dropdownValue = value;
          });
        },
        padding: const EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 12,
        ),
        style: const TextStyle(
          color: Color(0xFF424242),
          fontSize: 16,
        ),
        underline: Container(
          color: Colors.transparent,
        ),
        items: widget.optionList.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}
