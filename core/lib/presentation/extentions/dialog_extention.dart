part of 'extention.dart';

Future<dynamic> showNoticeDialog({
  required BuildContext context,
  required String message,
  String? errorCode,
  required dynamic trans,
  String? title,
  String? titleBtn,
  bool barrierDismissible = true,
  Function()? onClose,
  bool useRootNavigator = true,
  bool dismissWhenAction = true,
}) {
  final dismissFunc = (String? message) {
    if (dismissWhenAction) {
      if (message == 'ecommerce.error.booking_area_not_support' ||
          message == 'ecommerce.error.service_item_price_updated' ||
          message == 'ecommerce.error.booking_cannot_confirm' ||
          message == 'ecommerce.error.booking_cannot_complete') {
        Navigator.popUntil(context, (route) => route.isFirst);
      } else {
        Navigator.of(context, rootNavigator: useRootNavigator).pop();
      }
    }
  };
  return showDialog(
    context: context,
    barrierDismissible: barrierDismissible,
    useRootNavigator: useRootNavigator,
    builder: (context) {
      final theme = Theme.of(context);
      final showAndroidDialog = () => AlertDialog(
            title: Text(
              title ?? trans.inform,
              style: theme.textTheme.headlineSmall,
            ),
            content: Text(
              message,
              style: theme.textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            actions: [
              TextButton(
                onPressed: () {
                  dismissFunc.call(errorCode);
                  onClose?.call();
                },
                child: Text(titleBtn ?? trans.ok),
              )
            ],
          );

      if (kIsWeb) {
        return showAndroidDialog();
      } else if (Platform.isAndroid) {
        return showAndroidDialog();
      } else {
        return CupertinoAlertDialog(
          title: Text(title ?? trans.inform),
          content: Text(
            message,
            style: theme.textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              onPressed: () {
                dismissFunc.call(errorCode);
                onClose?.call();
              },
              child: Text(titleBtn ?? trans.ok),
            ),
          ],
        );
      }
    },
  );
}

Future<dynamic> showNoticeErrorDialog({
  required BuildContext context,
  required String message,
  String? errorCode,
  bool barrierDismissible = false,
  void Function()? onClose,
  bool useRootNavigator = true,
  String? titleBtn,
  required dynamic trans,
}) {
  return showNoticeDialog(
    context: context,
    message: message,
    errorCode: errorCode,
    barrierDismissible: barrierDismissible,
    onClose: onClose,
    titleBtn: titleBtn,
    useRootNavigator: useRootNavigator,
    title: trans.error,
    trans: trans,
  );
}

Future<dynamic> showNoticeWarningDialog({
  required BuildContext context,
  required String message,
  bool barrierDismissible = false,
  void Function()? onClose,
  bool useRootNavigator = true,
  required dynamic trans,
}) {
  return showNoticeDialog(
    context: context,
    message: message,
    barrierDismissible: barrierDismissible,
    onClose: onClose,
    titleBtn: trans.ok,
    useRootNavigator: useRootNavigator,
    title: trans.warning,
    trans: trans,
  );
}

Future<dynamic> showInputDialog({
  required BuildContext context,
  required String message,
  required String title,
  required dynamic trans,
  required String inputHint,
  bool barrierDismissible = true,
  String? titleBtnDone,
  String? titleBtnCancel,
  void Function(String?)? onConfirmed,
  void Function()? onCanceled,
  bool useRootNavigator = true,
  bool dismissWhenAction = true,
}) {
  final dismissFunc = () {
    if (dismissWhenAction) {
      Navigator.of(context, rootNavigator: useRootNavigator).pop();
    }
  };
  final controller = InputContainerController();
  return showDialog(
    context: context,
    barrierDismissible: barrierDismissible,
    useRootNavigator: useRootNavigator,
    builder: (context) {
      final theme = Theme.of(context);
      final showAndroidDialog = () => AlertDialog(
            title: Text(
              title,
              style: theme.textTheme.headlineSmall,
            ),
            content: Text(
              message,
              style: theme.textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            actions: [
              InputContainer(
                controller: controller,
                inputStyle: InputStyle.circular,
                hasBorder: true,
                hint: inputHint,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.text,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextButton(
                    onPressed: () {
                      dismissFunc.call();
                      onCanceled?.call();
                    },
                    child: Text(titleBtnCancel ?? trans.cancel),
                  ),
                  TextButton(
                    onPressed: () {
                      dismissFunc.call();
                      onConfirmed?.call(controller.text);
                    },
                    child: Text(titleBtnDone ?? trans.confirm),
                  ),
                ],
              ),
            ],
          );

      if (kIsWeb) {
        return showAndroidDialog();
      } else if (Platform.isAndroid) {
        return showAndroidDialog();
      } else {
        Widget _buildAction({Function()? onTap, String title = ''}) {
          return RawMaterialButton(
            constraints: const BoxConstraints(minHeight: 45),
            padding: EdgeInsets.zero,
            onPressed: () {
              dismissFunc.call();
              onTap?.call();
            },
            child: Text(
              title,
              style: theme.textTheme.labelLarge?.copyWith(
                color: Colors.blue,
                fontWeight: FontWeight.normal,
              ),
            ),
          );
        }

        final controller = InputContainerController();

        return CupertinoAlertDialog(
          title: Text(
            title,
            style: theme.textTheme.headlineSmall,
          ),
          content: Text(
            message,
            style: theme.textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                InputContainer(
                  controller: controller,
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.text,
                  hasBorder: true,
                  inputStyle: InputStyle.circular,
                  hint: inputHint,
                ),
                _buildAction(
                  onTap: () {
                    onConfirmed?.call(controller.text);
                  },
                  title: titleBtnDone ?? trans.confirm,
                ),
                const Divider(thickness: 1, height: 1),
                _buildAction(
                  onTap: onCanceled,
                  title: titleBtnCancel ?? trans.cancel,
                ),
              ],
            )
          ],
        );
      }
    },
  );
}

Future<dynamic> showNoticeConfirmDialog({
  required BuildContext context,
  required String message,
  required String title,
  required dynamic trans,
  bool barrierDismissible = true,
  String? titleBtnDone,
  String? titleBtnCancel,
  void Function()? onConfirmed,
  void Function()? onCanceled,
  bool useRootNavigator = true,
  bool dismissWhenAction = true,
}) {
  final dismissFunc = () {
    if (dismissWhenAction) {
      Navigator.of(context, rootNavigator: useRootNavigator).pop();
    }
  };
  return showDialog(
    context: context,
    barrierDismissible: barrierDismissible,
    useRootNavigator: useRootNavigator,
    builder: (context) {
      final theme = Theme.of(context);
      final showAndroidDialog = () => AlertDialog(
            title: Text(
              title,
              style: theme.textTheme.headlineSmall,
            ),
            content: Text(
              message,
              style: theme.textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            actions: [
              TextButton(
                onPressed: () {
                  dismissFunc.call();
                  onCanceled?.call();
                },
                child: Text(titleBtnCancel ?? trans.cancel),
              ),
              TextButton(
                onPressed: () {
                  dismissFunc.call();
                  onConfirmed?.call();
                },
                child: Text(titleBtnDone ?? trans.confirm),
              ),
            ],
          );

      if (kIsWeb) {
        return showAndroidDialog();
      } else if (Platform.isAndroid) {
        return showAndroidDialog();
      } else {
        Widget _buildAction({Function()? onTap, String title = ''}) {
          return RawMaterialButton(
            constraints: const BoxConstraints(minHeight: 45),
            padding: EdgeInsets.zero,
            onPressed: () {
              dismissFunc.call();
              onTap?.call();
            },
            child: Text(
              title,
              style: theme.textTheme.labelLarge?.copyWith(
                color: Colors.blue,
                fontWeight: FontWeight.normal,
              ),
            ),
          );
        }

        return CupertinoAlertDialog(
          title: Text(
            title,
            style: theme.textTheme.headlineSmall,
          ),
          content: Text(
            message,
            style: theme.textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildAction(
                  onTap: onConfirmed,
                  title: titleBtnDone ?? trans.confirm,
                ),
                const Divider(thickness: 1, height: 1),
                _buildAction(
                  onTap: onCanceled,
                  title: titleBtnCancel ?? trans.cancel,
                ),
              ],
            )
          ],
        );
      }
    },
  );
}

Future<void> showModal(
  BuildContext context,
  Widget content, {
  bool useRootNavigator = true,
  double? bottomPadding,
}) {
  return showModalBottomSheet<void>(
    context: context,
    useRootNavigator: useRootNavigator,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Wrap(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(
                bottom: bottomPadding ?? MediaQuery.of(context).padding.bottom,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadiusDirectional.only(
                  topEnd: Radius.circular(16),
                  topStart: Radius.circular(16),
                ),
                boxShadow: boxShadowDark,
              ),
              child: content,
            )
          ],
        ),
      );
    },
  );
}

Future<void> showActionDialog(
  BuildContext context, {
  Map<String, void Function()> actions = const <String, void Function()>{},
  String title = '',
  String? subTitle = '',
  bool useRootNavigator = true,
  bool barrierDismissible = true,
  bool dimissWhenSelect = true,
  required dynamic trans,
}) {
  final theme = Theme.of(context);
  if (kIsWeb || Platform.isAndroid) {
    return showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      useRootNavigator: useRootNavigator,
      builder: (context) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: title,
                        style: theme.textTheme.headlineSmall,
                        children: [
                          if (subTitle?.isNotEmpty == true)
                            TextSpan(
                              text: '\n\n',
                              children: [
                                TextSpan(
                                  text: subTitle,
                                  style:
                                      theme.textTheme.headlineSmall!.copyWith(
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    ...actions.entries
                        .map(
                          (e) => InkWell(
                            highlightColor: themeColor.colorF3F3F3,
                            onTap: () {
                              if (dimissWhenSelect) {
                                Navigator.of(
                                  context,
                                  rootNavigator: useRootNavigator,
                                ).pop();
                              }
                              e.value.call();
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 16,
                                horizontal: 8,
                              ),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    width: 1,
                                    color: themeColor.colorF3F3F3,
                                  ),
                                ),
                              ),
                              child: Text(
                                e.key,
                                style: TextStyle(
                                  color: themeColor.primaryColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ],
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context, rootNavigator: useRootNavigator)
                          .pop();
                    },
                    child: Text(
                      trans.cancel,
                      style: TextStyle(
                        color: themeColor.primaryColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  } else {
    return showModalBottomSheet<void>(
      context: context,
      useRootNavigator: useRootNavigator,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      isDismissible: barrierDismissible,
      builder: (BuildContext context) {
        final theme = Theme.of(context);
        return CupertinoActionSheet(
          actions: [
            ...actions.entries.map(
              (e) => CupertinoActionSheetAction(
                onPressed: () {
                  if (dimissWhenSelect) {
                    if (dimissWhenSelect) {
                      Navigator.of(
                        context,
                        rootNavigator: useRootNavigator,
                      ).pop();
                    }
                    e.value.call();
                  }
                },
                child: Text(
                  e.key,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    color: Colors.blue,
                    fontWeight: FontWeight.normal,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ],
          title: Text(
            title,
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          message: subTitle?.isNotEmpty == true
              ? Text(
                  subTitle!,
                  style: theme.textTheme.titleMedium,
                  textAlign: TextAlign.center,
                )
              : null,
          cancelButton: CupertinoActionSheetAction(
            onPressed: () {
              Navigator.of(
                context,
                rootNavigator: useRootNavigator,
              ).pop();
            },
            child: Text(
              trans.cancel,
              style: theme.textTheme.headlineSmall?.copyWith(
                color: Colors.blue,
                fontWeight: FontWeight.normal,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        );
      },
    );
  }
}

Future<void> showMyCustomActionDialog(
  BuildContext context, {
  Map<String, void Function()> actions = const <String, void Function()>{},
  String title = '',
  String? subTitle = '',
  bool useRootNavigator = true,
  bool barrierDismissible = true,
  bool dimissWhenSelect = true,
  required dynamic trans,
}) {
  final theme = Theme.of(context);
  if (kIsWeb || Platform.isAndroid) {
    return showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      useRootNavigator: useRootNavigator,
      builder: (context) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: title,
                        style: theme.textTheme.headlineSmall,
                        children: [
                          if (subTitle?.isNotEmpty == true)
                            TextSpan(
                              text: '\n\n',
                              children: [
                                TextSpan(
                                  text: subTitle,
                                  style:
                                      theme.textTheme.headlineSmall!.copyWith(
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    ...actions.entries
                        .map(
                          (e) => InkWell(
                            highlightColor: themeColor.colorF3F3F3,
                            onTap: () {
                              if (dimissWhenSelect) {
                                Navigator.of(
                                  context,
                                  rootNavigator: useRootNavigator,
                                ).pop();
                              }
                              e.value.call();
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 16,
                                horizontal: 8,
                              ),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    width: 1,
                                    color: themeColor.colorF3F3F3,
                                  ),
                                ),
                              ),
                              child: Text(
                                e.key,
                                style: TextStyle(
                                  color: themeColor.primaryColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ],
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context, rootNavigator: useRootNavigator)
                          .pop();
                    },
                    child: Text(
                      trans.cancel,
                      style: TextStyle(
                        color: themeColor.primaryColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  } else {
    return showModalBottomSheet<void>(
      context: context,
      useRootNavigator: useRootNavigator,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      isDismissible: barrierDismissible,
      builder: (BuildContext context) {
        final theme = Theme.of(context);
        return CupertinoActionSheet(
          actions: [
            ...actions.entries.map(
              (e) => CupertinoActionSheetAction(
                onPressed: () {
                  if (dimissWhenSelect) {
                    if (dimissWhenSelect) {
                      Navigator.of(
                        context,
                        rootNavigator: useRootNavigator,
                      ).pop();
                    }
                    e.value.call();
                  }
                },
                child: Text(
                  e.key,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    color: Colors.blue,
                    fontWeight: FontWeight.normal,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ],
          title: Text(
            title,
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          message: subTitle?.isNotEmpty == true
              ? Text(
                  subTitle!,
                  style: theme.textTheme.titleMedium,
                  textAlign: TextAlign.center,
                )
              : null,
          cancelButton: CupertinoActionSheetAction(
            onPressed: () {
              Navigator.of(
                context,
                rootNavigator: useRootNavigator,
              ).pop();
            },
            child: Text(
              trans.cancel,
              style: theme.textTheme.headlineSmall?.copyWith(
                color: Colors.blue,
                fontWeight: FontWeight.normal,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        );
      },
    );
  }
}

Future<dynamic> showWarningInputConfirmDialog({
  required BuildContext context,
  required String message,
  required String title,
  required String inputTitle,
  required String inputHint,
  required String validateString,
  bool barrierDismissible = true,
  String? titleBtnDone,
  String? titleBtnCancel,
  void Function()? onConfirmed,
  void Function()? onCanceled,
  bool useRootNavigator = true,
  bool dismissWhenAction = true,
  required dynamic trans,
}) {
  final dismissFunc = () {
    if (dismissWhenAction) {
      Navigator.of(context, rootNavigator: useRootNavigator).pop();
    }
  };

  final valueNotifier = ValueNotifier(false);

  return showDialog(
    context: context,
    barrierDismissible: barrierDismissible,
    useRootNavigator: useRootNavigator,
    builder: (context) {
      final theme = Theme.of(context);

      final showAndroidDialog = () => AlertDialog(
            title: RichText(
              text: TextSpan(
                children: [
                  WidgetSpan(
                    child: SvgPicture.asset(
                      coreImageConstant.icRemind,
                      height: 20,
                      width: 20,
                      fit: BoxFit.contain,
                    ),
                    alignment: PlaceholderAlignment.middle,
                  ),
                  const WidgetSpan(
                    child: SizedBox(width: 10),
                  ),
                  TextSpan(
                    text: title,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontSize: 16,
                      color: themeColor.red,
                    ),
                  ),
                ],
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  message,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontSize: 14,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                InputContainer(
                  isDense: true,
                  fillColor: themeColor.white,
                  title: inputTitle,
                  titleTextStyle: theme.textTheme.titleSmall?.copyWith(
                    fontSize: 12,
                  ),
                  hint: inputHint,
                  onTextChanged: (value) {
                    if (value == validateString) {
                      valueNotifier.value = true;
                    } else {
                      if (valueNotifier.value == true) {
                        valueNotifier.value = false;
                      }
                    }
                  },
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  dismissFunc.call();
                  onCanceled?.call();
                },
                child: Text(titleBtnCancel ?? trans.cancel),
              ),
              ValueListenableBuilder(
                valueListenable: valueNotifier,
                builder: (context, value, _) {
                  return TextButton(
                    onPressed: value == true
                        ? () {
                            dismissFunc.call();
                            onConfirmed?.call();
                          }
                        : null,
                    child: Text(
                      titleBtnDone ?? trans.confirm,
                      style: TextStyle(
                        color: Colors.red.withOpacity(value == true ? 1 : 0.5),
                      ),
                    ),
                  );
                },
              ),
            ],
          );

      if (Platform.isAndroid) {
        return showAndroidDialog();
      } else {
        Widget _buildAction({
          Function()? onTap,
          String title = '',
          bool isEnable = true,
          Color? color,
        }) {
          return RawMaterialButton(
            constraints: const BoxConstraints(minHeight: 45),
            padding: EdgeInsets.zero,
            onPressed: isEnable == true
                ? () {
                    dismissFunc.call();
                    onTap?.call();
                  }
                : null,
            child: Text(
              title,
              style: theme.textTheme.labelLarge?.copyWith(
                color: (color ?? Colors.blue).withOpacity(isEnable ? 1 : 0.5),
                fontWeight: FontWeight.normal,
              ),
            ),
          );
        }

        return CupertinoAlertDialog(
          title: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                WidgetSpan(
                  child: SvgPicture.asset(
                    coreImageConstant.icRemind,
                    height: 20,
                    width: 20,
                    fit: BoxFit.contain,
                  ),
                  alignment: PlaceholderAlignment.middle,
                ),
                const WidgetSpan(
                  child: SizedBox(width: 10),
                ),
                TextSpan(
                  text: title,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontSize: 16,
                    color: themeColor.red,
                  ),
                ),
              ],
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                message,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 8,
              ),
              InputContainer(
                isDense: true,
                fillColor: themeColor.white,
                title: inputTitle,
                titleTextStyle: theme.textTheme.titleSmall?.copyWith(
                  fontSize: 12,
                ),
                hint: inputHint,
                onTextChanged: (value) {
                  if (value == validateString) {
                    valueNotifier.value = true;
                  } else {
                    if (valueNotifier.value == true) {
                      valueNotifier.value = false;
                    }
                  }
                },
              ),
            ],
          ),
          actions: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ValueListenableBuilder<bool>(
                  valueListenable: valueNotifier,
                  builder: (context, value, _) {
                    return _buildAction(
                      onTap: onConfirmed,
                      title: titleBtnDone ?? trans.confirm,
                      isEnable: value,
                      color: themeColor.red,
                    );
                  },
                ),
                const Divider(thickness: 1, height: 1),
                _buildAction(
                  onTap: onCanceled,
                  title: titleBtnCancel ?? trans.cancel,
                ),
              ],
            )
          ],
        );
      }
    },
  );
}
