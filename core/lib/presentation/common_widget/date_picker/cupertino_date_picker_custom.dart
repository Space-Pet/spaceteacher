import 'package:dartx/dartx.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../common/constants/app_locale.dart';
import '../../theme/theme_color.dart';
import 'custom_picker_constrants.dart';
import 'custom_picker_model.dart';
import 'flutter_datetime_picker/flutter_datetime_picker.dart';

Future<dynamic> showMyCustomDatePicker(
  BuildContext context,
  DateTime? initialDateTime,
  Function(DateTime?)? onConfirmed, {
  Function(DateTime?)? onChanged,
  DateTime? maxDate,
  DateTime? minDate,
}) {
  return DatePicker.showPicker(
    context,
    showTitleActions: true,
    onChanged: onChanged,
    onConfirm: onConfirmed,
    locale: LocaleType.vi,
    pickerModel: DateDDMMYYYModel(
      minTime: minDate,
      maxTime: maxDate,
      currentTime: initialDateTime,
      locale: LocaleType.values
              .where((element) =>
                  element.name == Localizations.localeOf(context).languageCode)
              .firstOrNull ??
          LocaleType.vi,
    ),
  );
}

Future<dynamic> showMyCustomMonthPicker(
  BuildContext context,
  DateTime? initialDateTime,
  ThemeColor? theme,
  Function(DateTime?)? onConfirmed, {
  Function(DateTime?)? onChanged,
  DateTime? maxDate,
  DateTime? minDate,
}) {
  return DatePicker.showPicker(
    context,
    showTitleActions: true,
    onChanged: onChanged,
    onConfirm: onConfirmed,
    locale: Localizations.localeOf(context).languageCode ==
            AppLocale.en.languageCode
        ? LocaleType.en
        : LocaleType.vi,
    pickerModel: DateMMYYYModel(
      minTime: minDate,
      maxTime: maxDate,
      currentTime: initialDateTime,
      locale: LocaleType.values
              .where((element) =>
                  element.name == Localizations.localeOf(context).languageCode)
              .firstOrNull ??
          LocaleType.vi,
    ),
  );
}

class CupertinoDatePickerCustom extends StatefulWidget {
  CupertinoDatePickerCustom({
    Key? key,
    required this.initialDateTime,
    this.maxDate,
    this.minDate,
    this.mode = CupertinoDatePickerMode.date,
    this.onCancelled,
    this.onComfirmed,
  }) : super(key: key);

  final DateTime? initialDateTime;
  final DateTime? maxDate;
  final DateTime? minDate;
  final Function? onCancelled;
  final Function(DateTime?)? onComfirmed;
  final CupertinoDatePickerMode mode;

  @override
  _CupertinoDatePickerCustomState createState() =>
      _CupertinoDatePickerCustomState();
}

class _CupertinoDatePickerCustomState extends State<CupertinoDatePickerCustom> {
  DateTime? selectedTime;

  @override
  void initState() {
    selectedTime = DateTime.fromMillisecondsSinceEpoch(
      widget.initialDateTime!.millisecondsSinceEpoch,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 6.0),
      color: CupertinoColors.systemBackground.resolveFrom(context),
      child: DefaultTextStyle(
        style: TextStyle(
          color: CupertinoColors.label.resolveFrom(context),
          fontSize: 22.0,
        ),
        child: GestureDetector(
          // Blocks taps from propagating to the modal sheet and popping.
          onTap: () {},
          child: SafeArea(
            top: false,
            child: Container(
              height: CustomPickerConstants.pickerSheetHeight +
                  CustomPickerConstants.pickerButtonHeight,
              child: Column(
                children: <Widget>[
                  _buildFunction(),
                  Container(
                    height: CustomPickerConstants.pickerSheetHeight - 30,
                    child: CupertinoDatePicker(
                      backgroundColor:
                          CupertinoColors.systemBackground.resolveFrom(context),
                      mode: widget.mode,
                      initialDateTime: widget.initialDateTime,
                      maximumDate: widget.maxDate,
                      minimumDate: widget.minDate,
                      onDateTimeChanged: (DateTime newTimer) {
                        selectedTime = newTimer;
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFunction() {
    const cancelTextStyle = TextStyle(color: Color(0xFFbebebe), fontSize: 16);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          TextButton(
            onPressed: () {
              widget.onCancelled?.call();
              _close();
            },
            child: const Text(
              'Hủy',
              style: cancelTextStyle,
            ),
          ),
          TextButton(
            onPressed: () {
              widget.onComfirmed?.call(selectedTime);
              _close();
            },
            child: const Text('Đồng ý'),
          ),
        ],
      ),
    );
  }

  void _close() {
    Navigator.of(context, rootNavigator: true).pop();
  }
}
