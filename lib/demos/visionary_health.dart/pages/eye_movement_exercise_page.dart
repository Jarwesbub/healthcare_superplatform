import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:healthcare_superplatform/demos/visionary_health.dart/models/eyesight_colors.dart';
import 'package:healthcare_superplatform/demos/visionary_health.dart/models/eyesight_text_style.dart';
import 'package:healthcare_superplatform/demos/visionary_health.dart/widgets/buttons/basic_button_widget.dart';
import 'package:healthcare_superplatform/demos/visionary_health.dart/widgets/eyesight_mobile_appbar.dart';
import 'package:lottie/lottie.dart';

class EyeMovementExercisePage extends StatefulWidget {
  const EyeMovementExercisePage({super.key, this.exerciseType});
  final String? exerciseType; // Horizontal-/rotation exercise.

  @override
  State<EyeMovementExercisePage> createState() =>
      _EyeMovementExercisePageState();
}

class _EyeMovementExercisePageState extends State<EyeMovementExercisePage>
    with TickerProviderStateMixin {
  // 0 = idle, 1 = exercise start, 2 = exercise completed.
  late final AnimationController animationController;
  late final ConfettiController confettiController;
  int currentTaskIndex = 0;
  List<String> instructions = ['Sit comfortably and relax your eyes'];
  String buttonText = 'Start';
  bool isExerciseCompleted = false;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this);
    confettiController = ConfettiController(
      duration: const Duration(seconds: 2),
    );
  }

  // Called everytime when the button is pressed.
  void _onButtonTap() {
    debugPrint('Pressed button. Current task index: $currentTaskIndex');

    switch (currentTaskIndex) {
      case 0: // Start animation.
        _animationPlay();
        instructions = [
          'Slowly follow the movement shown in the animation with your eyes',
          'Perform the exercise for 30-60 seconds',
          'After completing the exercise, close your eyes and take a few deep breaths',
        ];
        buttonText = 'Finish';
        break;
      case 1: // Stop animation.
        _animationStop();
        instructions = ['Well done! Exercise completed.'];
        buttonText = 'Close';
        confettiController.play();
        break;
      case _: // Default.
        isExerciseCompleted = true;
        break;
    }

    if (isExerciseCompleted) {
      // Close the page.
      Navigator.pop(context);
      return;
    }

    setState(() {
      currentTaskIndex++;
    });
  }

  void _animationPlay() {
    // Start animation.
    animationController.reset();
    animationController.repeat();
  }

  void _animationStop() {
    animationController.reset();
    animationController.stop();
  }

  @override
  void dispose() {
    // Dispose all the controllers.
    animationController.dispose();
    confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EyesightMobileAppBar(
        title:
            widget.exerciseType == 'rotation'
                ? 'Eye Rotation Exercise'
                : 'Horizontal Eye Exercise',
        isBackButtonVisible: true,
      ),
      backgroundColor: EyesightColors().background,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  flex: 2,
                  child: Lottie.asset(
                    widget.exerciseType == 'rotation'
                        ? 'assets/animations/eyes_rotation_arrow.json'
                        : 'assets/animations/eyes_horizontal_arrow.json',
                    repeat: false,
                    controller: animationController,
                    onLoaded: (composition) {
                      animationController.duration = composition.duration;
                    },
                  ),
                ),
                // Confetti animation widget.
                ConfettiWidget(
                  confettiController: confettiController,
                  shouldLoop: false,
                  blastDirectionality: BlastDirectionality.explosive,
                ),
                Expanded(flex: 3, child: _instructionsWidget()),
                BasicButtonWidget(
                  text: buttonText,
                  onTap: () {
                    _onButtonTap();
                  },
                ),
                const SizedBox(height: 40), // Bottom padding.
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _instructionsWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          currentTaskIndex >= 2 ? '' : 'Instructions:',
          style: EyesightTextStyle().label,
        ),
        const SizedBox(height: 20),
        ...List.generate(instructions.length, (index) {
          if (instructions.length == 1) {
            // Text in a single line.
            return Text(
              instructions[0],
              style: EyesightTextStyle().label.copyWith(
                color: EyesightColors().textSecondary,
                fontSize: 18,
              ),
            );
          }

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 12,
              children: [
                Text(
                  '${index + 1}',
                  style: EyesightTextStyle().label.copyWith(
                    color: EyesightColors().textSecondary,
                    fontSize: 16,
                  ),
                ),
                Expanded(
                  child: Text(
                    instructions[index],
                    style: EyesightTextStyle().label.copyWith(
                      color: EyesightColors().textSecondary,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
}
