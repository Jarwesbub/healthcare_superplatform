import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthcare_superplatform/demos/eyesight_stats/models/exercise_task_model.dart';
import 'package:healthcare_superplatform/demos/eyesight_stats/models/eyesight_colors.dart';
import 'package:healthcare_superplatform/demos/eyesight_stats/models/eyesight_text_style.dart';

// Eyesight exercise button widget from the play view.

class ExerciseButtonWidget extends StatelessWidget {
  const ExerciseButtonWidget({
    super.key,
    required this.model,
    this.page,
    this.setIsCompleted,
  });
  final ExerciseTaskModel model;
  final Widget? page;
  final Function(int)? setIsCompleted;

  @override
  Widget build(BuildContext context) {
    final progressColor =
        model.completionTime.isEmpty
            ? EyesightColors().grey1
            : EyesightColors().primary;
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
              debugPrint('Tapped ${model.excercise} button');
              return;
            }
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => page!),
            ).then((_) {
              // Called when the page.
              debugPrint('Exercise completed!');
              setIsCompleted?.call(model.id);
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
                      model.excercise,
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
                        Icon(
                          model.icon,
                          color: EyesightColors().orange0,
                          size: 18,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          '${model.duration} mins',
                          textAlign: TextAlign.start,
                          style: EyesightTextStyle().miniLabelMain,
                        ),
                      ],
                    ),
                    Text(
                      model.completionTime.isEmpty
                          ? 'In Progress'
                          : 'Completed at ${model.completionTime}',
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
