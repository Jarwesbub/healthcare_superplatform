import 'package:flutter/material.dart';
import 'package:healthcare_superplatform/data/page_constants.dart';
import 'package:healthcare_superplatform/pages/device_data_page.dart';
import 'package:healthcare_superplatform/pages/home_page.dart';
import 'package:healthcare_superplatform/pages/services_page.dart';
import 'package:healthcare_superplatform/widgets/custom_appbar.dart';
import 'package:healthcare_superplatform/widgets/custom_bottom_navbar.dart';
import 'package:healthcare_superplatform/widgets/notifications.dart';

class PageManager extends StatefulWidget {
  final Notifications notifications;
  const PageManager({super.key, required this.notifications});

  @override
  State<PageManager> createState() => _PageManagerState();
}

class _PageManagerState extends State<PageManager> {
  final Map<String, Widget> pageList = {
    'Home': HomePage(notifications: widget.notifications),
    'Services': Center(child: const ServicesPage()),
    'Devices': Center(child: const DeviceDataPage()), // Test.
    'Profile': Center(child: const Text('<profile here>')), // Test.
  };
  late bool isMobileView;
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    pageList = {
      'Home': HomePage(notifications: widget.notifications),
      'Services': Center(child: const ServicesPage()),
      'Devices': Center(child: const Text('<devices here>')), // Test.
      'Profile': Center(child: const Text('<profile here>')), // Test.
    };
  }

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
