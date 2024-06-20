import 'package:flutter/services.dart';

import 'number_format_utils.dart';

class CurrencyInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    final value = double.tryParse(newValue.text);

    final formatter = NumberFormatUtils.decimalFormat(value);

    return newValue.copyWith(
        text: formatter,
        selection: TextSelection.collapsed(offset: formatter?.length ?? 0));
  }
}
