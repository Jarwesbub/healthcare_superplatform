import 'package:flutter/material.dart';
import 'package:healthcare_superplatform/demos/visionary_health.dart/models/eyesight_colors.dart';

// Circular percentage indicator.
// Used in the Today's Tasks widget in the play view.

class CustomCircularIndicator extends StatelessWidget {
  const CustomCircularIndicator({super.key, required this.percentage});
  final double percentage;

  @override
  Widget build(BuildContext context) {
    final Color color =
        percentage >= 99 ? EyesightColors().green0 : EyesightColors().orange0;
    return // Circular score indicator (enlarged)
    Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey.shade100,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          CircularProgressIndicator(
            value: percentage / 100,
            strokeWidth: 5,
            backgroundColor: Colors.grey.shade200,
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
          FittedBox(
            child: Text(
              ' ${percentage.round()}%',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
