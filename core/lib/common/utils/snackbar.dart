import 'package:flutter/material.dart';

class SnackBarUtils {
  static void showFloatingSnackBar(BuildContext context, String message,
      {Duration duration = const Duration(seconds: 3)}) {
    final snackBar = SnackBar(
      content: Text(message),
      behavior: SnackBarBehavior.floating,
      duration: duration,
      margin: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
      elevation: 30,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void showFloatingSnackBarOpenFile(
      BuildContext context, String message, Function openfile, bool isErr,
      {Duration duration = const Duration(seconds: 5)}) {
    final snackBar = SnackBar(
      content: Row(
        mainAxisAlignment: isErr == false
            ? MainAxisAlignment.spaceBetween
            : MainAxisAlignment.center,
        children: [
          Flexible(
            child: Text(message),
          ),
          isErr == false
              ? ElevatedButton(
                  onPressed: () {
                    openfile.call();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                  ),
                  child: const Text('Open file'),
                )
              : const SizedBox(),
        ],
      ),
      behavior: SnackBarBehavior.floating,
      duration: duration,
      margin: const EdgeInsets.symmetric(vertical: 70.0, horizontal: 20.0),
      elevation: 30,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
