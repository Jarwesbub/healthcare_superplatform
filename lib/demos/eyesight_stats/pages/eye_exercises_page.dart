import 'package:flutter/material.dart';
import 'package:healthcare_superplatform/demos/eyesight_stats/models/eyesight_colors.dart';
import 'package:healthcare_superplatform/demos/eyesight_stats/models/eyesight_text_style.dart';
import 'package:healthcare_superplatform/demos/eyesight_stats/widgets/eyesight_appbar.dart';
import 'package:lottie/lottie.dart';

class EyeExercisesPage extends StatefulWidget {
  const EyeExercisesPage({super.key});

  @override
  State<EyeExercisesPage> createState() => _EyeExercisesPageState();
}

class _EyeExercisesPageState extends State<EyeExercisesPage>
    with TickerProviderStateMixin {
  late final AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this);
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () => controller.stop(),
                      child: const Text('Pause'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        controller.reset();
                        controller.forward();
                      },
                      child: const Text('Play'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        controller.reset();
                        controller.repeat();
                      },
                      child: const Text('Repeat'),
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

  Widget exerciseSection({required String title, required String imagePath}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          title,
          style: EyesightTextStyle().header.copyWith(
            color: EyesightColors().textPrimary,
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        Text(
          'Instructions:',
          style: EyesightTextStyle().title.copyWith(
            color: EyesightColors().textSecondary,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          '1. Sit comfortably and relax your eyes.\n'
          '2. Slowly follow the movement shown in the animation with your eyes.\n'
          '3. Perform the exercise for 30-60 seconds.\n'
          '4. After completing the exercise, close your eyes and take a few deep breaths.',
          style: EyesightTextStyle().label.copyWith(
            color: EyesightColors().textSecondary,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
