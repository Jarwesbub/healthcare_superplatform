import 'package:flutter/material.dart';

class VisionImageModel extends ChangeNotifier {
  final int id;
  Color _color = Colors.grey;

  VisionImageModel({required this.id});

  Color get color => _color;

  set color(Color newColor) {
    _color = newColor;
    notifyListeners(); // Notify listeners when the color changes
  }
}
