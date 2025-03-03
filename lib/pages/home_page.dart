import 'package:flutter/material.dart';
import 'package:healthcare_superplatform/pages/test_page.dart';
import 'package:healthcare_superplatform/widgets/test_screen_size_widget.dart';
import 'package:healthcare_superplatform/pages/calculator_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        foregroundColor: Theme.of(context).colorScheme.onTertiary,
        title: Text('Home page'),
        centerTitle: true,
      ),
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
