import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthcare_superplatform/data/page_constants.dart';
import 'package:healthcare_superplatform/demos/eyesight_stats/models/exercise_task_model.dart';
import 'package:healthcare_superplatform/demos/eyesight_stats/models/eyesight_colors.dart';
import 'package:healthcare_superplatform/demos/eyesight_stats/models/eyesight_text_style.dart';
import 'package:healthcare_superplatform/demos/eyesight_stats/pages/eye_exercise_page.dart';
import 'package:healthcare_superplatform/demos/eyesight_stats/pages/vision_test_chart_page.dart';
import 'package:healthcare_superplatform/demos/eyesight_stats/widgets/buttons/eyesight_mini_wide_button_widget.dart';
import 'package:healthcare_superplatform/demos/eyesight_stats/widgets/buttons/eyesight_page_button_widget.dart';
import 'package:healthcare_superplatform/demos/eyesight_stats/widgets/custom_circular_indicator.dart';

class EyesightPlayPage extends StatefulWidget {
  const EyesightPlayPage({super.key});

  @override
  State<EyesightPlayPage> createState() => _EyesightPlayState();
}

class _EyesightPlayState extends State<EyesightPlayPage> {
  List<ExerciseTaskModel> tasks = [
    ExerciseTaskModel(
      id: 0,
      excercise: 'excercise 1 (Day)',
      duration: 5,
      icon: FontAwesomeIcons.solidSun,
      completionTime: '10.06',
    ),
    ExerciseTaskModel(
      id: 1,
      excercise: 'excercise 2 (Day)',
      duration: 5,
      icon: FontAwesomeIcons.solidSun,
      completionTime: '',
    ),
    ExerciseTaskModel(
      id: 2,
      excercise: 'excercise 3 (Night)',
      duration: 5,
      icon: FontAwesomeIcons.solidMoon,
      completionTime: '',
    ),
  ];

  // Buttons for the today's plan view.
  double completionPercentage = 0;

  void _setExerciseCompleted(int id) {
    //final String completionTime = DateTime.now() as String;
    debugPrint('Called completion time');
    setState(() {
      tasks[id].completionTime = '10:00';
      _calculateCompletionPercentage();
    });
  }

  void _calculateCompletionPercentage() {
    completionPercentage = 0;
    int count = 0;
    for (final exercise in tasks) {
      if (exercise.completionTime.isNotEmpty) {
        count++;
      }
    }
    double value = count / tasks.length;
    completionPercentage = value * 100;
    debugPrint('$completionPercentage');
  }

  @override
  void initState() {
    super.initState();
    _calculateCompletionPercentage();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: PageConstants.mobileViewLimit.toDouble(),
        ),
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          children: [
            todaysTasksView(),
            const SizedBox(height: 30),
            eyeExerciseListView(),
          ],
        ),
      ),
    );
  }

  Widget todaysTasksView() {
    return Container(
      width: 500,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: EyesightColors().boxColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            offset: Offset(0.0, 1.0),
            blurRadius: 4.0,
            color: EyesightColors().boxShadow,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Today's Tasks", style: EyesightTextStyle().header),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        'Completion:',
                        style: EyesightTextStyle().miniHeader,
                      ),
                    ),
                    // Test icon.
                    CustomCircularIndicator(percentage: completionPercentage),
                  ],
                ),
              ],
            ),
          ),
          ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: double.maxFinite,
              maxHeight: 500,
            ),
            child: ListView(
              shrinkWrap: true,
              children: List.generate(tasks.length, (index) {
                return EyesightMiniWideButtonWidget(
                  model: tasks[index],
                  page: EyeExercisePage(),
                  setIsCompleted: _setExerciseCompleted,
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget eyeExerciseListView() {
    return Builder(
      builder: (context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Train & Check', style: EyesightTextStyle().header),
            EyesightPageButtonWidget(
              text: 'Exercise',
              icon: FontAwesomeIcons.clipboardCheck,
              page: EyeExercisePage(),
            ),
            EyesightPageButtonWidget(
              text: 'Quick test',
              icon: FontAwesomeIcons.solidClock,
              page: VisionTestChartPage(),
            ),
          ],
        );
      },
    );
  }
}
