import 'package:flutter/material.dart';
import 'package:healthcare_superplatform/demos/eyesight_stats/models/eyesight_colors.dart';
import 'package:healthcare_superplatform/demos/eyesight_stats/models/eyesight_text_style.dart';
import 'package:healthcare_superplatform/demos/eyesight_stats/widgets/eyesight_appbar.dart';

class EyeExercisePage extends StatelessWidget {
  const EyeExercisePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EyesightAppBar(title: 'Eye Exercise', isBackButtonVisible: true),
      backgroundColor: EyesightColors().background, // Match theme
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                exerciseSection(
                  title: 'Eyes Rotation Exercise',
                  imagePath: 'assets/animations/eye_exercise.gif',
                ),
                const SizedBox(height: 40),
                exerciseSection(
                  title: 'Eyes Horizontal Exercise',
                  imagePath: 'assets/animations/eye_exercise2.gif',
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
          ), // Match theme
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        Image.asset(imagePath, width: 250, height: 250, fit: BoxFit.contain),
        const SizedBox(height: 20),
        Text(
          'Instructions:',
          style: EyesightTextStyle().title.copyWith(
            color: EyesightColors().textSecondary,
          ), // Match theme
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
          ), // Match theme
        ),
      ],
    );
  }
}
