import 'package:flutter/material.dart';
import 'package:healthcare_superplatform/data/page_constants.dart';
import 'package:healthcare_superplatform/pages/test_page.dart';
import 'package:healthcare_superplatform/widgets/websites_widget.dart';
import 'package:healthcare_superplatform/pages/calculator_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final bool isMobileView =
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
      children: [
        Expanded(
          flex: 1,
          child: Container(
            height: double.infinity,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: Color(0xFF3E7455)),
              color: Color(0xFFEEFFF4),
            ),
            child: WebsitesWidget(),
          ),
        ),
        Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: _homepageContent(),
          ),
        ),
      ],
    );
  }

  Widget _homepageContent() {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final bool isMobileView =
            MediaQuery.of(context).size.width < PageConstants.mobileViewLimit;
        return GridView(
          physics: ScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1,
            crossAxisSpacing: isMobileView ? 10 : 100,
            mainAxisSpacing: isMobileView ? 10 : 100,
          ),

          children: <Widget>[
            _homePageItem(context, 'Test page', const TestPage()),
            _homePageItem(context, 'Energy Calculator', const CalculatorPage()),
          ],
        );
      },
    );
  }

  Widget _homePageItem(BuildContext context, String title, Widget page) {
    return Card(
      child: InkWell(
        onTap: () {
          // Open the given page.
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => page),
          );
        },
        child: Center(child: Text(title)),
      ),
    );
  }
}
