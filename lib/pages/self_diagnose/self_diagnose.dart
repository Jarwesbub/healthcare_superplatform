import 'package:flutter/material.dart';
import 'package:healthcare_superplatform/pages/self_diagnose/self_diagnose_fatigue.dart';

class SelfDiagnosePage extends StatefulWidget {
  const SelfDiagnosePage({super.key});

  @override
  _SelfDiagnosePageState createState() => _SelfDiagnosePageState();
}

class _SelfDiagnosePageState extends State<SelfDiagnosePage> {
  Widget? selectedQuestionnaire;

  void selectQuestionnaire(Widget questionnaire) {
    setState(() {
      selectedQuestionnaire = questionnaire;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          selectedQuestionnaire == null ? 'Itsediagnosointi' : 'Takaisin',
        ),
        leading:
            selectedQuestionnaire != null
                ? IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    setState(() {
                      selectedQuestionnaire = null;
                    });
                  },
                )
                : null,
      ),
      body: selectedQuestionnaire ?? _buildSelectionMenu(),
    );
  }

  Widget _buildSelectionMenu() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed:
                () => selectQuestionnaire(const SelfDiagnoseFatiguePage()),
            child: Text('Uupumuskysely'),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Lisää kyselyt tähän
            },
            child: Text('Mielenterveyskysely (TBD)'),
          ),
        ],
      ),
    );
  }
}
