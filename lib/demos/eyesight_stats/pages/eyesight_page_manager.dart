import 'package:flutter/material.dart';
import 'package:healthcare_superplatform/data/page_constants.dart';
import 'package:healthcare_superplatform/demos/eyesight_stats/models/eyesight_colors.dart';
import 'package:healthcare_superplatform/demos/eyesight_stats/pages/eyesight_chatbot_page.dart';
import 'package:healthcare_superplatform/demos/eyesight_stats/pages/eyesight_home_page.dart';
import 'package:healthcare_superplatform/demos/eyesight_stats/pages/eyesight_progress_page.dart';
import 'package:healthcare_superplatform/demos/eyesight_stats/widgets/eyesight_appbar.dart';
import 'package:healthcare_superplatform/demos/eyesight_stats/widgets/eyesight_bottom_navbar.dart';

class EyesightPageManager extends StatefulWidget {
  const EyesightPageManager({super.key});

  @override
  State<EyesightPageManager> createState() => _EyesightPageManagerState();
}

class _EyesightPageManagerState extends State<EyesightPageManager> {
  late Map<String, Widget> pageList;
  late bool isMobileView;
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    pageList = {
      'Home': EyesightHomePage(),
      'Progress': EyesightProgressPage(),
      'Chat': EyesightChatbotPage(),
      'Profile': Center(child: const Text('Profile')),
    };
  }

  @override
  Widget build(BuildContext context) {
    isMobileView =
        MediaQuery.of(context).size.width < PageConstants.mobileViewLimit;

    return Scaffold(
      appBar: EyesightAppBar(
        title: 'Visionary Health',
        isBackButtonVisible: false,
      ),
      backgroundColor: EyesightColors().surface,
      body: pageList.values.elementAt(currentPage),
      bottomNavigationBar:
          isMobileView ? EyesightNavigationBar(onButtonTap: onButtonTap) : null,
    );
  }

  // Called when the bottom navigation bar's button is pressed.
  void onButtonTap(int index) {
    debugPrint('Pressed navigation button $index');
    setState(() {
      currentPage = index;
    });
  }
}
