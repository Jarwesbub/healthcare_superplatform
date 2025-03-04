import 'package:flutter/material.dart';
import 'package:healthcare_superplatform/pages/test_page.dart';
import 'package:healthcare_superplatform/widgets/custom_appbar.dart';
import 'package:healthcare_superplatform/widgets/custom_bottom_navbar.dart';
import 'package:healthcare_superplatform/widgets/sidebar_widget.dart';
import 'package:healthcare_superplatform/pages/calculator_page.dart';

const mobileViewLimit = 701;

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isMobileView =
        MediaQuery.of(context).size.width < mobileViewLimit;
    return Scaffold(
      appBar: CustomAppBar(title: 'Home'),
      body: Padding(
        padding: EdgeInsets.symmetric(
          // Set padding on both sides based on the screen width.
          horizontal: MediaQuery.of(context).size.width / 10,
        ),
        child: isMobileView ? _mobileView() : _desktopView(),
      ),
      bottomNavigationBar: isMobileView ? CustomNavigationBar() : null,
    );
  }

  Widget _mobileView() {
    return _homepageContent();
  }

  Widget _desktopView() {
    const websites = {
      'Omakanta': 'https://kanta.fi/',
      'YTHS': 'https://www.yths.fi/',
      'Mehiläinen': 'https://www.mehilainen.fi/',
    };

    return Row(
      children: [
        Expanded(flex: 1, child: SidebarWidget(itemList: websites)),
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
            MediaQuery.of(context).size.width < mobileViewLimit;
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
            _homePageItem(context, 'Test page2', const TestPage()),
            _homePageItem(context, 'Test page3', const TestPage()),
            _homePageItem(context, 'Test page4', const TestPage()),
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
