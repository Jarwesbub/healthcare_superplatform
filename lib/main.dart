import 'package:flutter/material.dart';
import 'package:healthcare_superplatform/pages/page_manager.dart';
import 'package:healthcare_superplatform/widgets/notifications.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final Notifications notifications = Notifications();
  await notifications.init();
  await notifications.requestNotificationPermission();
  runApp(MyApp(notifications: notifications));
}

class MyApp extends StatelessWidget {
  final Notifications notifications;
  const MyApp({super.key, required this.notifications});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demola',
      debugShowCheckedModeBanner: false,
      home: PageManager(notifications: notifications),
    );
  }
}
