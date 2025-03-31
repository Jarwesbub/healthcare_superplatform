import 'package:flutter/material.dart';
import 'package:healthcare_superplatform/demos/eyesight_stats/widgets/eyesight_appbar.dart';

class EyesightHomePage extends StatelessWidget {
  const EyesightHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EyesightAppBar(title: 'Visionary Health'),
      body: Center(),
    );
  }
}
