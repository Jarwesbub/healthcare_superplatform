import 'package:flutter/material.dart';
import 'package:healthcare_superplatform/demos/visionary_health.dart/models/eyesight_colors.dart';
import 'package:healthcare_superplatform/demos/visionary_health.dart/models/eyesight_text_style.dart';

class BasicButtonWidget extends StatelessWidget {
  const BasicButtonWidget({super.key, required this.text, required this.onTap});
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 160,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: EyesightColors().blueGradient,
        ),
      ),
      alignment: Alignment.center,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Text(text, style: EyesightTextStyle().headerNegative),
        ),
      ),
    );
  }
}
