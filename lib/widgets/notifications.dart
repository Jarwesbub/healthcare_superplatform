import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

class Notifications {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> requestNotificationPermission() async {
    if (Platform.isAndroid) {
      // Check if permission is needed (API 33+)
      if (await Permission.notification.isDenied) {
        await Permission.notification.request();
      }
    }
  }

  Future<void> init() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@drawable/app_icon');
    final InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> showNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
          'energy_level_channel',
          'Energy level notification',
          //'your channel description',
          importance: Importance.max,
          priority: Priority.high,
          showWhen: false,
          icon: '@drawable/app_icon',
        );
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );
    await flutterLocalNotificationsPlugin.show(
      0,
      'plain title',
      'plain body',
      platformChannelSpecifics,
    );
  }
}
