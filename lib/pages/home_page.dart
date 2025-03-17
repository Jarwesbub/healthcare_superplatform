import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:healthcare_superplatform/data/page_constants.dart';
import 'package:healthcare_superplatform/pages/body_presentation.dart';
import 'package:healthcare_superplatform/pages/test_page.dart';
import 'package:healthcare_superplatform/widgets/websites_widget.dart';
import 'package:healthcare_superplatform/pages/calculator_page.dart';
import 'package:healthcare_superplatform/pages/self_diagnose/self_diagnose.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late bool isMobileView;

  @override
  Widget build(BuildContext context) {
    isMobileView =
        MediaQuery.of(context).size.width < PageConstants.mobileViewLimit;

    if (isMobileView) {
      return _mobileView();
    }
    return _desktopView();
  }

  Widget _mobileView() {
    return _homepageContent();
  }

  Widget _desktopView() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left side bar.
        Expanded(
          flex: 2,
          child: Container(color: Color(0xFFEEFFF4), child: WebsitesWidget()),
        ),
        // Center content.
        Expanded(flex: 6, child: _homepageContent()),
        // Right side bar.
        Expanded(flex: 1, child: const SizedBox()),
      ],
    );
  }

  Widget _homepageContent() {
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
            children: [
              _homePageItem(context, 'Test page', const TestPage()),
              _homePageItem(
                context,
                'Energy Calculator',
                const CalculatorPage(),
              ),
              _homePageItem(
                context,
                'Itsediagnosointi',
                const SelfDiagnosePage(),
              ), // Add new pages here ->
              _homePageItem(
                context,
                'Visual body presentation',
                const BodyPresentation(),
              ),
            ],
          );
        },
      ),
    );
  }

  // Simple button widget to navigate to the given page.
  Widget _homePageItem(BuildContext context, String text, Widget page) {
    return SizedBox(
      width: 50,
      height: 180,
      child: Card(
        child: InkWell(
          onTap: () {
            // Open the given page.
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => page),
            );
          },
          child: Center(child: Text(text, textAlign: TextAlign.center)),
        ),
      ),
    );
  }
}
