import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:healthcare_superplatform/demos/eyesight_stats/pages/eyesight_data_utils.dart';
import 'package:healthcare_superplatform/demos/eyesight_stats/widgets/charts/base_eyesight_chart.dart';

class SimplifiedKeratometryChart extends BaseEyesightChart {
  const SimplifiedKeratometryChart({
    Key? key,
    required Map<String, dynamic>? eyesightData,
  }) : super(key: key, eyesightData: eyesightData);

  @override
  Widget buildChartContent(BuildContext context) {
    // Extract keratometry data
    double leftFlatK = EyesightDataUtils.parseNumericValue(
      eyesightData?['keratometry']['left_eye']['flat_k']
    );
    double rightFlatK = EyesightDataUtils.parseNumericValue(
      eyesightData?['keratometry']['right_eye']['flat_k']
    );
    
    double leftSteepK = EyesightDataUtils.parseNumericValue(
      eyesightData?['keratometry']['left_eye']['steep_k']
    );
    double rightSteepK = EyesightDataUtils.parseNumericValue(
      eyesightData?['keratometry']['right_eye']['steep_k']
    );
    
    // Calculate astigmatism
    double leftAstigmatism = leftSteepK - leftFlatK;
    double rightAstigmatism = rightSteepK - rightFlatK;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title with info button
        buildTitle(
          'Cornea Shape',
          'Keratometry measures the curvature of your cornea (the clear front surface of your eye).'
        ),
        const SizedBox(height: 16),
        
        // Main interpretation panel
        buildInterpretationPanel(
          icon: Icons.lens_blur,
          color: Colors.blue,
          text: 'Your cornea shape affects how light focuses on your retina. Different curvatures in different directions can cause astigmatism (blurred vision).',
        ),
        const SizedBox(height: 24),
        
        // Flat K values chart
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Flat Curvature',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            // Show exact values with units
            buildMeasurementValues(
              leftLabel: '${leftFlatK.toStringAsFixed(2)} D',
              rightLabel: '${rightFlatK.toStringAsFixed(2)} D',
            ),
          ],
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 120,
          child: _buildCurvatureChart(leftFlatK, rightFlatK, 40, 48),
        ),
        const SizedBox(height: 24),
        
        // Steep K values chart
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Steep Curvature',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            // Show exact values with units
            buildMeasurementValues(
              leftLabel: '${leftSteepK.toStringAsFixed(2)} D',
              rightLabel: '${rightSteepK.toStringAsFixed(2)} D',
            ),
          ],
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 120,
          child: _buildCurvatureChart(leftSteepK, rightSteepK, 40, 48),
        ),
        const SizedBox(height: 24),
        
        // Astigmatism chart
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Astigmatism',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            // Show exact values with units
            buildMeasurementValues(
              leftLabel: '${leftAstigmatism.toStringAsFixed(2)} D',
              rightLabel: '${rightAstigmatism.toStringAsFixed(2)} D',
            ),
          ],
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 120,
          child: _buildCurvatureChart(leftAstigmatism, rightAstigmatism, 0, 3),
        ),
        const SizedBox(height: 16),
        
        // Legend and normal range indicators
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildLegendItem(Colors.blue, 'Left Eye'),
            const SizedBox(width: 24),
            buildLegendItem(Colors.green, 'Right Eye'),
          ],
        ),
        const SizedBox(height: 16),
        _buildKeratometryRangeIndicators(),
        
        // What this means section
        const SizedBox(height: 24),
        buildExplanationSection(
          'Your cornea curvature measurements show the shape of the front surface of your eye. '
          'Normal cornea curvature is between 42-46 diopters (D). Astigmatism is the difference '
          'between the steep and flat measurements. Lower astigmatism (under 1.00 D) means '
          'your cornea is more evenly curved, while higher values mean your cornea is more '
          'oval-shaped, which can cause blurred vision at different distances.'
        ),
      ],
    );
  }
  
  // Build a horizontal comparison chart
  Widget _buildCurvatureChart(double leftValue, double rightValue, double min, double max) {
    // Calculate normal range mid-point
    double normalMidPoint = (min + max) / 2;
    
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: max + 2,  // Add some padding
        minY: min - 2,  // Add some padding
        barTouchData: BarTouchData(
          enabled: true,
          touchTooltipData: BarTouchTooltipData(
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              String eye = group.x.toInt() == 0 ? 'Left Eye' : 'Right Eye';
              double value = group.x.toInt() == 0 ? leftValue : rightValue;
              return BarTooltipItem(
                '$eye: ${value.toStringAsFixed(2)} D',
                const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              );
            }
          ),
        ),
        titlesData: FlTitlesData(
          show: true,
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                String text = value.toInt() == 0 ? 'Left' : 'Right';
                return Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(text, style: const TextStyle(fontSize: 12)),
                );
              },
              reservedSize: 30,
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                if (value == min || value == max || value == normalMidPoint) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Text('${value.toStringAsFixed(1)}', style: const TextStyle(fontSize: 10)),
                  );
                }
                return const SizedBox.shrink();
              },
              reservedSize: 40,
            ),
          ),
        ),
        gridData: FlGridData(
          show: true,
          getDrawingHorizontalLine: (value) {
            Color lineColor = Colors.grey.shade200;
            double strokeWidth = 0.5;
            
            // Highlight normal range
            if (value == min || value == max) {
              lineColor = Colors.orange.withOpacity(0.3);
              strokeWidth = 1;
            } else if (value == normalMidPoint) {
              lineColor = Colors.green.withOpacity(0.3);
              strokeWidth = 1;
            }
            
            return FlLine(
              color: lineColor,
              strokeWidth: strokeWidth,
              dashArray: value == normalMidPoint ? null : [5, 5],
            );
          },
          drawVerticalLine: false,
        ),
        borderData: FlBorderData(show: false),
        barGroups: [
          BarChartGroupData(
            x: 0,
            barRods: [
              BarChartRodData(
                toY: leftValue,
                color: Colors.blue,
                width: 20,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(4),
                  topRight: Radius.circular(4),
                ),
                backDrawRodData: BackgroundBarChartRodData(
                  show: true,
                  toY: max + 2,
                  color: Colors.grey.withOpacity(0.1),
                ),
              ),
            ],
          ),
          BarChartGroupData(
            x: 1,
            barRods: [
              BarChartRodData(
                toY: rightValue,
                color: Colors.green,
                width: 20,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(4),
                  topRight: Radius.circular(4),
                ),
                backDrawRodData: BackgroundBarChartRodData(
                  show: true,
                  toY: max + 2,
                  color: Colors.grey.withOpacity(0.1),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  // Build keratometry range indicators
  Widget _buildKeratometryRangeIndicators() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Reading Your Results:',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          const SizedBox(height: 8),
          const Text(
            '• Normal cornea curvature: 42-46 D (diopters)',
            style: TextStyle(fontSize: 12),
          ),
          const Text(
            '• Normal astigmatism: < 1.00 D difference between steep and flat',
            style: TextStyle(fontSize: 12),
          ),
          const Text(
            '• Mild astigmatism: 1.00-2.00 D',
            style: TextStyle(fontSize: 12),
          ),
          const Text(
            '• Moderate astigmatism: 2.00-3.00 D',
            style: TextStyle(fontSize: 12),
          ),
          const Text(
            '• High astigmatism: > 3.00 D',
            style: TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}