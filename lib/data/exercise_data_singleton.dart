// Singleton for the eye exercise data.

class ExerciseDataSingleton {
  static final ExerciseDataSingleton _exerciseData =
      ExerciseDataSingleton._internal();
  final List<String> _completionTimes = [];

  factory ExerciseDataSingleton() {
    return _exerciseData;
  }

  // Initialize exercises by count.
  void init(int exerciseCount) {
    if (_completionTimes.isNotEmpty) return;
    for (int i = 0; i < exerciseCount; i++) {
      _completionTimes.add('');
    }
  }

  get getCompletionTimes => _completionTimes;

  get length => _completionTimes.length;

  String getCompletionTimeByIndex(int index) {
    return _completionTimes[index];
  }

  void setCompletionTime(int index, String time) {
    if (_completionTimes[index].isEmpty) {
      _completionTimes[index] = time;
    }
  }

  // Resets all the completion times.
  void reset() {
    for (int i = 0; i < _completionTimes.length; i++) {
      _completionTimes[i] = '';
    }
  }

  ExerciseDataSingleton._internal();
}
