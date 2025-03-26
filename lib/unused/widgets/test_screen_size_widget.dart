import 'package:flutter/material.dart';

// Test widget to show the screen size.

class TestScreenSizeWidget extends StatelessWidget {
  const TestScreenSizeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Set height and width of the current view.
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.green, width: 3),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Text('Screen size (test)'),
          Text('Height: ${height.toStringAsFixed(2)}'), // Round the height.
          Text('Width: ${width.toStringAsFixed(2)}'), // Round the width.
        ],
      ),
    );
  }
}
