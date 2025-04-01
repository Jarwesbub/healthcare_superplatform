import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:healthcare_superplatform/demos/eyesight_stats/models/eyesight_colors.dart';
import 'package:healthcare_superplatform/demos/eyesight_stats/models/eyesight_text_style.dart';
import 'package:healthcare_superplatform/demos/eyesight_stats/widgets/eyesight_appbar.dart';

class VisionTestChartPage extends StatefulWidget {
  const VisionTestChartPage({super.key});

  @override
  State<VisionTestChartPage> createState() => _VisionTestChartState();
}

class _VisionTestChartState extends State<VisionTestChartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EyesightAppBar(title: 'Quick test', isBackButtonVisible: true),
      backgroundColor: EyesightColors().surface,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        child: Column(
          children: [
            Flexible(
              flex: 3,
              child: Column(
                children: List.generate(7, (index) {
                  index += 2;
                  return imageRow(index);
                }),
              ),
            ),
            Flexible(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(top: 40),
                child: startButton(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget imageRow(int columnIndex) {
    return Row(
      spacing: 10,
      children: List.generate(columnIndex, (index) {
        // Generate random number.
        int rand = Random().nextInt(4);
        return Expanded(
          child: AspectRatio(
            aspectRatio: 1,
            child: RotatedBox(
              quarterTurns: rand,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: SvgPicture.asset('assets/images/open_circle.svg'),
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget startButton() {
    return SizedBox(
      width: 120,
      height: 40,
      child: Material(
        borderRadius: BorderRadius.circular(8),
        color: EyesightColors().customPrimary,
        child: InkWell(
          onTap: () {
            debugPrint('Tapped start button');
          },
          child: Center(
            child: Text(
              'Start test',
              textAlign: TextAlign.center,
              style: EyesightTextStyle().title,
            ),
          ),
        ),
      ),
    );
  }
}
