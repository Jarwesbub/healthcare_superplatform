import 'package:flutter/material.dart';

// Holds all the required exercise information.
// Used in widgets and data handling.

class ExerciseTaskModel {
  ExerciseTaskModel({
    required this.id,
    required this.excercise,
    required this.duration,
    required this.icon,
    required this.completionTime,
  });
  final int id;
  final String excercise; // Exercise name.
  final int duration; // Minutes.
  final IconData icon;
  String completionTime;
}
