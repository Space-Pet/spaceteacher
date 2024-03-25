import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CrossPlatform {
  static dynamic transitionToPage(
    BuildContext context,
    dynamic destination, {
    bool newPage = false,
  }) {
    FocusScopeNode currFocus = FocusScope.of(context);

    if (!currFocus.hasPrimaryFocus) {
      currFocus.unfocus();
    }

    if (!newPage) {
      return Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (c, a1, a2) => destination,
          transitionsBuilder: (c, anim, a2, child) => SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(anim),
            child: child,
          ),
          transitionDuration: const Duration(milliseconds: 500),
        ),
      );
    } else {
      Navigator.of(context).popUntil((route) => route.isFirst);
      return Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (c, a1, a2) => destination,
          transitionsBuilder: (c, anim, a2, child) => SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(anim),
            child: child,
          ),
          transitionDuration: const Duration(milliseconds: 500),
        ),
      );
    }
  }

  static dynamic pushAndRemoveAll(BuildContext context, dynamic destination) {
    return Navigator.pushAndRemoveUntil(
        context,
        PageRouteBuilder(
          pageBuilder: (c, a1, a2) => destination,
          transitionsBuilder: (c, anim, a2, child) => SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(anim),
            child: child,
          ),
          transitionDuration: const Duration(milliseconds: 500),
        ),
        ModalRoute.withName("/"));
  }

  static dynamic backTransitionPage(
    BuildContext context, {
    dynamic value,
  }) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context, value);
      return value;
    }
    return;
  }

  static Future<Flushbar> showErrorSnackbar(
    BuildContext context,
    String content, {
    int duration = 3000,
    int animationDuration = 1000,
  }) async {
    return Flushbar(
      borderRadius: BorderRadius.circular(100),
      message: content,
      duration: Duration(milliseconds: duration),
      animationDuration: Duration(milliseconds: animationDuration),
      flushbarPosition: FlushbarPosition.BOTTOM,
      flushbarStyle: FlushbarStyle.GROUNDED,
      icon: const Icon(
        Icons.error,
        color: Colors.white,
      ),
    )..show(context);
  }

  static dynamic showLoadingAlert(BuildContext context, String textInfo,
      {bool isShowed = true, required Color androidSpinnerColor}) {
    if (isShowed) {
      return showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return Platform.isIOS
                ? CupertinoAlertDialog(
                    title: const CupertinoActivityIndicator(),
                    content: Text(
                      textInfo,
                    ),
                  )
                : AlertDialog(
                    title: SpinKitFadingCircle(
                      color: androidSpinnerColor,
                      size: 50,
                    ),
                    content: Text(
                      textInfo,
                    ),
                  );
          });
    }
    Navigator.pop(context);
    return null;
  }

  static dynamic showCustormDialog(BuildContext context,
      {required Widget child, bool barrierDismissible = true}) {
    return showDialog(
        context: context,
        barrierDismissible: barrierDismissible,
        builder: (BuildContext context) {
          return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: child);
        });
  }

  static dynamic showBottomSheet(BuildContext context,
      {required Widget child,
      double borderRadius = 10,
      Color backgroundColor = Colors.white,
      bool isScrollControlled = true}) {
    return showModalBottomSheet(
        isScrollControlled: isScrollControlled,
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        backgroundColor: backgroundColor,
        builder: (BuildContext context) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: child,
          );
        });
  }
}


