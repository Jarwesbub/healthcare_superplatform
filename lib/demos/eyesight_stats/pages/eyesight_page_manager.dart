import 'package:flutter/material.dart';
import 'package:healthcare_superplatform/data/page_constants.dart';
import 'package:healthcare_superplatform/demos/eyesight_stats/models/eyesight_colors.dart';
import 'package:healthcare_superplatform/demos/eyesight_stats/pages/eyesight_chatbot_page.dart';
import 'package:healthcare_superplatform/demos/eyesight_stats/pages/eyesight_home_page.dart';
import 'package:healthcare_superplatform/demos/eyesight_stats/pages/eyesight_play_page.dart';
import 'package:healthcare_superplatform/demos/eyesight_stats/widgets/eyesight_web_appbar.dart';
import 'package:healthcare_superplatform/demos/eyesight_stats/widgets/eyesight_mobile_appbar.dart';
import 'package:healthcare_superplatform/demos/eyesight_stats/widgets/eyesight_bottom_navbar.dart';

class EyesightPageManager extends StatefulWidget {
  const EyesightPageManager({super.key});

  @override
  State<EyesightPageManager> createState() => _EyesightPageManagerState();
}

class _EyesightPageManagerState extends State<EyesightPageManager> {
  late Map<String, Widget> pageList;
  late Map<String, Function?> pageActions;
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

    pageActions = {
      'Home': (index) => onButtonTap(index),
      'Play': (index) => onButtonTap(index),
      'Chat': () => onButtonTap(2),
      'Profile': () => onButtonTap(3),
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
                title: 'Visionary Health',
                pageIndex: currentPageIndex,
                pages: pageActions,
                isBackButtonVisible: false,
              ),
      backgroundColor: EyesightColors().surface,
      body: pageList.values.elementAt(currentPageIndex),
      bottomNavigationBar: EyesightNavigationBar(onButtonTap: onButtonTap),
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
