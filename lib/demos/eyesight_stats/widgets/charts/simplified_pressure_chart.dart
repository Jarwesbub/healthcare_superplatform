import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:healthcare_superplatform/demos/eyesight_stats/models/eyesight_colors.dart';
import 'package:healthcare_superplatform/demos/eyesight_stats/pages/eyesight_data_utils.dart';

class SimplifiedPressureChart extends StatelessWidget {
  final Map<String, dynamic>? eyesightData;
  
  const SimplifiedPressureChart({
    Key? key,
    required this.eyesightData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (eyesightData == null) {
      return const Center(child: CircularProgressIndicator());
    }
    
    // Extract eye pressure data
    double leftPressure = EyesightDataUtils.parseNumericValue(
      eyesightData?['intraocular_pressure']['left_eye']
    );
    double rightPressure = EyesightDataUtils.parseNumericValue(
      eyesightData?['intraocular_pressure']['right_eye']
    );
    
    // Get interpretation
    String interpretationText = EyesightDataUtils.getIOPInterpretation(
      leftPressure, rightPressure
    );
    
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title with info button
            Row(
              children: [
                const Text(
                  'Eye Pressure',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 8),
                Tooltip(
                  message: 'Eye pressure is the fluid pressure inside your eye. Normal pressure is between 12-22 mmHg.',
                  child: Icon(Icons.info_outline, 
                    size: 18, 
                    color: Colors.blue[300]
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            // Main interpretation with gauge-like visual
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _getPressureColor(leftPressure, rightPressure).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: _getPressureColor(leftPressure, rightPressure).withOpacity(0.3)
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    _getPressureIcon(leftPressure, rightPressure),
                    size: 36,
                    color: _getPressureColor(leftPressure, rightPressure),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      interpretationText,
                      style: const TextStyle(
                        fontSize: 16,
                        height: 1.3,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            
            // Horizontal linear gauge chart with exact values
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Your Eye Pressure',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                // Show exact values with units
                RichText(
                  text: TextSpan(
                    style: const TextStyle(fontSize: 14, color: Colors.black87),
                    children: [
                      TextSpan(
                        text: 'Left: ',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: '${leftPressure.toStringAsFixed(1)} mmHg  ',
                        style: TextStyle(color: Colors.blue),
                      ),
                      TextSpan(
                        text: 'Right: ',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: '${rightPressure.toStringAsFixed(1)} mmHg',
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
              child: _buildPressureGauge(leftPressure, rightPressure),
            ),
            const SizedBox(height: 16),
            
            // Legend
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildLegendItem(Colors.blue, 'Left Eye'),
                const SizedBox(width: 24),
                _buildLegendItem(Colors.green, 'Right Eye'),
              ],
            ),
            
            // Range indicators
            const SizedBox(height: 24),
            _buildPressureRangeIndicators(),
            
            // What this means section
            const SizedBox(height: 24),
            const Text(
              'What This Means',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _getDetailedPressureExplanation(leftPressure, rightPressure),
              style: const TextStyle(
                fontSize: 14,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  // Build a horizontal gauge chart to show eye pressure
  Widget _buildPressureGauge(double leftValue, double rightValue) {
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: 40,  // Maximum pressure to show
        minY: 0,
        barTouchData: BarTouchData(
          enabled: true,
          touchTooltipData: BarTouchTooltipData(
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              String label;
              switch(group.x.toInt()) {
                case 0: label = 'Left Eye: ${leftValue.toStringAsFixed(1)} mmHg';
                  break;
                case 1: label = 'Right Eye: ${rightValue.toStringAsFixed(1)} mmHg';
                  break;
                default: label = '';
              }
              return BarTooltipItem(
                label,
                const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              );
            }
          ),
        ),
        titlesData: FlTitlesData(
          show: true,
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                if (value % 5 == 0 && value <= 35) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Text('${value.toInt()}', style: const TextStyle(fontSize: 10)),
                  );
                }
                return const SizedBox.shrink();
              },
              reservedSize: 30,
            ),
          ),
        ),
        gridData: FlGridData(
          show: true,
          getDrawingHorizontalLine: (value) {
            Color lineColor = Colors.grey.shade200;
            double strokeWidth = 0.5;
            
            // Highlight normal range
            if (value == 12) {
              lineColor = Colors.green.withOpacity(0.3);
              strokeWidth = 1;
            } else if (value == 22) {
              lineColor = Colors.orange.withOpacity(0.3);
              strokeWidth = 1;
            } else if (value == 30) {
              lineColor = Colors.red.withOpacity(0.3);
              strokeWidth = 1;
            }
            
            return FlLine(
              color: lineColor,
              strokeWidth: strokeWidth,
            );
          },
          horizontalInterval: 5,
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
                // Add value labels to the bars
                rodStackItems: [
                  BarChartRodStackItem(
                    0, 
                    leftValue, 
                    Colors.blue,
                    BorderSide.none
                  ),
                ],
                // Show background for context
                backDrawRodData: BackgroundBarChartRodData(
                  show: true,
                  toY: 40,
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
                // Add value labels to the bars
                rodStackItems: [
                  BarChartRodStackItem(
                    0, 
                    rightValue, 
                    Colors.green,
                    BorderSide.none
                  ),
                ],
                // Show background for context
                backDrawRodData: BackgroundBarChartRodData(
                  show: true,
                  toY: 40,
                  color: Colors.grey.withOpacity(0.1),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  // Build pressure range indicators with clearer labels
  Widget _buildPressureRangeIndicators() {
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildRangeIndicator('Low', '< 12 mmHg', Colors.blue),
              _buildRangeIndicator('Normal', '12-22 mmHg', Colors.green),
              _buildRangeIndicator('Elevated', '22-30 mmHg', Colors.orange),
              _buildRangeIndicator('High', '> 30 mmHg', Colors.red),
            ],
          ),
        ],
      ),
    );
  }
  
  Widget _buildRangeIndicator(String label, String range, Color color) {
    return Column(
      children: [
        Container(
          width: 30,
          height: 10,
          color: color,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        Text(
          range,
          style: const TextStyle(fontSize: 10),
        ),
      ],
    );
  }
  
  // Get appropriate icon based on eye pressure
  IconData _getPressureIcon(double leftValue, double rightValue) {
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
  
  // Get appropriate color based on eye pressure
  Color _getPressureColor(double leftValue, double rightValue) {
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
  
  // More detailed explanation of pressure values
  String _getDetailedPressureExplanation(double leftValue, double rightValue) {
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
  
  // Simple legend item
  Widget _buildLegendItem(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 14,
          height: 14,
          color: color,
        ),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}