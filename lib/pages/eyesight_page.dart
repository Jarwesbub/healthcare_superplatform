import 'package:flutter/material.dart';
import 'package:healthcare_superplatform/widgets/custom_appbar.dart';

class EyesightPage extends StatelessWidget {
  const EyesightPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(appBar: CustomAppBar(title: 'Your eyesight stats'));
  }
}
