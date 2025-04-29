import 'package:flutter/material.dart';
import 'package:healthcare_superplatform/demos/visionary_health.dart/models/eyesight_colors.dart';
import 'package:healthcare_superplatform/demos/visionary_health.dart/models/eyesight_text_style.dart';

class QuickActionButtonWidget extends StatelessWidget {
  const QuickActionButtonWidget({
    super.key,
    required this.text,
    required this.icon,
    this.page,
  });
  final String text;
  final IconData icon;
  final Widget? page;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 75,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: EyesightColors().blueGradient,
          ),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              if (page == null) return;
              // Open the page in a new view.
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => page!),
              );
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(icon, color: EyesightColors().plain, size: 30),
                Text(text, style: EyesightTextStyle().miniHeaderNegative),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
