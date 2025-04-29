import 'package:flutter/material.dart';

// Holds all the required exercise information.
// Used in widgets and data handling.

class ExerciseTaskModel {
  ExerciseTaskModel({
    required this.id,
    required this.name,
    required this.duration,
    required this.icon,
    required this.completionTime,
    this.type,
  });
  final int id;
  final String name; // Exercise name.
  final int duration; // Minutes.
  final IconData icon;
  final String? type; // Exercise type. (rotation/horizontal)
  String completionTime;
}
