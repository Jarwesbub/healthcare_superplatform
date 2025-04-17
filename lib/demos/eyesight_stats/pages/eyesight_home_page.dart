import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthcare_superplatform/data/exercise_data.dart';
import 'package:healthcare_superplatform/data/page_constants.dart';
import 'package:healthcare_superplatform/demos/eyesight_stats/models/exercise_task_model.dart';
import 'package:healthcare_superplatform/demos/eyesight_stats/models/eyesight_colors.dart';
import 'package:healthcare_superplatform/demos/eyesight_stats/models/eyesight_text_style.dart';
import 'package:healthcare_superplatform/demos/eyesight_stats/pages/eye_movement_exercise_page.dart';
import 'package:healthcare_superplatform/demos/eyesight_stats/pages/eyesight_progress_page.dart';
import 'package:healthcare_superplatform/demos/eyesight_stats/pages/eyesight_statistics_page.dart';
import 'package:healthcare_superplatform/demos/eyesight_stats/pages/vision_test_chart_page.dart';
import 'package:healthcare_superplatform/demos/eyesight_stats/widgets/buttons/quick_action_button_widget.dart';
import 'package:healthcare_superplatform/demos/eyesight_stats/widgets/buttons/exercise_mini_button_widget.dart';
import 'package:healthcare_superplatform/demos/eyesight_stats/widgets/buttons/normal_page_button_widget.dart';
import 'package:intl/intl.dart';

class EyesightHomePage extends StatefulWidget {
  const EyesightHomePage({super.key});

  @override
  State<EyesightHomePage> createState() => _HomePageState();
}

class _HomePageState extends State<EyesightHomePage> {
  final data = ExerciseData(); // Data handling and storing.
  late List<ExerciseTaskModel> exercises; // Model for the exercise widgets.

  // Buttons for the quick actions view.
  final List<QuickActionButtonWidget> quickActionButtons = [
    QuickActionButtonWidget(
      text: 'Training',
      icon: FontAwesomeIcons.clipboardCheck,
      page: EyeMovementExercisePage(),
    ),
    QuickActionButtonWidget(
      text: 'Tests',
      icon: FontAwesomeIcons.stopwatch,
      page: VisionTestChartPage(),
    ),
    QuickActionButtonWidget(
      text: 'Contact',
      icon: FontAwesomeIcons.solidAddressCard,
      page: null,
    ),
  ];

  // Called when the exercise is completed.
  // Current build calls this automatically when the exercise page is closed.
  void _setExerciseCompleted(int index) {
    // Set current time.
    var timeFormat = DateFormat("HH:mm");
    String time = timeFormat.format(DateTime.now());

    setState(() {
      // Update exercise data by the index/id.
      data.setCompletionTimeByIndex(index, time);
      exercises[index].completionTime = time;
    });
  }

  @override
  void initState() {
    super.initState();
    // Update task information when initialized.
    exercises = List.generate(data.length, (index) {
      return data.getExerciseByIndex(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: PageConstants.maxViewWidth.toDouble(),
        ),
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          children: [
            todaysPlanView(),
            const SizedBox(height: 30),
            quickActionsView(MediaQuery.of(context).size.width),
            const SizedBox(height: 30),
            statsAndProgressView(),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  // Shows all the exercises of the day in more compact way.
  Widget todaysPlanView() {
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text("Today's Plan:", style: EyesightTextStyle().header),
              ),
              // Upper left corner arrow button.
              IconButton(
                onPressed: () {},
                icon: Icon(
                  FontAwesomeIcons.angleRight,
                  size: 18,
                  color: EyesightColors().grey1,
                ),
              ),
            ],
          ),
          ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: double.maxFinite,
              maxHeight: 100,
            ),
            child: ListView(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              children: List.generate(exercises.length, (index) {
                return ExerciseMiniButtonWidget(
                  model: exercises[index],
                  page: EyeMovementExercisePage(),
                  setIsCompleted: _setExerciseCompleted,
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  // Buttons for quick actions.
  Widget quickActionsView(double screenWidth) {
    final double padding = screenWidth / 40;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Text('Quick Actions', style: EyesightTextStyle().header),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            quickActionButtons[0],
            SizedBox(width: padding),
            quickActionButtons[1],
            SizedBox(width: padding),
            quickActionButtons[2],
          ],
        ),
      ],
    );
  }

  // Shows your eye information including stats and progress.
  Widget statsAndProgressView() {
    return Builder(
      builder: (context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Your Eye Information', style: EyesightTextStyle().header),
            NormalPageButtonWidget(
              text: 'Stats',
              icon: FontAwesomeIcons.chartColumn,
              page: EyesightStatisticsPage(),
            ),
            NormalPageButtonWidget(
              text: 'Progress',
              icon: FontAwesomeIcons.listCheck,
              page: EyesightProgressPage(),
            ),
          ],
        );
      },
    );
  }
}
