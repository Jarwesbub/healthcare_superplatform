import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthcare_superplatform/data/exercise_data.dart';
import 'package:healthcare_superplatform/data/page_constants.dart';
import 'package:healthcare_superplatform/demos/eyesight_stats/models/exercise_task_model.dart';
import 'package:healthcare_superplatform/demos/eyesight_stats/models/eyesight_colors.dart';
import 'package:healthcare_superplatform/demos/eyesight_stats/models/eyesight_text_style.dart';
import 'package:healthcare_superplatform/demos/eyesight_stats/pages/eye_exercise_page.dart';
import 'package:healthcare_superplatform/demos/eyesight_stats/pages/vision_test_chart_page.dart';
import 'package:healthcare_superplatform/demos/eyesight_stats/widgets/buttons/eyesight_mini_wide_button_widget.dart';
import 'package:healthcare_superplatform/demos/eyesight_stats/widgets/buttons/eyesight_page_button_widget.dart';
import 'package:healthcare_superplatform/demos/eyesight_stats/widgets/custom_circular_indicator.dart';
import 'package:intl/intl.dart';

class EyesightPlayPage extends StatefulWidget {
  const EyesightPlayPage({super.key});

  @override
  State<EyesightPlayPage> createState() => _EyesightPlayState();
}

class _EyesightPlayState extends State<EyesightPlayPage> {
  final data = ExerciseData();
  double completionPercentage = 0; // Exercise completion percentage.

  late List<ExerciseTaskModel> tasks;

  void _setExerciseCompleted(int index) {
    // Set current time.
    var timeFormat = DateFormat("HH:mm");
    String time = timeFormat.format(DateTime.now());

    setState(() {
      data.setCompletionTimeByIndex(index, time);
      tasks[index].completionTime = time;
      _calculateCompletionPercentage();
    });
  }

  // Calculates completion of the current active exercises.
  void _calculateCompletionPercentage() {
    completionPercentage = 0;
    int count = 0;
    for (final exercise in tasks) {
      if (exercise.completionTime.isNotEmpty) {
        // Updates completion time if not set yet.
        count++;
      }
    }
    double value = count / data.length;
    completionPercentage = value * 100;
  }

  // Resets all the active exercise data.
  void _resetExerciseData() {
    data.reset();
    setState(() {
      for (var task in tasks) {
        // Reset widget completion times.
        task.completionTime = '';
      }
      completionPercentage = 0;
    });
  }

  @override
  void initState() {
    super.initState();
    debugPrint('Data length: ${data.length}');
    tasks = List.generate(data.length, (index) {
      final exercise = data.getExerciseByIndex(index);
      return ExerciseTaskModel(
        id: index,
        excercise: exercise.name,
        duration: exercise.duration,
        icon: exercise.icon,
        completionTime: exercise.completionTime,
      );
    });

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
                    InkWell(
                      onTap: () {
                        _showClearDialog();
                      },
                      child: CustomCircularIndicator(
                        percentage: completionPercentage,
                      ),
                    ),
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

  // Popup window with buttons for clearing all the exercise data.
  Future<void> _showClearDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Reset all the data?'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('All the exercise data will be cleared.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                _resetExerciseData();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
