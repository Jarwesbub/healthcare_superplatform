import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:healthcare_superplatform/demos/eyesight_stats/models/eyesight_colors.dart';
import 'package:healthcare_superplatform/demos/eyesight_stats/models/eyesight_text_style.dart';

// Chart Widget
class EyesightComparisonChart extends StatelessWidget {
  final Map<String, dynamic>? eyesightData;
  final bool isKeratometry;

  const EyesightComparisonChart({
    super.key,
    required this.eyesightData,
    this.isKeratometry = false,
  });

  @override
  Widget build(BuildContext context) {
    if (eyesightData == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          isKeratometry
              ? 'Keratometry Comparison'
              : 'Visual Metrics Comparison',
          style: EyesightTextStyle().header,
        ),
        const SizedBox(height: 10),
        Text(
          'Your eyes compared to average values',
          style: EyesightTextStyle().miniHeader,
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: isKeratometry ? 300 : 200,
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.spaceAround,
              maxY: isKeratometry ? 50 : 25,
              barTouchData: BarTouchData(
                enabled: true,
                touchTooltipData: BarTouchTooltipData(
                  getTooltipItem: (group, groupIndex, rod, rodIndex) {
                    String eyeSide =
                        rodIndex == 0
                            ? 'Left Eye'
                            : rodIndex == 1
                            ? 'Right Eye'
                            : 'Average';
                    return BarTooltipItem(
                      '$eyeSide\n${rod.toY.toStringAsFixed(1)}',
                      const TextStyle(color: Colors.white),
                    );
                  },
                ),
              ),
              titlesData: FlTitlesData(
                show: true,
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          _getMetricName(value.toInt(), isKeratometry),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      );
                    },
                    reservedSize: 40,
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: true, reservedSize: 40),
                ),
                topTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                rightTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
              ),
              gridData: FlGridData(
                show: true,
                horizontalInterval: isKeratometry ? 10 : 5,
              ),
              borderData: FlBorderData(show: false),
              barGroups: _getBarGroups(isKeratometry),
            ),
          ),
        ),
        const SizedBox(height: 20),
        _buildLegend(),
      ],
    );
  }

  Widget _buildLegend() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _legendItem(EyesightColors().primary, "Left Eye"),
        const SizedBox(width: 20),
        _legendItem(EyesightColors().secondary, "Right Eye"),
        const SizedBox(width: 20),
        _legendItem(Colors.grey, "Average"),
      ],
    );
  }

  Widget _legendItem(Color color, String label) {
    return Row(
      children: [
        Container(width: 16, height: 16, color: color),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  List<BarChartGroupData> _getBarGroups(bool isKeratometry) {
    if (isKeratometry) {
      // Keratometry data
      double leftFlatK = _parseDouble(
        eyesightData?['keratometry']['left_eye']['flat_k'],
      );
      double rightFlatK = _parseDouble(
        eyesightData?['keratometry']['right_eye']['flat_k'],
      );
      double avgFlatK = 43.5; // Average value

      double leftSteepK = _parseDouble(
        eyesightData?['keratometry']['left_eye']['steep_k'],
      );
      double rightSteepK = _parseDouble(
        eyesightData?['keratometry']['right_eye']['steep_k'],
      );
      double avgSteepK = 44.2; // Average value

      double leftAxis = _parseDouble(
        eyesightData?['keratometry']['left_eye']['axis'],
      );
      double rightAxis = _parseDouble(
        eyesightData?['keratometry']['right_eye']['axis'],
      );
      double avgAxis = 90.0; // Average value

      return [
        _createBarGroup(0, [leftFlatK, rightFlatK, avgFlatK]),
        _createBarGroup(1, [leftSteepK, rightSteepK, avgSteepK]),
        _createBarGroup(2, [leftAxis, rightAxis, avgAxis]),
      ];
    } else {
      // Visual metrics data
      double leftVisualAcuity = _convertVisualAcuityToNumber(
        eyesightData?['visual_acuity']['left_eye'],
      );
      double rightVisualAcuity = _convertVisualAcuityToNumber(
        eyesightData?['visual_acuity']['right_eye'],
      );
      double avgVisualAcuity = 1.0; // 20/20 vision

      double leftIOP = _parseDouble(
        eyesightData?['intraocular_pressure']['left_eye'],
      );
      double rightIOP = _parseDouble(
        eyesightData?['intraocular_pressure']['right_eye'],
      );
      double avgIOP = 16.0; // Average value

      return [
        _createBarGroup(0, [
          leftVisualAcuity,
          rightVisualAcuity,
          avgVisualAcuity,
        ]),
        _createBarGroup(1, [leftIOP, rightIOP, avgIOP]),
      ];
    }
  }

  BarChartGroupData _createBarGroup(int x, List<double> values) {
    List<BarChartRodData> rods = [];

    for (int i = 0; i < values.length; i++) {
      Color rodColor;
      if (i == 0) {
        rodColor = EyesightColors().primary;
      } else if (i == 1) {
        rodColor = EyesightColors().secondary;
      } else {
        rodColor = Colors.grey;
      }

      rods.add(
        BarChartRodData(
          toY: values[i],
          color: rodColor,
          width: 15,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(6),
            topRight: Radius.circular(6),
          ),
        ),
      );
    }

    return BarChartGroupData(x: x, barRods: rods);
  }

  double _parseDouble(dynamic value) {
    if (value == null) return 0;
    if (value is num) return value.toDouble();
    if (value is String) {
      // Remove any units like 'mm' or 'D'
      String cleanedValue = value.replaceAll(RegExp(r'[^\d.-]'), '');
      return double.tryParse(cleanedValue) ?? 0;
    }
    return 0;
  }

  double _convertVisualAcuityToNumber(dynamic acuity) {
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

  String _getMetricName(int index, bool isKeratometry) {
    if (isKeratometry) {
      switch (index) {
        case 0:
          return 'Flat K';
        case 1:
          return 'Steep K';
        case 2:
          return 'Axis';
        default:
          return '';
      }
    } else {
      switch (index) {
        case 0:
          return 'Visual Acuity';
        case 1:
          return 'IOP (mmHg)';
        default:
          return '';
      }
    }
  }
}
