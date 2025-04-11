import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthcare_superplatform/demos/eyesight_stats/models/eyesight_colors.dart';
import 'package:healthcare_superplatform/demos/eyesight_stats/models/eyesight_text_style.dart';

class EyesightMiniWideButtonWidget extends StatelessWidget {
  const EyesightMiniWideButtonWidget({
    super.key,
    required this.excercise,
    required this.time,
    required this.icon,
    required this.completionTime,
    this.page,
  });
  final String excercise; // Exercise name.
  final int time; // Minutes.
  final IconData icon;
  final String? completionTime;
  final Widget? page;

  @override
  Widget build(BuildContext context) {
    final progressColor =
        completionTime != null
            ? EyesightColors().primary
            : EyesightColors().grey1;
    return Container(
      height: 88,
      margin: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: EyesightColors().plain,
        border: Border.all(color: EyesightColors().primary, width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            if (page == null) {
              debugPrint('Tapped $excercise button');
              return;
            }
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => page!),
            ).then((_) {
              debugPrint('Exercise closed!'); // Test.
            });
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      excercise,
                      textAlign: TextAlign.start,
                      style: EyesightTextStyle().miniHeader,
                    ),
                    Icon(
                      FontAwesomeIcons.solidCircleCheck,
                      color: progressColor,
                      size: 18,
                    ),
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(icon, color: EyesightColors().orange0, size: 18),
                        const SizedBox(width: 10),
                        Text(
                          '$time mins',
                          textAlign: TextAlign.start,
                          style: EyesightTextStyle().miniLabelMain,
                        ),
                      ],
                    ),
                    Text(
                      completionTime != null
                          ? 'Completed at $completionTime'
                          : 'In Progress',
                      style: TextStyle(color: progressColor, fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
