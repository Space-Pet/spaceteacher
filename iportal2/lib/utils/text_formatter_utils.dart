import 'package:core/core.dart';
import 'package:flutter/services.dart';

class CurrencyInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    double value = double.parse(newValue.text);

    final formatter = NumberFormatUtils.decimalFormat(value);

    return newValue.copyWith(
        text: formatter,
        selection: TextSelection.collapsed(offset: formatter?.length ?? 0));
  }
}
