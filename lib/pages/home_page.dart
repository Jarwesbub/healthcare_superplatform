import 'package:flutter/material.dart';
import 'package:healthcare_superplatform/pages/test_page.dart';
import 'package:healthcare_superplatform/widgets/custom_appbar.dart';
import 'package:healthcare_superplatform/widgets/test_screen_size_widget.dart';
import 'package:healthcare_superplatform/pages/calculator_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Home'),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
                    MaterialPageRoute(
                      builder: (context) => const CalculatorPage(),
                    ),
                  );
                },
                child: const Text('Energy Calculator'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
