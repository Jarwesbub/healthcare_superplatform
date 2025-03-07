import 'package:flutter/material.dart';
import 'package:healthcare_superplatform/data/page_constants.dart';
import 'package:healthcare_superplatform/pages/home_page.dart';
import 'package:healthcare_superplatform/pages/services_page.dart';
import 'package:healthcare_superplatform/widgets/custom_appbar.dart';
import 'package:healthcare_superplatform/widgets/custom_bottom_navbar.dart';

class PageManager extends StatefulWidget {
  const PageManager({super.key});

  @override
  State<PageManager> createState() => _PageManagerState();
}

class _PageManagerState extends State<PageManager> {
  final Map<String, Widget> pageList = {
    'Home': const HomePage(),
    'Services': Center(child: const ServicesPage()),
    'Devices': Center(child: const Text('<devices here>')), // Test.
    'Profile': Center(child: const Text('<profile here>')), // Test.
  };
  late bool isMobileView;
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    isMobileView =
        MediaQuery.of(context).size.width < PageConstants.mobileViewLimit;

    return Scaffold(
      appBar: CustomAppBar(title: pageList.keys.elementAt(currentPage)),
      body: pageList.values.elementAt(currentPage),
      bottomNavigationBar:
          isMobileView ? CustomNavigationBar(onButtonTap: onButtonTap) : null,
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
