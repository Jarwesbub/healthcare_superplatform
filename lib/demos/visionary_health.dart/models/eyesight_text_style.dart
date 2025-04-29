import 'package:flutter/material.dart';
import 'package:healthcare_superplatform/demos/visionary_health.dart/models/eyesight_colors.dart';

class EyesightTextStyle {
  final title = TextStyle(
    color: Colors.white,
    fontSize: 20,
    fontWeight: FontWeight.w600,
  );
  final header = TextStyle(
    color: EyesightColors().onSurface,
    fontSize: 18,
    fontWeight: FontWeight.w500,
  );
  final headerNegative = TextStyle(
    color: EyesightColors().plain,
    fontSize: 18,
    fontWeight: FontWeight.w500,
  );
  final label = TextStyle(
    color: EyesightColors().customSecondary,
    fontSize: 18,
    fontWeight: FontWeight.w500,
  );

  final miniHeader = TextStyle(color: EyesightColors().onSurface, fontSize: 14);
  final miniHeaderNegative = TextStyle(
    color: EyesightColors().plain,
    fontSize: 12,
    fontWeight: FontWeight.w500,
  );
  final miniLabelMain = TextStyle(
    color: EyesightColors().onSurface,
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );
  final miniLabelSecondary = TextStyle(
    color: EyesightColors().onSurface,
    fontSize: 12,
  );
}
