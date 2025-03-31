import 'package:flutter/material.dart';
import 'package:healthcare_superplatform/demos/eyesight_stats/pages/eyesight_page_manager.dart';
import 'package:healthcare_superplatform/unused/pages/page_manager.dart';
import 'package:healthcare_superplatform/unused/widgets/notifications.dart';

class DemoHomePage extends StatelessWidget {
  const DemoHomePage({super.key, required this.notifications});
  final Notifications notifications;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            _button(
              context,
              'Old version',
              PageManager(notifications: notifications),
            ),
            _button(context, 'Eyesight demo', EyesightPageManager()),
          ],
        ),
      ),
    );
  }

  Widget _button(BuildContext context, String text, Widget page) {
    return ElevatedButton(
      onPressed: () {
        // Open the given page.
        Navigator.push(context, MaterialPageRoute(builder: (context) => page));
      },
      child: Text(text),
    );
  }
}
