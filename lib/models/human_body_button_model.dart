import 'package:flutter/material.dart';

// Model for the body presentation page.

class HumanBodyButtonModel {
  HumanBodyButtonModel({
    required this.buttonId,
    required this.name,
    required this.info,
    required this.offset,
  });
  final int buttonId;
  final String name;
  final String info;
  final Offset offset;
  bool isActive = false;
}
