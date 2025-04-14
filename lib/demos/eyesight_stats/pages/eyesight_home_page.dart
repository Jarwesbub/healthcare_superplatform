import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthcare_superplatform/data/exercise_data.dart';
import 'package:healthcare_superplatform/data/page_constants.dart';
import 'package:healthcare_superplatform/demos/eyesight_stats/models/exercise_task_model.dart';
import 'package:healthcare_superplatform/demos/eyesight_stats/models/eyesight_colors.dart';
import 'package:healthcare_superplatform/demos/eyesight_stats/models/eyesight_text_style.dart';
import 'package:healthcare_superplatform/demos/eyesight_stats/pages/eye_exercise_page.dart';
import 'package:healthcare_superplatform/demos/eyesight_stats/pages/eyesight_progress_page.dart';
import 'package:healthcare_superplatform/demos/eyesight_stats/pages/eyesight_stats_page.dart';
import 'package:healthcare_superplatform/demos/eyesight_stats/widgets/buttons/eyesight_icon_box_button_widget.dart';
import 'package:healthcare_superplatform/demos/eyesight_stats/widgets/buttons/eyesight_mini_button_widget.dart';
import 'package:healthcare_superplatform/demos/eyesight_stats/widgets/buttons/eyesight_page_button_widget.dart';
import 'package:intl/intl.dart';

class EyesightHomePage extends StatefulWidget {
  const EyesightHomePage({super.key});

  @override
  State<EyesightHomePage> createState() => _HomePageState();
}

class _HomePageState extends State<EyesightHomePage> {
  final data = ExerciseData();
  late List<ExerciseTaskModel> tasks;

  // Buttons for the quick actions view.
  final List<EyesightIconBoxButtonWidget> quickActionButtons = [
    EyesightIconBoxButtonWidget(
      text: 'Calendar',
      icon: FontAwesomeIcons.solidCalendarCheck,
    ),
    EyesightIconBoxButtonWidget(
      text: 'Training',
      icon: FontAwesomeIcons.clipboardCheck,
    ),
    EyesightIconBoxButtonWidget(
      text: 'Tests',
      icon: FontAwesomeIcons.stopwatch,
    ),
  ];

  void _setExerciseCompleted(int index) {
    // Set current time.
    var timeFormat = DateFormat("HH:mm");
    String time = timeFormat.format(DateTime.now());

    setState(() {
      data.setCompletionTimeByIndex(index, time);
      //miniButtons[index].model.completionTime = time;
      tasks[index].completionTime = time;
    });
  }

  @override
  void initState() {
    super.initState();
    tasks = List.generate(data.length, (index) {
      return data.getExerciseByIndex(index);
    });
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
            todaysPlanView(),
            const SizedBox(height: 30),
            quickActionsView(),
            const SizedBox(height: 30),
            statsAndProgressView(),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

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
              children: List.generate(tasks.length, (index) {
                return EyesightMiniButtonWidget(
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

  Widget quickActionsView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Text('Quick Actions', style: EyesightTextStyle().header),
        ),
        ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: double.maxFinite,
            maxHeight: 100,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(quickActionButtons.length, (index) {
              return Expanded(
                child: Row(children: [quickActionButtons[index], Spacer()]),
              );
            }),
          ),
        ),
      ],
    );
  }

  Widget statsAndProgressView() {
    return Builder(
      builder: (context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Your Eye Information', style: EyesightTextStyle().header),
            EyesightPageButtonWidget(
              text: 'Stats',
              icon: FontAwesomeIcons.chartColumn,
              page: EyesightStatsPage(),
            ),
            EyesightPageButtonWidget(
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
