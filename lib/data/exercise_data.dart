import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthcare_superplatform/data/exercise_data_singleton.dart';
import 'package:healthcare_superplatform/demos/visionary_health.dart/models/exercise_task_model.dart';

// List of active exercises for the demonstration.
// Saves completion times to the Singleton variable.

class ExerciseData {
  ExerciseData() {
    singletonData.init(_exercises.length);

    for (int i = 0; i < singletonData.length; i++) {
      // Set all completion times from the singleton.
      _exercises[i].completionTime = singletonData.getCompletionTimeByIndex(i);
    }
  }

  // Stores and handles completion times.
  final singletonData = ExerciseDataSingleton();

  // Hard coded eye exercises for the demonstration.
  // Can be developed further.
  final List<ExerciseTaskModel> _exercises = [
    ExerciseTaskModel(
      id: 0,
      name: 'Exercise 1 (Day)',
      duration: 5,
      icon: FontAwesomeIcons.solidSun,
      completionTime: '',
      type: 'horizontal',
    ),
    ExerciseTaskModel(
      id: 1,
      name: 'Exercise 2 (Day)',
      duration: 5,
      icon: FontAwesomeIcons.solidSun,
      completionTime: '',
      type: 'rotation',
    ),
    ExerciseTaskModel(
      id: 2,
      name: 'Exercise 3 (Day)',
      duration: 5,
      icon: FontAwesomeIcons.solidMoon,
      completionTime: '',
      type: 'horizontal',
    ),
  ];

  int get length => _exercises.length; // Getter for exercise count.

  // Get exercise data model based on the index value.
  ExerciseTaskModel getExerciseByIndex(int index) {
    return _exercises[index];
  }

  // Sets and saves completion time data.
  void setCompletionTimeByIndex(int index, String time) {
    _exercises[index].completionTime = time; // Set completion time.
    singletonData.setCompletionTime(index, time); // Save data to Singleton.
  }

  // Resets all the completion times.
  void reset() {
    singletonData.reset();
    for (var exercise in _exercises) {
      exercise.completionTime = '';
    }
  }
}
