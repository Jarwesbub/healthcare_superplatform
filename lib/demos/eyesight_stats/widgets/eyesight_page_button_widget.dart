import 'package:flutter/material.dart';
import 'package:healthcare_superplatform/demos/eyesight_stats/models/eyesight_colors.dart';
import 'package:healthcare_superplatform/demos/eyesight_stats/models/eyesight_text_style.dart';

class EyesightPageButtonWidget extends StatelessWidget {
  const EyesightPageButtonWidget({
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
    return Container(
      height: 80,
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: EyesightColors().boxColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            offset: Offset(1.0, 1.0),
            blurRadius: 1.0,
            color: EyesightColors().boxShadow,
          ),
        ],
      ),
      child: Material(
        color: EyesightColors().boxColor,
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () {
            if (page == null) {
              debugPrint('Tapped $text page');
              return;
            }
            ;
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => page!),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(text, style: EyesightTextStyle().label),
                Icon(icon, color: EyesightColors().customPrimary),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
