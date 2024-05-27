import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../../data/types/types.dart';

abstract class ShowingNotification {
  static late Function(Json? data) onHandleNotification;

  static late Function(Json? data) onReceiveNotification;

  Future<void> initial();

  void showNotification(NotificationShowingData? showingData, Json payload);
}

class FlutterLocalShowingNotification extends ShowingNotification {
  static late AndroidNotificationChannel channel;
  static late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  static bool isFlutterLocalNotificationsInitialized = false;

  @override
  Future<void> initial() async {
    if (isFlutterLocalNotificationsInitialized) {
      return;
    }

    ///Flutter local notification plugin set up.
    const initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final initializationSettingsDarwin = DarwinInitializationSettings(
      onDidReceiveLocalNotification: (id, title, body, payload) {},
    );

    final initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
      onDidReceiveBackgroundNotificationResponse:
          onDidReceiveBackgroundNotificationResponse,
    );

    await androidChannelConfiguration();

    isFlutterLocalNotificationsInitialized = true;
  }

  Future<void> androidChannelConfiguration() async {
    if (!Platform.isAndroid) {
      return;
    }

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();

    channel = const AndroidNotificationChannel(
      'Iportal2_android_push_channel',
      'Iportal2 Notification',
      description:
          'This channel is used for the notifications of the Iportal2 application.',
      importance: Importance.high,
    );
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  @override
  void showNotification(NotificationShowingData? showingData, Json payload) {
    if (showingData != null && showingData.isAndroid && !kIsWeb) {
      flutterLocalNotificationsPlugin.show(
        showingData.hashCode,
        showingData.title,
        showingData.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            icon: 'launch_background',
          ),
        ),
        payload: jsonEncode(payload),
      );
    }
  }

  @pragma('vm:entry-point')
  static void onDidReceiveBackgroundNotificationResponse(
    NotificationResponse details,
  ) {
    if (details.payload == null) {
      log('onDidReceiveBackgroundNotificationResponse: payload is null');
      return;
    }

    final data = jsonDecode(details.payload!);

    ShowingNotification.onHandleNotification(data);
  }

  static void onDidReceiveNotificationResponse(
    NotificationResponse details,
  ) {
    if (details.payload == null) {
      log('onDidReceiveNotificationResponse: payload is null');
      return;
    }

    final data = jsonDecode(details.payload!);

    ShowingNotification.onHandleNotification(data);
  }
}

class NotificationShowingData {
  final int notiHashCode;
  final String? title;
  final String? body;
  final bool isAndroid;

  NotificationShowingData({
    required this.notiHashCode,
    required this.isAndroid,
    this.title,
    this.body,
  });
}
