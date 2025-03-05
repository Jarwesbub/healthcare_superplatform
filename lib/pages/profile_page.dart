import 'package:flutter/material.dart';

// Test page for showing user profile.

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [textWidget('<username>', 20), textWidget('Information', 18)],
      ),
    );
  }

  Widget textWidget(String title, double? fontSize) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Text(title, style: TextStyle(fontSize: fontSize)),
    );
  }
}
