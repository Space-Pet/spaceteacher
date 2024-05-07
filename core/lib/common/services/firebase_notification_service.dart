import 'dart:async';
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

import '../components/notification/show_notification.dart';

class FirebaseNotificationService {
  FirebaseNotificationService._();

  static final shared = FirebaseNotificationService._();

  static FirebaseOptions? _options;

  static ShowingNotification? _showingNotification;

  Future<void> initialize({
    FirebaseOptions? options,
    required ShowingNotification showingNotification,
  }) async {
    final messaging = FirebaseMessaging.instance;

    final settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    _options = options;

    _showingNotification = showingNotification;

    await _showingNotification!.initial();

    await iosConfiguration();

    if (kDebugMode) {
      print('Permission granted: ${settings.authorizationStatus}');
    }

    final fcmToken = await messaging.getToken();

    log('FirebaseNotificationService - init - fcmToken: $fcmToken');

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      showingNotification.showNotification(
        message.toShowingData(),
        message.data,
      );
      ShowingNotification.onReceiveNotification(message.data);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      ShowingNotification.onHandleNotification(message.data);
      ShowingNotification.onReceiveNotification(message.data);
    });

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  set notiOpened(
    Function(Map<String, dynamic>? data) onHandleNotification,
  ) {
    ShowingNotification.onHandleNotification = onHandleNotification;
  }

  set notiReceived(
    Function(Map<String, dynamic>? data) onReceived,
  ) {
    ShowingNotification.onReceiveNotification = onReceived;
  }

  void handleNotification(Map<String, dynamic>? data) {
    ShowingNotification.onHandleNotification(data);
  }

  void onReceiveNotification(Map<String, dynamic>? data) {
    ShowingNotification.onReceiveNotification(data);
  }

  static Future<void> iosConfiguration() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  static Future<void> _firebaseMessagingBackgroundHandler(
    RemoteMessage message,
  ) async {
    await Firebase.initializeApp(options: _options);

    await _showingNotification?.initial();

    _showingNotification?.showNotification(
      message.toShowingData(),
      message.data,
    );
  }
}

extension RemoteMessageX on RemoteMessage {
  NotificationShowingData? toShowingData() {
    if (notification == null) {
      return null;
    }

    return NotificationShowingData(
      notiHashCode: notification!.hashCode,
      isAndroid: notification!.android != null,
      title: notification!.title,
      body: notification!.body,
    );
  }
}
