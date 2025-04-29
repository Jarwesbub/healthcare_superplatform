import 'package:flutter/material.dart';
import 'package:healthcare_superplatform/data/page_constants.dart';
import 'package:healthcare_superplatform/demos/visionary_health.dart/models/eyesight_colors.dart';
import 'package:healthcare_superplatform/demos/visionary_health.dart/pages/eyesight_chatbot_page.dart';
import 'package:healthcare_superplatform/demos/visionary_health.dart/pages/eyesight_home_page.dart';
import 'package:healthcare_superplatform/demos/visionary_health.dart/pages/eyesight_play_page.dart';
import 'package:healthcare_superplatform/demos/visionary_health.dart/widgets/eyesight_web_appbar.dart';
import 'package:healthcare_superplatform/demos/visionary_health.dart/widgets/eyesight_mobile_appbar.dart';
import 'package:healthcare_superplatform/demos/visionary_health.dart/widgets/eyesight_bottom_navbar.dart';

class EyesightPageManager extends StatefulWidget {
  const EyesightPageManager({super.key});

  @override
  State<EyesightPageManager> createState() => _EyesightPageManagerState();
}

class _EyesightPageManagerState extends State<EyesightPageManager> {
  late Map<String, Widget> pageList;
  late bool isMobileView;
  int currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    pageList = {
      'Home': EyesightHomePage(),
      'Play': EyesightPlayPage(),
      'Chat': EyesightChatbotPage(),
      'Profile': Center(child: const Text('Profile')),
    };
  }

  @override
  Widget build(BuildContext context) {
    isMobileView =
        MediaQuery.of(context).size.width < PageConstants.mobileViewLimit;

    return Scaffold(
      appBar:
          isMobileView
              ? EyesightMobileAppBar(
                title: 'Visionary Health',
                isBackButtonVisible: false,
              )
              : EyesightWebAppBar(
                buttonTitles: List.of(pageList.keys),
                onButtonTap: onButtonTap,
              ),
      backgroundColor: EyesightColors().surface,
      body: pageList.values.elementAt(currentPageIndex),
      bottomNavigationBar:
          isMobileView ? EyesightNavigationBar(onButtonTap: onButtonTap) : null,
    );
  }

  // Called when the bottom navigation bar's button is pressed.
  void onButtonTap(int index) {
    debugPrint('Pressed navigation button $index');
    setState(() {
      currentPageIndex = index;
    });
  }
}
