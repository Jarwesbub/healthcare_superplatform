import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:healthcare_superplatform/data/page_constants.dart';
import 'package:healthcare_superplatform/unused/widgets/notifications.dart';

class DemoHomePage extends StatefulWidget {
  const DemoHomePage({super.key, required this.notifications});
  final Notifications notifications;

  @override
  State<DemoHomePage> createState() => _DemoHomePageState();
}

class _DemoHomePageState extends State<DemoHomePage> {
  late bool isMobileView;
  @override
  Widget build(BuildContext context) {
    isMobileView =
        MediaQuery.of(context).size.width < PageConstants.mobileViewLimit;
    return Padding(
      padding: const EdgeInsets.all(40),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return MasonryGridView(
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isMobileView ? 2 : 3,
            ),
            children: [],
          );
        },
      ),
    );
  }
}
