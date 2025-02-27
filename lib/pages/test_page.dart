import 'package:flutter/material.dart';
import 'package:healthcare_superplatform/widgets/custom_appbar.dart';

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Test page'),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context); // Close the current page.
          },
          child: Text('Back'),
        ),
      ),
    );
  }
}
