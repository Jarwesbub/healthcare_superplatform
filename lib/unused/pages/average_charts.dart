import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fl_chart/fl_chart.dart';

class AverageChartsPage extends StatefulWidget {
  const AverageChartsPage({super.key});

  @override
  State<AverageChartsPage> createState() => _AverageChartsPageState();
}

class _AverageChartsPageState extends State<AverageChartsPage> {
  Map<String, dynamic>? userData;
  Map<String, dynamic> populationAverages = {
    "weight": 70.0,
    "height": 165.0,
    "bmi": 25.7,
    "waistCircumference": 88.0,
    "bodyFatPercentage": 30.0,
    "bloodPressureSystolic": 125,
    "bloodPressureDiastolic": 80,
    "restingHeartRate": 70,
    "bloodGlucose": 5.5,
    "hba1c": 5.8,
    "cholesterolTotal": 5.0,
    "cholesterolHDL": 1.5,
    "cholesterolLDL": 3.0,
    "triglycerides": 1.2,
    "vo2max": 35.0,
  };

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  Future<void> loadUserData() async {
    final String response = await rootBundle.loadString(
      'assets/users/josefiina.json',
    );
    final data = json.decode(response);
    setState(() {
      userData = data['user'];
    });
  }

  Widget buildComparisonCard(
    String label,
    dynamic userValue,
    dynamic avgValue,
  ) {
    Color color;
    IconData icon;
    String comment;

    if (userValue == null) {
      color = Colors.grey;
      icon = Icons.help_outline;
      comment = "Ei tietoa";
    } else if (userValue > avgValue) {
      color = Colors.orange;
      icon = Icons.trending_up;
      comment = "Yli keskiarvon";
    } else if (userValue < avgValue) {
      color = Colors.green;
      icon = Icons.trending_down;
      comment = "Alle keskiarvon";
    } else {
      color = Colors.blue;
      icon = Icons.check_circle_outline;
      comment = "Keskimääräinen";
    }

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 4),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color),
                const SizedBox(width: 8),
                Text(label, style: const TextStyle(fontSize: 16)),
                const Spacer(),
                Text(comment, style: TextStyle(color: color)),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200, // Increased height for better visibility
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  barTouchData: BarTouchData(enabled: false),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          switch (value.toInt()) {
                            case 0:
                              return const Text('Sinä');
                            case 1:
                              return const Text('Keskiarvo');
                          }
                          return const Text('');
                        },
                      ),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  barGroups: [
                    BarChartGroupData(
                      x: 0,
                      barRods: [
                        BarChartRodData(
                          toY: userValue?.toDouble() ?? 0,
                          color: Colors.greenAccent,
                          width: 50, // Increased bar width
                        ),
                      ],
                    ),
                    BarChartGroupData(
                      x: 1,
                      barRods: [
                        BarChartRodData(
                          toY: avgValue.toDouble(),
                          color: Colors.blueAccent,
                          width: 20, // Increased bar width
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (userData == null) {
      return const Center(child: CircularProgressIndicator());
    }

    final basic = Map<String, dynamic>.from(userData!["basicMeasurements"]);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              "Vertailu väestön keskiarvoihin",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
          ),
          ...populationAverages.entries.map((entry) {
            final key = entry.key;
            final avgValue = entry.value;
            final userValue = basic[key];
            return buildComparisonCard(key, userValue, avgValue);
          }).toList(),
        ],
      ),
    );
  }
}
