import 'package:flutter/material.dart';
import 'package:healthcare_superplatform/unused/pages/self_diagnose/self_diagnose_fatigue.dart';
import 'package:healthcare_superplatform/unused/pages/self_diagnose/self_diagnose_health.dart';

class SelfDiagnosePage extends StatefulWidget {
  const SelfDiagnosePage({super.key});

  @override
  _SelfDiagnosePageState createState() => _SelfDiagnosePageState();
}

class _SelfDiagnosePageState extends State<SelfDiagnosePage> {
  int selectedIndex = 0;

  final List<Widget> _pages = [
    SelfDiagnoseMenu(), // Main menu
    SelfDiagnoseFatiguePage(), // Fatigue
    SelfDiagnoseHealthPage(), // General health
  ];

  void selectQuestionnaire(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: IndexedStack(index: selectedIndex, children: _pages));
  }
}

class SelfDiagnoseMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _parentState =
        context.findAncestorStateOfType<_SelfDiagnosePageState>();

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        children: [
          _diagnoseCard(context, "Uupumuskysely", 1),
          _diagnoseCard(context, "Terveyskysely", 2),
        ],
      ),
    );
  }

  Widget _diagnoseCard(BuildContext context, String title, int index) {
    final _parentState =
        context.findAncestorStateOfType<_SelfDiagnosePageState>();

    return GestureDetector(
      onTap: () => _parentState?.selectQuestionnaire(index),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
