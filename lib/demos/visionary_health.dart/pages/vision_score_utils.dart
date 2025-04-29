import 'package:flutter/material.dart';

class VisionScoreUtils {
  static double calculateVisionScore(Map<String, dynamic>? data) {
    if (data == null) return 0.0;
    
    double leftVA = convertVisualAcuityToScore(data['visual_acuity']['left_eye']);
    double rightVA = convertVisualAcuityToScore(data['visual_acuity']['right_eye']);
    
    double leftPressure = parseDouble(data['intraocular_pressure']['left_eye']);
    double rightPressure = parseDouble(data['intraocular_pressure']['right_eye']);
    double pressureScore = calculatePressureScore(leftPressure, rightPressure);
    
    double leftFlatK = parseDouble(data['keratometry']['left_eye']['flat_k']);
    double rightFlatK = parseDouble(data['keratometry']['right_eye']['flat_k']);
    double leftSteepK = parseDouble(data['keratometry']['left_eye']['steep_k']);
    double rightSteepK = parseDouble(data['keratometry']['right_eye']['steep_k']);
    double keratometryScore = calculateKeratometryScore(leftFlatK, rightFlatK, leftSteepK, rightSteepK);
    
    double score = (leftVA + rightVA) * 0.35 + // 70% for visual acuity
                  pressureScore * 0.15 +     // 15% for pressure
                  keratometryScore * 0.15;   // 15% for keratometry
    
    return 45 + score * 55;
  }
  
  static double convertVisualAcuityToScore(dynamic acuity) {
    if (acuity == null) return 0.5;
    
    if (acuity is String && acuity.contains('/')) {
      List<String> parts = acuity.split('/');
      if (parts.length == 2) {
        double numerator = double.tryParse(parts[0]) ?? 20;
        double denominator = double.tryParse(parts[1]) ?? 20;
        if (denominator != 0) {
          double ratio = numerator / denominator;
          
          // Convert to a 0-1 score where 1.0 is perfect vision (20/20 or better)
          if (ratio >= 1.0) return 1.0;  // 20/20 or better
          if (ratio >= 0.5) return 0.8;  // 20/40
          if (ratio >= 0.33) return 0.6; // 20/60
          if (ratio >= 0.25) return 0.4; // 20/80
          if (ratio >= 0.1) return 0.2;  // 20/200
          return 0.0;                    // worse than 20/200
        }
      }
    }
    
    return 0.5;
  }
  
  static double calculatePressureScore(double leftPressure, double rightPressure) {
    double avgPressure = (leftPressure + rightPressure) / 2;
    
    // Normal pressure is 12-22 mmHg
    if (avgPressure >= 12 && avgPressure <= 22) {
      return 1.0; // Perfect score for normal pressure
    } else if (avgPressure >= 10 && avgPressure <= 24) {
      return 0.8; // Slightly outside normal range
    } else if (avgPressure >= 8 && avgPressure <= 28) {
      return 0.5; // Moderately outside normal range
    } else {
      return 0.2; // Significantly outside normal range
    }
  }
  
  static double calculateKeratometryScore(double leftFlatK, double rightFlatK, 
                                         double leftSteepK, double rightSteepK) {
    double avgFlatK = (leftFlatK + rightFlatK) / 2;
    double avgSteepK = (leftSteepK + rightSteepK) / 2;
    double avgK = (avgFlatK + avgSteepK) / 2;
    double leftAstigmatism = leftSteepK - leftFlatK;
    double rightAstigmatism = rightSteepK - rightFlatK;
    double avgAstigmatism = (leftAstigmatism + rightAstigmatism) / 2;
    
    double kScore = 0.0;
    if (avgK >= 42 && avgK <= 46) {
      kScore = 1.0;
    } else if (avgK >= 40 && avgK <= 48) {
      kScore = 0.7;
    } else {
      kScore = 0.4;
    }
    
    double astigmatismScore = 0.0;
    if (avgAstigmatism < 1.0) {
      astigmatismScore = 1.0; // Little to no astigmatism
    } else if (avgAstigmatism < 2.0) {
      astigmatismScore = 0.8; // Mild astigmatism
    } else if (avgAstigmatism < 3.0) {
      astigmatismScore = 0.6; // Moderate astigmatism
    } else {
      astigmatismScore = 0.4; // Severe astigmatism
    }
    
    return kScore * 0.4 + astigmatismScore * 0.6;
  }
  
  static double parseDouble(dynamic value) {
    if (value == null) return 0;
    if (value is num) return value.toDouble();
    if (value is String) {
      // Remove any units like 'mm' or 'D'
      String cleanedValue = value.replaceAll(RegExp(r'[^\d.-]'), '');
      return double.tryParse(cleanedValue) ?? 0;
    }
    return 0;
  }

  static String getVisionStatus(double score) {
    if (score >= 90) return 'Excellent';
    if (score >= 80) return 'Very Good';
    if (score >= 70) return 'Good';
    if (score >= 60) return 'Fair';
    return 'Needs Attention';
  }
  
  static Color getScoreColor(double score) {
    if (score >= 85) {
      return Colors.green;
    } else if (score >= 70) {
      return Colors.amber;
    } else {
      return Colors.redAccent;
    }
  }
}