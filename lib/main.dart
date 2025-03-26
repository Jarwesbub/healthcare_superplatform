import 'package:flutter/material.dart';
import 'package:healthcare_superplatform/demos/demo_home_page.dart';
import 'package:healthcare_superplatform/unused/widgets/notifications.dart';
import 'package:flutter/foundation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Notifications? notifications;

  if (!kIsWeb) {
    // ✅ Only initialize notifications if NOT running on web
    notifications = Notifications();
    await notifications.init();
    await notifications.requestNotificationPermission();
  }

  runApp(MyApp(notifications: notifications));
}

class MyApp extends StatelessWidget {
  final Notifications? notifications;
  const MyApp({super.key, this.notifications});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demola',
      debugShowCheckedModeBanner: false,
      home: DemoHomePage(notifications: notifications ?? Notifications()),
    );
  }
}
