import 'package:flutter/material.dart';
import 'package:healthcare_superplatform/widgets/test_screen_size_widget.dart';

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
          children: <Widget>[TestScreenSizeWidget()],
        ),
      ),
    );
  }
}
