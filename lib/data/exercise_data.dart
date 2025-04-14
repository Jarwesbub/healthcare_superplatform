// Singleton for the eye exercise data.

class ExerciseData {
  static final ExerciseData _exerciseData = ExerciseData._internal();
  final List<String> _completionTimes = [];

  factory ExerciseData() {
    return _exerciseData;
  }

  void init(int exerciseCount) {
    if (_completionTimes.isNotEmpty) return;
    for (int i = 0; i < exerciseCount; i++) {
      _completionTimes.add('');
    }
  }

  get getCompletionTimes => _completionTimes;

  get getCompletionTimesLength => _completionTimes.length;

  String getCompletionTimeByIndex(int index) {
    return _completionTimes[index];
  }

  void setCompletionTime(int index, String time) {
    if (_completionTimes[index].isEmpty) {
      _completionTimes[index] = time;
    }
  }

  void reset() {
    for (int i = 0; i < _completionTimes.length; i++) {
      _completionTimes[i] = '';
    }
  }

  ExerciseData._internal();
}
