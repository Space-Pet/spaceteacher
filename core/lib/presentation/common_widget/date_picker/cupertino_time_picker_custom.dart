import 'package:flutter/cupertino.dart';

import '../../theme/theme_button.dart';
import 'custom_picker_constrants.dart';

Future<dynamic> showCupertinoCustomTimePicker(
  BuildContext context,
  Duration? initialTimerDuration,
  Function(Duration?)? onComfirmed,
) {
  return showCupertinoModalPopup<void>(
    context: context,
    builder: (BuildContext context) {
      return CupertinoTimePickerCustom(
        initialTimerDuration: initialTimerDuration,
        onComfirmed: onComfirmed,
      );
    },
  );
}

class CupertinoTimePickerCustom extends StatefulWidget {
  const CupertinoTimePickerCustom({
    Key? key,
    required this.initialTimerDuration,
    this.onCancelled,
    this.onComfirmed,
  }) : super(key: key);

  final Duration? initialTimerDuration;
  final Function? onCancelled;
  final Function(Duration?)? onComfirmed;

  @override
  _CupertinoTimePickerCustomState createState() =>
      _CupertinoTimePickerCustomState();
}

class _CupertinoTimePickerCustomState extends State<CupertinoTimePickerCustom> {
  Duration? selectedTime;

  @override
  void initState() {
    selectedTime = Duration(seconds: widget.initialTimerDuration!.inSeconds);
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
            child: SizedBox(
              height: CustomPickerConstants.pickerSheetHeight +
                  CustomPickerConstants.pickerButtonHeight,
              child: Column(
                children: <Widget>[
                  _buildFunction(),
                  CupertinoTimerPicker(
                    backgroundColor:
                        CupertinoColors.systemBackground.resolveFrom(context),
                    initialTimerDuration: widget.initialTimerDuration!,
                    onTimerDurationChanged: (Duration newTimer) {
                      selectedTime = newTimer;
                    },
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          ThemeButton.notRecommend(
            context: context,
            title: 'Cancel',
            onPressed: () {
              widget.onCancelled?.call();
              _close();
            },
          ),
          ThemeButton.recommend(
            context: context,
            title: 'Done',
            onPressed: () {
              widget.onComfirmed?.call(selectedTime);
              _close();
            },
          ),
        ],
      ),
    );
  }

  void _close() {
    Navigator.of(context, rootNavigator: true).pop();
  }
}
