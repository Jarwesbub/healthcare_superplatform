import 'package:flutter/material.dart';
import 'package:healthcare_superplatform/unused/widgets/energy_calculator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:healthcare_superplatform/unused/widgets/notifications.dart';

class CalculatorPage extends StatefulWidget {
  final Notifications notifications;
  //const CalculatorPage({super.key, required this.notifications});
  const CalculatorPage({Key? key, required this.notifications})
    : super(key: key);

  @override
  _CalculatorPageState createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  double _sleepHours = 7.0;
  double _stressLevel = 5.0;
  double _exerciseMinutes = 30.0;
  double _waterIntake = 2.0;
  int _caffeineIntake = 2;

  @override
  void initState() {
    super.initState();
    _loadValues(); // Load saved values when page opens
  }

  Future<void> _loadValues() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _sleepHours = prefs.getDouble('sleep') ?? 7.0;
      _stressLevel = prefs.getDouble('stress') ?? 5.0;
      _exerciseMinutes = prefs.getDouble('exercise') ?? 30.0;
      _waterIntake = prefs.getDouble('water') ?? 2.0;
      _caffeineIntake = prefs.getInt('caffeine') ?? 2;
    });
  }

  Future<void> _saveValues() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('sleep', _sleepHours);
    await prefs.setDouble('stress', _stressLevel);
    await prefs.setDouble('exercise', _exerciseMinutes);
    await prefs.setDouble('water', _waterIntake);
    await prefs.setInt('caffeine', _caffeineIntake);
  }

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
            Expanded(
              child: EnergyCalculatorWidget(
                initialSleep: _sleepHours,
                initialStressLevel: _stressLevel,
                initialWorkout: _exerciseMinutes,
                initialWater: _waterIntake,
                initialCaffeine: _caffeineIntake,
                onChanged: (sleep, stress, exercise, water, caffeine) {
                  setState(() {
                    _sleepHours = sleep;
                    _stressLevel = stress;
                    _exerciseMinutes = exercise;
                    _waterIntake = water;
                    _caffeineIntake = caffeine;
                  });
                  _saveValues();
                }, // Save new values
              ),
            ), // Your calculator widget
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Close the current page.
              },
              child: Text('Back'),
            ),
            ElevatedButton(
              onPressed: () {
                widget.notifications.showNotification(); // Show notification
              },
              child: Text('Notification tester'),
            ),
          ],
        ),
      ),
    );
  }
}
