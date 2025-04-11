import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthcare_superplatform/data/page_constants.dart';
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
  // Buttons for the today's plan view.
  final List<EyesightMiniWideButtonWidget> miniButtons = [
    EyesightMiniWideButtonWidget(
      excercise: 'Eye Exercise 1 (Day)',
      time: 5,
      icon: FontAwesomeIcons.solidSun,
      completionTime: '10:05',
      page: EyeExercisePage(),
    ),
    EyesightMiniWideButtonWidget(
      excercise: 'Eye Exercise 2 (Day)',
      time: 5,
      icon: FontAwesomeIcons.solidSun,
      completionTime: null,
      page: EyeExercisePage(),
    ),
    EyesightMiniWideButtonWidget(
      excercise: 'Eye Exercise 3 (Night)',
      time: 5,
      icon: FontAwesomeIcons.solidMoon,
      completionTime: null,
      page: EyeExercisePage(),
    ),
  ];
  double completionPercentage = 33;

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
              children: List.generate(miniButtons.length, (index) {
                return miniButtons[index];
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
