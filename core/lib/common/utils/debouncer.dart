import 'dart:async';
import 'package:flutter/material.dart';

class Debouncer<T> {
  Debouncer({required this.milliseconds});
  final int milliseconds;
  Timer? _timer;
  void run(VoidCallback action) {
    if (_timer?.isActive ?? false) {
      _timer?.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }

  Future<T> runAsync(Future<T> Function() action) {
    final completer = Completer<T>();
    run(() async {
      final result = await action();
      completer.complete(result);
    });
    return completer.future;
  }
}
