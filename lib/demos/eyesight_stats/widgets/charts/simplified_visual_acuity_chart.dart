import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:healthcare_superplatform/demos/eyesight_stats/pages/eyesight_data_utils.dart';
import 'package:healthcare_superplatform/demos/eyesight_stats/widgets/charts/base_eyesight_chart.dart';

class SimplifiedVisualAcuityChart extends BaseEyesightChart {
  const SimplifiedVisualAcuityChart({
    Key? key,
    required Map<String, dynamic>? eyesightData,
  }) : super(key: key, eyesightData: eyesightData);

  @override
  Widget buildChartContent(BuildContext context) {
    // Extract visual acuity data
    double leftVisualAcuity = EyesightDataUtils.convertVisualAcuityToNumber(
      eyesightData?['visual_acuity']['left_eye'],
    );
    double rightVisualAcuity = EyesightDataUtils.convertVisualAcuityToNumber(
      eyesightData?['visual_acuity']['right_eye'],
    );

    // Get Snellen notation equivalents for display
    String leftSnellen = EyesightDataUtils.decimalToSnellen(leftVisualAcuity);
    String rightSnellen = EyesightDataUtils.decimalToSnellen(rightVisualAcuity);

    // Get a simple interpretation text
    String interpretationText = EyesightDataUtils.getVisualAcuityInterpretation(
      leftVisualAcuity,
      rightVisualAcuity,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title with info button
        buildTitle(
          'How Well You See',
          'Visual acuity measures how clearly you can see. 20/20 is considered normal vision.',
        ),
        const SizedBox(height: 16),

        // Main interpretation text
        buildInterpretationPanel(
          icon: EyesightDataUtils.getVisionIcon(
            leftVisualAcuity,
            rightVisualAcuity,
          ),
          color: Colors.blue,
          text: interpretationText,
        ),
        const SizedBox(height: 24),

        // Simple comparison chart with exact values
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Center(
              child: const Text(
                'Your Vision Compared to Normal',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
            // Show exact values
            RichText(
              text: TextSpan(
                style: const TextStyle(fontSize: 14, color: Colors.black87),
                children: [
                  TextSpan(
                    text: 'Left: ',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: '${leftVisualAcuity.toStringAsFixed(2)} ',
                    style: TextStyle(color: Colors.blue),
                  ),
                  TextSpan(
                    text: 'Right: ',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: '${rightVisualAcuity.toStringAsFixed(2)}',
                    style: TextStyle(color: Colors.green),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 180,
          child: _buildSimpleChart(leftVisualAcuity, rightVisualAcuity),
        ),
        const SizedBox(height: 16),

        // Legend
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildLegendItem(Colors.blue, 'Left Eye'),
            const SizedBox(width: 24),
            _buildLegendItem(Colors.green, 'Right Eye'),
            const SizedBox(width: 24),
            _buildLegendItem(Colors.grey.shade300, 'Normal Vision'),
          ],
        ),

        // What this means section
        const SizedBox(height: 24),
        const Text(
          'What This Means',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        Text(
          EyesightDataUtils.getVisualAcuityExplanation(
            leftVisualAcuity,
            rightVisualAcuity,
          ),
          style: const TextStyle(fontSize: 14, height: 1.4),
        ),
      ],
    );
  }

  // Build a simplified horizontal bar chart
  Widget _buildSimpleChart(double leftValue, double rightValue) {
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: 1.5,
        minY: 0,
        barTouchData: BarTouchData(
          enabled: true,
          touchTooltipData: BarTouchTooltipData(
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              String label;
              switch (group.x.toInt()) {
                case 0:
                  label = 'Left Eye: ${leftValue.toStringAsFixed(2)}';
                  break;
                case 1:
                  label = 'Right Eye: ${rightValue.toStringAsFixed(2)}';
                  break;
                case 2:
                  label = 'Normal: 1.00';
                  break;
                default:
                  label = '';
              }
              return BarTooltipItem(
                label,
                const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              );
            },
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
                String text = '';
                switch (value.toInt()) {
                  case 0:
                    text = 'Left Eye';
                    break;
                  case 1:
                    text = 'Right Eye';
                    break;
                  case 2:
                    text = 'Normal';
                    break;
                }
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
                if (value == 0.5) {
                  return const Padding(
                    padding: EdgeInsets.only(right: 8),
                    child: Text('Reduced', style: TextStyle(fontSize: 10)),
                  );
                } else if (value == 1.0) {
                  return const Padding(
                    padding: EdgeInsets.only(right: 8),
                    child: Text('Normal', style: TextStyle(fontSize: 10)),
                  );
                } else if (value == 1.5) {
                  return const Padding(
                    padding: EdgeInsets.only(right: 8),
                    child: Text('Sharp', style: TextStyle(fontSize: 10)),
                  );
                }
                return const SizedBox.shrink();
              },
              reservedSize: 50,
            ),
          ),
        ),
        gridData: FlGridData(
          show: true,
          getDrawingHorizontalLine: (value) {
            if (value == 1.0) {
              // Highlight the normal vision line
              return FlLine(
                color: Colors.black,
                strokeWidth: 1,
                dashArray: [5, 5],
              );
            }
            return FlLine(color: Colors.grey.shade200, strokeWidth: 0.5);
          },
          horizontalInterval: 0.5,
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
                // Show the value on top of the bar
                backDrawRodData: BackgroundBarChartRodData(
                  show: true,
                  toY: 1.5,
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
                // Show the value on top of the bar
                backDrawRodData: BackgroundBarChartRodData(
                  show: true,
                  toY: 1.5,
                  color: Colors.grey.withOpacity(0.1),
                ),
              ),
            ],
          ),
          BarChartGroupData(
            x: 2,
            barRods: [
              BarChartRodData(
                toY: 1.0, // Normal vision
                color: Colors.grey.shade300,
                width: 20,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(4),
                  topRight: Radius.circular(4),
                ),
                // Show the value on top of the bar
                backDrawRodData: BackgroundBarChartRodData(
                  show: true,
                  toY: 1.5,
                  color: Colors.grey.withOpacity(0.1),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Simple legend item
  Widget _buildLegendItem(Color color, String label) {
    return Row(
      children: [
        Container(width: 14, height: 14, color: color),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}
