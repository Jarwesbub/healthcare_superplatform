import 'package:flutter/material.dart';
import 'package:healthcare_superplatform/demos/eyesight_stats/models/eyesight_colors.dart';
import 'package:healthcare_superplatform/demos/eyesight_stats/models/eyesight_text_style.dart';

class EyesightMiniButtonWidget extends StatelessWidget {
  const EyesightMiniButtonWidget({
    super.key,
    required this.day,
    required this.excercise,
    required this.mins,
    required this.icon,
    this.page,
  });
  final String day;
  final String excercise;
  final int mins;
  final IconData icon;
  final Widget? page;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: const EdgeInsets.all(6),
      child: Material(
        color: EyesightColors().grey0,
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          onTap: () {
            if (page == null) {
              debugPrint('Tapped $excercise ($day) button');
              return;
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(icon, color: EyesightColors().grey2, size: 18),
                    Text(day, style: EyesightTextStyle().miniHeader),
                  ],
                ),
                Text(
                  excercise,
                  textAlign: TextAlign.start,
                  style: EyesightTextStyle().miniLabelSecondary,
                ),
                Text(
                  '$mins mins',
                  textAlign: TextAlign.start,
                  style: EyesightTextStyle().miniLabelMain,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
