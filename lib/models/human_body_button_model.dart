import 'package:flutter/material.dart';

// Model for the body presentation page.

class HumanBodyButtonModel {
  HumanBodyButtonModel({
    required this.name,
    required this.info,
    required this.offset,
    required this.icon,
    required this.page,
  });
  final String name;
  final String info;
  final Offset offset; // Button position based on the widget's size.
  final IconData? icon;
  final Widget? page;
}
