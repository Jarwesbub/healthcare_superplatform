import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EnergyCalculatorWidget extends StatefulWidget {
  final Function(double)? onEnergyScoreChanged;

  const EnergyCalculatorWidget({
    Key? key,
    this.onEnergyScoreChanged,
    required double initialSleep,
    required double initialStressLevel,
    required double initialWorkout,
    required double initialWater,
    required int initialCaffeine,
    required Null Function(
      dynamic sleep,
      dynamic stress,
      dynamic exercise,
      dynamic water,
      dynamic caffeine,
    )
    onChanged,
  }) : super(key: key);

  @override
  _EnergyCalculatorWidgetState createState() => _EnergyCalculatorWidgetState();
}

class _EnergyCalculatorWidgetState extends State<EnergyCalculatorWidget> {
  double _sleepHours = 7.0;
  double _stressLevel = 5.0;
  double _exerciseMinutes = 30.0;
  double _waterIntake = 2.0; // Liters
  int _caffeineIntake = 2; // Number of drinks

  @override
  void initState() {
    super.initState();

    // Load saved values from SharedPreferences
    _loadValues();
  }

  Future<void> _loadValues() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      _sleepHours = prefs.getDouble('sleepHours') ?? 7.0;
      _stressLevel = prefs.getDouble('stressLevel') ?? 5.0;
      _exerciseMinutes = prefs.getDouble('exerciseMinutes') ?? 30.0;
      _waterIntake = prefs.getDouble('waterIntake') ?? 2.0;
      _caffeineIntake = prefs.getInt('caffeineIntake') ?? 2;
    });
  }

  Future<void> _saveValues() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setDouble('sleepHours', _sleepHours);
    await prefs.setDouble('stressLevel', _stressLevel);
    await prefs.setDouble('exerciseMinutes', _exerciseMinutes);
    await prefs.setDouble('waterIntake', _waterIntake);
    await prefs.setInt('caffeineIntake', _caffeineIntake);
  }

  double _calculateEnergyScore() {
    // Base score is 50 (neutral)
    double score = 50.0;

    if (_sleepHours >= 7 && _sleepHours <= 9) {
      score += 20;
    } else if (_sleepHours >= 5 && _sleepHours < 7) {
      score += 10;
    } else if (_sleepHours > 9) {
      score += 5; // Too much sleep can decrease energy
    }

    score -= _stressLevel * 2;

    // Exercise factor (30-60 minutes is optimal)
    if (_exerciseMinutes >= 30 && _exerciseMinutes <= 60) {
      score += 15;
    } else if (_exerciseMinutes > 0 && _exerciseMinutes < 30) {
      score += _exerciseMinutes / 2;
    } else if (_exerciseMinutes > 60) {
      score += 15 - ((_exerciseMinutes - 60) / 10); // Diminishing returns
    }

    // Water intake (2-3 liters is optimal)
    if (_waterIntake >= 2 && _waterIntake <= 3) {
      score += 10;
    } else if (_waterIntake > 0 && _waterIntake < 2) {
      score += _waterIntake * 5;
    }

    // Caffeine (1-2 drinks might boost energy, more can lead to crash)
    if (_caffeineIntake >= 1 && _caffeineIntake <= 2) {
      score += 5;
    } else if (_caffeineIntake > 2) {
      score -= (_caffeineIntake - 2) * 3;
    }

    // Clamp the score between 0 and 100
    return score.clamp(0.0, 100.0);
  }

  // Get message and color based on energy score
  Map<String, dynamic> _getEnergyFeedback() {
    double score = _calculateEnergyScore();

    if (score >= 80) {
      return {
        'message': 'Excellent energy levels! You\'re doing great!',
        'color': Colors.green,
      };
    } else if (score >= 60) {
      return {
        'message':
            'Good energy levels. Small improvements could help you feel even better.',
        'color': Colors.lightGreen,
      };
    } else if (score >= 40) {
      return {
        'message':
            'Moderate energy. Consider adjusting your sleep, stress, or exercise routines.',
        'color': Colors.amber,
      };
    } else if (score >= 20) {
      return {
        'message':
            'Low energy levels. Try to get more sleep and reduce stress.',
        'color': Colors.orange,
      };
    } else {
      return {
        'message':
            'Very low energy. Consider consulting with a healthcare professional.',
        'color': Colors.red,
      };
    }
  }

  @override
  void didUpdateWidget(covariant EnergyCalculatorWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Notify parent widget about score changes
    if (widget.onEnergyScoreChanged != null) {
      widget.onEnergyScoreChanged!(_calculateEnergyScore());
    }
  }

  @override
  Widget build(BuildContext context) {
    final feedback = _getEnergyFeedback();
    final score = _calculateEnergyScore();

    // Notify parent widget about score changes when rebuilding
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.onEnergyScoreChanged != null) {
        widget.onEnergyScoreChanged!(score);
      }
    });

    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        // Energy score display
        Card(
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  'Your Energy Score',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 10),
                Text(
                  score.toStringAsFixed(1),
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    color: feedback['color'],
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  feedback['message'],
                  textAlign: TextAlign.center,
                  style: TextStyle(color: feedback['color']),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 20),

        // Sleep input
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Sleep(${_sleepHours.toStringAsFixed(1)} hours)'),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: () {
                        setState(() {
                          if (_sleepHours < 12) {
                            _sleepHours -= 0.5;
                            if (_sleepHours < 0) _sleepHours = 0;
                          }
                        });
                      },
                    ),
                    Expanded(
                      child: Slider(
                        min: 0,
                        max: 12,
                        divisions: 24,
                        value: _sleepHours,
                        label: _sleepHours.toStringAsFixed(1),
                        onChanged: (value) {
                          setState(() {
                            _sleepHours = value;
                          });
                          _saveValues();
                        },
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        setState(() {
                          if (_sleepHours < 12) {
                            _sleepHours += 0.5;
                            if (_sleepHours > 12) _sleepHours = 12;
                          }
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        // Stress input
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Stress Level (${_stressLevel.toStringAsFixed(1)}/10)'),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: () {
                        setState(() {
                          if (_stressLevel > 0) {
                            _stressLevel -= 0.5;
                            if (_stressLevel < 0) _stressLevel = 0;
                          }
                        });
                      },
                    ),
                    Expanded(
                      child: Slider(
                        min: 0,
                        max: 10,
                        divisions: 10,
                        value: _stressLevel,
                        label: _stressLevel.toStringAsFixed(1),
                        onChanged: (value) {
                          setState(() {
                            _stressLevel = value;
                          });
                          _saveValues();
                        },
                      ),
                    ),

                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        setState(() {
                          if (_stressLevel < 12) {
                            _stressLevel += 0.5;
                            if (_stressLevel > 12) _stressLevel = 12;
                          }
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        // Exercise input
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Exercise (${_exerciseMinutes.toStringAsFixed(0)} minutes)',
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: () {
                        setState(() {
                          if (_exerciseMinutes > 0) {
                            _exerciseMinutes -= 5;
                            if (_exerciseMinutes < 0) _exerciseMinutes = 0;
                          }
                        });
                      },
                    ),
                    Expanded(
                      child: Slider(
                        min: 0,
                        max: 120,
                        divisions: 24,
                        value: _exerciseMinutes,
                        label: _exerciseMinutes.toStringAsFixed(0),
                        onChanged: (value) {
                          setState(() {
                            _exerciseMinutes = value;
                          });
                          _saveValues();
                        },
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        setState(() {
                          if (_exerciseMinutes < 120) {
                            _exerciseMinutes += 5;
                            if (_exerciseMinutes > 120) _exerciseMinutes = 120;
                          }
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        // Water intake input
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Water Intake (${_waterIntake.toStringAsFixed(1)} liters)',
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: () {
                        setState(() {
                          if (_waterIntake > 0) {
                            _waterIntake -= 0.5;
                            if (_waterIntake < 0) _waterIntake = 0;
                          }
                        });
                      },
                    ),

                    Expanded(
                      child: Slider(
                        min: 0,
                        max: 5,
                        divisions: 10,
                        value: _waterIntake,
                        label: _waterIntake.toStringAsFixed(1),
                        onChanged: (value) {
                          setState(() {
                            _waterIntake = value;
                          });
                          _saveValues();
                        },
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        setState(() {
                          if (_waterIntake < 5) {
                            _waterIntake += 0.5;
                            if (_waterIntake > 5) _waterIntake = 5;
                          }
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        // Caffeine intake input
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Caffeine Intake ($_caffeineIntake drinks)'),

                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: () {
                        setState(() {
                          if (_caffeineIntake > 0) {
                            _caffeineIntake -= 1;
                            if (_caffeineIntake < 0) _caffeineIntake = 0;
                          }
                        });
                      },
                    ),

                    Expanded(
                      child: Slider(
                        min: 0,
                        max: 10,
                        divisions: 10,
                        value: _caffeineIntake.toDouble(),
                        label: _caffeineIntake.toString(),
                        onChanged: (value) {
                          setState(() {
                            _caffeineIntake = value.toInt();
                          });
                          _saveValues();
                        },
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        setState(() {
                          if (_caffeineIntake > 10) {
                            _caffeineIntake += 1;
                            if (_caffeineIntake > 10) _caffeineIntake = 10;
                          }
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
