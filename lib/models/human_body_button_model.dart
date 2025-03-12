import 'package:flutter/material.dart';

// Model for the body presentation page.

class HumanBodyButtonModel {
  HumanBodyButtonModel({
    required this.name,
    required this.info,
    required this.offset,
  });
  final String name;
  final String info;
  final Offset offset; // Button position based on the widget's size.
}
