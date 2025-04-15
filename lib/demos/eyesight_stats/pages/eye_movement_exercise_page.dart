import 'package:flutter/material.dart';
import 'package:healthcare_superplatform/demos/eyesight_stats/models/eyesight_text_style.dart';
import 'package:healthcare_superplatform/demos/eyesight_stats/widgets/buttons/basic_button_widget.dart';
import 'package:healthcare_superplatform/demos/eyesight_stats/widgets/eyesight_appbar.dart';
import 'package:lottie/lottie.dart';

class EyeMovementExercisePage extends StatefulWidget {
  const EyeMovementExercisePage({super.key});

  @override
  State<EyeMovementExercisePage> createState() =>
      _EyeMovementExercisePageState();
}

class _EyeMovementExercisePageState extends State<EyeMovementExercisePage>
    with TickerProviderStateMixin {
  final List<String> tasks = [
    'Sit comfortably and relax your eyes',
    'Slowly follow the movement shown in the animation with your eyes',
    'Perform the exercise for 30-60 seconds',
    'After completing the exercise, close your eyes and take a few deep breaths',
    'Well done! Exercise completed.',
  ];
  late final AnimationController controller;
  int currentTaskIndex = 0;
  bool isExerciseCompleted = false;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this);
  }

  // Called everytime when the button is pressed.
  void _onButtonTap() {
    debugPrint('Pressed button. Current task index: $currentTaskIndex');
    if (currentTaskIndex == 0) {
      // Start animation.
      controller.reset();
      controller.repeat();
    } else if (isExerciseCompleted) {
      // Close the page.
      Navigator.pop(context);
      return;
    }
    setState(() {
      if (currentTaskIndex >= tasks.length - 2) {
        isExerciseCompleted = true;
        currentTaskIndex = tasks.length - 1;
        return;
      }
      // Proceed to the next instruction.
      currentTaskIndex++;
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EyesightAppBar(title: 'Eye Exercise', isBackButtonVisible: true),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: ListView(
              children: [
                Text(
                  'Eye Exercise Test',
                  style: EyesightTextStyle().header,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Lottie.asset(
                  'assets/animations/eyes_horizontal_movement.json',
                  repeat: false,
                  controller: controller,
                  onLoaded: (composition) {
                    controller.duration = composition.duration;
                  },
                ),
                const SizedBox(height: 20),
                _instructionsWidget(),
                const SizedBox(height: 50),
                _buttonInfoWidget(),
                BasicButtonWidget(
                  text:
                      currentTaskIndex == 0
                          ? 'Start'
                          : isExerciseCompleted
                          ? 'Exit'
                          : 'Continue',
                  onTap: () {
                    _onButtonTap();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _instructionsWidget() {
    return SizedBox(
      height: 180,
      //alignment: Alignment.center,
      child: Column(
        children: [
          const SizedBox(height: 10),
          Text(
            'Instructions:',
            style: EyesightTextStyle().label,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
          Text(
            tasks[currentTaskIndex],
            style: EyesightTextStyle().header,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buttonInfoWidget() {
    if (currentTaskIndex != 0) {
      return const SizedBox(height: 80);
    }
    return Column(
      children: [
        SizedBox(
          height: 80,
          child: const Text(
            '(Press Start to begin your exercise)',
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
