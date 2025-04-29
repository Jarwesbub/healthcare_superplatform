import 'package:flutter/material.dart';

/// Utility class for handling eyesight data conversions and interpretations
class EyesightDataUtils {
  /// Converts visual acuity notation (Snellen or decimal) to a numerical value
  static double convertVisualAcuityToNumber(dynamic acuity) {
    if (acuity == null) return 0;
    
    // Convert common visual acuity notations to decimal
    if (acuity is String) {
      if (acuity.contains('/')) {
        // Handle Snellen notation (e.g., 20/20, 6/6)
        List<String> parts = acuity.split('/');
        if (parts.length == 2) {
          double numerator = double.tryParse(parts[0]) ?? 20;
          double denominator = double.tryParse(parts[1]) ?? 20;
          if (denominator != 0) {
            return numerator / denominator;
          }
        }
      } else if (acuity.contains('.')) {
        // Handle decimal notation directly
        return double.tryParse(acuity) ?? 1.0;
      }
    }
    
    return 1.0; // Default to 1.0 if parsing fails
  }
  
  /// Parses a numeric value from any string, stripping non-numeric characters
  static double parseNumericValue(dynamic value) {
    if (value == null) return 0;
    if (value is num) return value.toDouble();
    if (value is String) {
      // Remove any units like 'mm' or 'D'
      String cleanedValue = value.replaceAll(RegExp(r'[^\d.-]'), '');
      return double.tryParse(cleanedValue) ?? 0;
    }
    return 0;
  }
  
  /// Converts decimal visual acuity to Snellen notation
  static String decimalToSnellen(double decimal) {
    if (decimal <= 0) return "N/A";
    
    // Standard conversion for 20/x notation
    int denominator = (20 / decimal).round();
    return "20/$denominator";
  }
  
  /// Gets a simple interpretation of visual acuity values
  static String getVisualAcuityInterpretation(double leftValue, double rightValue) {
    double avgVision = (leftValue + rightValue) / 2;
    
    if (avgVision >= 1.2) {
      return 'Your vision is better than average. You can see details that many people might miss.';
    } else if (avgVision >= 0.8) {
      return 'Your vision is normal. Most everyday tasks should be comfortable without correction.';
    } else if (avgVision >= 0.5) {
      return 'Your vision is slightly below average. You might benefit from glasses for some activities.';
    } else if (avgVision >= 0.3) {
      return 'Your vision is moderately reduced. Glasses or contacts would help for daily activities.';
    } else {
      return 'Your vision is significantly reduced. Glasses or contacts are recommended.';
    }
  }
  
  /// Gets a detailed explanation of visual acuity values
  static String getVisualAcuityExplanation(double leftValue, double rightValue) {
    double avgVision = (leftValue + rightValue) / 2;
    
    if (avgVision >= 1.2) {
      return 'Having vision better than 20/20 means you can see details from farther away than most people. This might be helpful for activities like driving, sports, or anything requiring distance vision.';
    } else if (avgVision >= 0.8) {
      return 'Your vision is close to what eye doctors consider "normal" (20/20). At this level, you can read standard text and see objects at a distance without significant difficulty.';
    } else if (avgVision >= 0.5) {
      return 'With slightly reduced vision, you might have occasional difficulty with distant road signs, movie screens, or other faraway objects. Reading might be more comfortable with glasses.';
    } else if (avgVision >= 0.3) {
      return 'At this level, everyday tasks like reading, using a computer, or recognizing faces at a distance may be challenging without correction. Glasses or contacts would make a noticeable difference.';
    } else {
      return 'With significantly reduced vision, many daily activities are challenging without correction. Glasses or contacts would make a substantial improvement in your visual comfort and ability.';
    }
  }
  
  /// Gets a simple interpretation of intraocular pressure values
  static String getIOPInterpretation(double leftValue, double rightValue) {
    double avgPressure = (leftValue + rightValue) / 2;
    
    if (avgPressure < 10) {
      return 'Your eye pressure is lower than average. This is usually not a concern unless you have other eye conditions.';
    } else if (avgPressure <= 21) {
      return 'Your eye pressure is within the normal range. This is good news for your eye health.';
    } else if (avgPressure <= 30) {
      return 'Your eye pressure is slightly elevated. Your doctor may want to monitor this over time.';
    } else {
      return 'Your eye pressure is significantly elevated. This may need further evaluation by your doctor.';
    }
  }
  
  /// Gets a detailed explanation of intraocular pressure values
  static String getIOPDetailedExplanation(double leftValue, double rightValue) {
    double avgPressure = (leftValue + rightValue) / 2;
    
    if (avgPressure < 10) {
      return 'Low eye pressure is typically not a concern unless you have other eye conditions. Your doctor might want to monitor this over time to ensure it stays stable.';
    } else if (avgPressure <= 21) {
      return 'Your eye pressure is in the normal range. Normal eye pressure helps maintain the eye\'s shape and supports proper function. Maintaining a healthy lifestyle can help keep your eye pressure at this level.';
    } else if (avgPressure <= 30) {
      return 'Slightly elevated eye pressure may increase your risk for glaucoma over time. Your doctor might recommend more frequent check-ups or additional testing to monitor for any signs of eye damage.';
    } else {
      return 'Significantly elevated eye pressure requires attention as it may damage your optic nerve over time, potentially leading to vision loss if not treated. Follow your doctor\'s recommendations closely.';
    }
  }
  
  /// Gets an appropriate icon based on eye pressure
  static IconData getIOPIcon(double leftValue, double rightValue) {
    double avgPressure = (leftValue + rightValue) / 2;
    
    if (avgPressure < 10) {
      return Icons.arrow_downward;
    } else if (avgPressure <= 21) {
      return Icons.check_circle;
    } else if (avgPressure <= 30) {
      return Icons.warning;
    } else {
      return Icons.error;
    }
  }
  
  /// Gets an appropriate color based on eye pressure
  static Color getIOPColor(double leftValue, double rightValue) {
    double avgPressure = (leftValue + rightValue) / 2;
    
    if (avgPressure < 10) {
      return Colors.blue;
    } else if (avgPressure <= 21) {
      return Colors.green;
    } else if (avgPressure <= 30) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }
  
  /// Gets an icon based on vision quality
  static IconData getVisionIcon(double leftValue, double rightValue) {
    double avgVision = (leftValue + rightValue) / 2;
    
    if (avgVision >= 1.2) {
      return Icons.visibility; // Excellent vision
    } else if (avgVision >= 0.8) {
      return Icons.remove_red_eye; // Normal vision
    } else if (avgVision >= 0.5) {
      return Icons.visibility_outlined; // Moderately reduced
    } else {
      return Icons.visibility_off_outlined; // Significantly reduced
    }
  }
}