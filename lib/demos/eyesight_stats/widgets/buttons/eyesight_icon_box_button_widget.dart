import 'package:flutter/material.dart';
import 'package:healthcare_superplatform/demos/eyesight_stats/models/eyesight_colors.dart';
import 'package:healthcare_superplatform/demos/eyesight_stats/models/eyesight_text_style.dart';

class EyesightIconBoxButtonWidget extends StatelessWidget {
  const EyesightIconBoxButtonWidget({
    super.key,
    required this.text,
    required this.icon,
    this.onTap,
  });
  final String text;
  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      width: 120,
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
            debugPrint('Tapped $text button');
            onTap;
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
    );
  }
}
