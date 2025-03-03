import 'package:flutter/material.dart';
import 'package:healthcare_superplatform/widgets/energy_calculator.dart';

class CalculatorPage extends StatelessWidget {
  const CalculatorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        foregroundColor: Theme.of(context).colorScheme.onTertiary,
        title: Text('Calculator page'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Add padding for better spacing
        child: Column(
          children: [
            Expanded(child: EnergyCalculatorWidget()), // Your calculator widget
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Close the current page.
              },
              child: Text('Back'),
            ),
          ],
        ),
      ),
    );
  }
}
