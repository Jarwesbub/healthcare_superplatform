import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class EyesightProgressPage extends StatelessWidget {
  const EyesightProgressPage({super.key});

  Future<List<FlSpot>> _loadRightEyeData() async {
    // Simulated right eye eyesight data over 5 years
    return [
      FlSpot(1, 1.0), // Year 1: Perfect eyesight (20/20)
      FlSpot(2, 0.95), // Year 2: Slight decline
      FlSpot(3, 0.85), // Year 3: Moderate decline
      FlSpot(4, 0.7), // Year 4: Further decline
      FlSpot(5, 0.5), // Year 5: Significant decline
    ];
  }

  Future<List<FlSpot>> _loadLeftEyeData() async {
    // Simulated left eye eyesight data over 5 years
    return [
      FlSpot(1, 1.0), // Year 1: Perfect eyesight (20/20)
      FlSpot(2, 0.92), // Year 2: Slight decline
      FlSpot(3, 0.87), // Year 3: Moderate decline
      FlSpot(4, 0.75), // Year 4: Further decline
      FlSpot(5, 0.6), // Year 5: Significant decline
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Eyesight Progress'),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          constraints: const BoxConstraints(maxWidth: 800),
          child: FutureBuilder<List<List<FlSpot>>>(
            future: Future.wait([_loadRightEyeData(), _loadLeftEyeData()]),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No data available'));
              }
          
              final rightEyeData = snapshot.data![0];
              final leftEyeData = snapshot.data![1];
          
              // Build the LineChart with the loaded data
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: LineChart(
                  LineChartData(
                    gridData: FlGridData(
                      show: true,
                      drawVerticalLine: true,
                      verticalInterval: 1,
                      horizontalInterval: 0.1,
                      getDrawingHorizontalLine: (value) {
                        return FlLine(
                          color: Colors.grey.withOpacity(0.2),
                          strokeWidth: 1,
                        );
                      },
                      getDrawingVerticalLine: (value) {
                        return FlLine(
                          color: Colors.grey.withOpacity(0.2),
                          strokeWidth: 1,
                        );
                      },
                    ),
                    titlesData: FlTitlesData(
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 40,
                          getTitlesWidget: (value, meta) {
                            return Text(
                              value.toStringAsFixed(1),
                              style: const TextStyle(
                                color: Colors.black54,
                                fontSize: 12,
                              ),
                            );
                          },
                        ),
                      ),
                      rightTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: false, // Hide right side titles
                        ),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 40,
                          getTitlesWidget: (value, meta) {
                            // Only show unique years (integer values)
                            if (value % 1 == 0) {
                              return Text(
                                'Year ${value.toInt()}',
                                style: const TextStyle(
                                  color: Colors.black54,
                                  fontSize: 12,
                                ),
                              );
                            }
                            return const SizedBox.shrink(); // Hide duplicates
                          },
                        ),
                      ),
                    ),
                    borderData: FlBorderData(
                      show: true,
                      border: Border.all(
                        color: Colors.grey.withOpacity(0.5),
                        width: 1,
                      ),
                    ),
                    minY: 0.4, // Set minimum y-axis value slightly below the lowest data point
                    maxY: 1.1, // Set maximum y-axis value slightly above the highest data point
                    lineBarsData: [
                      LineChartBarData(
                        spots: rightEyeData,
                        isCurved: true,
                        color: Colors.blue, // Blue for right eye
                        barWidth: 4,
                        isStrokeCapRound: true,
                        belowBarData: BarAreaData(show: false),
                      ),
                      LineChartBarData(
                        spots: leftEyeData,
                        isCurved: true,
                        color: Colors.green, // Green for left eye
                        barWidth: 4,
                        isStrokeCapRound: true,
                        belowBarData: BarAreaData(show: false),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}