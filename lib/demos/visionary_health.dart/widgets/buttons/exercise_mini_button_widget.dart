import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthcare_superplatform/demos/visionary_health.dart/models/exercise_task_model.dart';
import 'package:healthcare_superplatform/demos/visionary_health.dart/models/eyesight_colors.dart';
import 'package:healthcare_superplatform/demos/visionary_health.dart/models/eyesight_text_style.dart';

// Small button inside the "Today's Plan" widget in home page.

class ExerciseMiniButtonWidget extends StatelessWidget {
  const ExerciseMiniButtonWidget({
    super.key,
    required this.model,
    this.page,
    this.onPageClosed,
  });
  final ExerciseTaskModel model;
  final Widget? page;
  final Function(int)? onPageClosed;

  @override
  Widget build(BuildContext context) {
    final progressColor =
        model.completionTime.isEmpty
            ? EyesightColors().grey1
            : EyesightColors().primary;
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
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            if (page == null) {
              return;
            }
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => page!),
            ).then((_) {
              // Called when the page.
              debugPrint('Exercise completed!');
              onPageClosed?.call(model.id);
            });
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
                    Icon(model.icon, color: EyesightColors().orange0, size: 18),
                    Row(
                      children: [
                        Text(
                          model.completionTime.isEmpty
                              ? 'In Progress'
                              : 'Completed',
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
                  model.name,
                  textAlign: TextAlign.start,
                  style: EyesightTextStyle().miniLabelSecondary,
                ),
                Text(
                  '${model.duration} mins',
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
