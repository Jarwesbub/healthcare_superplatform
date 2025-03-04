import 'package:flutter/material.dart';
import 'package:healthcare_superplatform/pages/test_page.dart';
import 'package:healthcare_superplatform/widgets/custom_appbar.dart';
import 'package:healthcare_superplatform/widgets/sidebar_widget.dart';
import 'package:healthcare_superplatform/widgets/test_screen_size_widget.dart';
import 'package:healthcare_superplatform/pages/calculator_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    const mobileViewLimit = 701;
    return Scaffold(
      appBar: CustomAppBar(title: 'Home'),
      body: Padding(
        padding: EdgeInsets.symmetric(
          // Set padding on both sides based on the screen width.
          horizontal: MediaQuery.of(context).size.width / 10,
        ),
        child:
            // Check the current screen width.
            MediaQuery.of(context).size.width < mobileViewLimit
                ? mobileView(context)
                : desktopView(context),
      ),
    );
  }

  Widget mobileView(BuildContext context) {
    return homepageContent(context);
  }

  Widget desktopView(BuildContext context) {
    const websites = {
      'Omakanta': 'https://kanta.fi/',
      'YTHS': 'https://www.yths.fi/',
      'Mehiläinen': 'https://www.mehilainen.fi/',
    };

    return Row(
      children: [
        Expanded(flex: 1, child: SidebarWidget(itemList: websites)),
        Expanded(flex: 3, child: homepageContent(context)),
      ],
    );
  }

  Widget homepageContent(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 5,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(10),
          child: TestScreenSizeWidget(),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: ElevatedButton(
            onPressed: () {
              // Open the given page.
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const TestPage()),
              );
            },
            child: const Text('Test page'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: ElevatedButton(
            onPressed: () {
              // Open the given page.
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CalculatorPage()),
              );
            },
            child: const Text('Energy Calculator'),
          ),
        ),
      ],
    );
  }
}
