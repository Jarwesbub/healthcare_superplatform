import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthcare_superplatform/data/page_constants.dart';
import 'package:healthcare_superplatform/demos/eyesight_stats/models/eyesight_colors.dart';
import 'package:healthcare_superplatform/demos/eyesight_stats/models/eyesight_text_style.dart';
import 'package:healthcare_superplatform/demos/eyesight_stats/pages/eye_exercise_page.dart';
import 'package:healthcare_superplatform/demos/eyesight_stats/pages/eyesight_stats_page.dart';
import 'package:healthcare_superplatform/demos/eyesight_stats/pages/vision_test_chart_page.dart';
import 'package:healthcare_superplatform/demos/eyesight_stats/widgets/eyesight_mini_button_widget.dart';
import 'package:healthcare_superplatform/demos/eyesight_stats/widgets/eyesight_page_button_widget.dart';

class EyesightHomePage extends StatefulWidget {
  const EyesightHomePage({super.key});

  @override
  State<EyesightHomePage> createState() => _HomePageState();
}

class _HomePageState extends State<EyesightHomePage> {
  final List<EyesightMiniButtonWidget> miniButtons = [
    EyesightMiniButtonWidget(
      excercise: 'Eye Exercise 1 (Day)',
      time: 5,
      icon: FontAwesomeIcons.solidSun,
      isCompleted: true,
      page: null,
    ),
    EyesightMiniButtonWidget(
      excercise: 'Eye Exercise 2 (Day)',
      time: 5,
      icon: FontAwesomeIcons.solidSun,
      isCompleted: false,
      page: null,
    ),
    EyesightMiniButtonWidget(
      excercise: 'Eye Exercise 3 (Night)',
      time: 5,
      icon: FontAwesomeIcons.solidMoon,
      isCompleted: false,
      page: null,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: PageConstants.mobileViewLimit.toDouble(),
        ),
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          children: [todaysPlanView(), mainPagesView(), infoPagesView()],
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
                child: Text("Today's plan:", style: EyesightTextStyle().header),
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
              children: List.generate(miniButtons.length, (index) {
                return miniButtons[index];
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget mainPagesView() {
    return Builder(
      builder: (context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(top: 30, bottom: 10),
              child: Text('Your eye health', style: EyesightTextStyle().header),
            ),
            EyesightPageButtonWidget(
              text: 'Stats',
              icon: FontAwesomeIcons.chartColumn,
              page: EyesightStatsPage(),
            ),
            EyesightPageButtonWidget(
              text: 'Training',
              icon: FontAwesomeIcons.listCheck,
              page: EyeExercisePage(),
            ),
            EyesightPageButtonWidget(
              text: 'Quick test',
              icon: FontAwesomeIcons.clock,
              page: const VisionTestChartPage(),
            ),
            EyesightPageButtonWidget(
              text: 'Eye filter',
              icon: FontAwesomeIcons.eyeLowVision,
              page: null,
            ),
          ],
        );
      },
    );
  }
}

Widget infoPagesView() {
  return Builder(
    builder: (context) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30, bottom: 10),
            child: Text(
              'Information center',
              style: EyesightTextStyle().header,
            ),
          ),
          EyesightPageButtonWidget(
            text: 'Contact your eye doctor',
            icon: FontAwesomeIcons.stethoscope,
            page: null,
          ),
          EyesightPageButtonWidget(
            text: 'Compare your stats',
            icon: FontAwesomeIcons.leftRight,
            page: null,
          ),
        ],
      );
    },
  );
}
