import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import '../../data/models/notification_model.dart';
import '../config.dart';

class FirebaseNotificationService {
  FirebaseNotificationService._();

  static final shared = FirebaseNotificationService._();

  static final foregroundNotificationController =
      StreamController<NotificationModel>.broadcast();

  Stream<NotificationModel> get onReceiveForegroundNotification {
    return foregroundNotificationController.stream;
  }

  Future<void> initialize() async {
    if (Config.instance.appConfig.developmentMode) {
      // [TODO]: implement logger
    }

    // [TODO]: implement foreground notification settings and loggers

    // [DOING]: handle permission observer
    await FirebaseMessaging.instance.requestPermission();
  }

  Future<void> setUserId(String userId) async {
    if (kIsWeb) {
      return;
    }
    throw UnimplementedError();
  }

  Future<void> setLanguage(String languageCode) async {
    if (kIsWeb) {
      return;
    }
    throw UnimplementedError();
  }

  Future<void> removeUserId() async {
    if (kIsWeb) {
      return;
    }
    throw UnimplementedError();
  }

  static Future<Map<String, dynamic>> setTags(Map<String, dynamic> tags) {
    throw UnimplementedError();
  }

  Future<Map<String, dynamic>> deleteTags(List<String> keys) {
    throw UnimplementedError();
  }

  void onNotificationOpened() {
    throw UnimplementedError();
  }

  void onNotificationReceived() {
    throw UnimplementedError();
  }
}
