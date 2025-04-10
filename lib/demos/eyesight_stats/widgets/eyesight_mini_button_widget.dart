import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthcare_superplatform/demos/eyesight_stats/models/eyesight_colors.dart';
import 'package:healthcare_superplatform/demos/eyesight_stats/models/eyesight_text_style.dart';

class EyesightMiniButtonWidget extends StatelessWidget {
  const EyesightMiniButtonWidget({
    super.key,
    required this.excercise,
    required this.time,
    required this.icon,
    required this.isCompleted,
    this.page,
  });
  final String excercise; // Exercise name.
  final int time; // Minutes.
  final IconData icon;
  final bool isCompleted;
  final Widget? page;

  @override
  Widget build(BuildContext context) {
    final progressColor =
        isCompleted ? EyesightColors().primary : EyesightColors().grey1;
    return Container(
      height: 120,
      width: 160,
      margin: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: EyesightColors().plain,
        border: Border.all(color: EyesightColors().primary, width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Material(
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          onTap: () {
            if (page == null) {
              debugPrint('Tapped $excercise button');
              return;
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(icon, color: EyesightColors().yellow0, size: 18),
                    Row(
                      children: [
                        Text(
                          isCompleted ? 'Completed' : 'In Progress',
                          style: TextStyle(color: progressColor, fontSize: 12),
                        ),
                        const SizedBox(width: 5),
                        Icon(
                          FontAwesomeIcons.solidCircleCheck,
                          color: progressColor,
                          size: 18,
                        ),
                      ],
                    ),
                  ],
                ),
                Text(
                  excercise,
                  textAlign: TextAlign.start,
                  style: EyesightTextStyle().miniLabelSecondary,
                ),
                Text(
                  '$time mins',
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
