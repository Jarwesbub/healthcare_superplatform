import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:healthcare_superplatform/data/page_constants.dart';
import 'package:healthcare_superplatform/demos/eyesight_stats/models/eyesight_colors.dart';
import 'package:healthcare_superplatform/demos/eyesight_stats/models/eyesight_text_style.dart';
import 'package:healthcare_superplatform/demos/eyesight_stats/widgets/eyesight_appbar.dart';
import 'package:healthcare_superplatform/demos/eyesight_stats/widgets/eyesight_table_widget.dart';

class EyesightStatsPage extends StatefulWidget {
  const EyesightStatsPage({super.key});

  @override
  State<EyesightStatsPage> createState() => _EyesightStatsState();
}

class _EyesightStatsState extends State<EyesightStatsPage> {
  Map<String, dynamic>? data;
  bool showCharts = true;

  Future<dynamic> readJson() async {
    final String response = await rootBundle.loadString(
      'assets/jsons/eyesight_stats.json',
    );
    final Map<String, dynamic> jsonData = jsonDecode(response);

    setState(() {
      data = jsonData['eyesight'];
      debugPrint('$data'); // Test -> show json data.
    });
  }

  @override
  void initState() {
    super.initState();
    readJson();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EyesightAppBar(title: 'Eye stats', isBackButtonVisible: true),
      backgroundColor: EyesightColors().surface,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: PageConstants.mobileViewLimit.toDouble(),
            ),
            child: ListView(
              children: [
                const SizedBox(height: 10),
                SvgPicture.asset('assets/images/eye.svg'),
                
                // View toggle
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ChoiceChip(
                        label: const Text('Tables'),
                        selected: !showCharts,
                        onSelected: (selected) {
                          if (selected) {
                            setState(() {
                              showCharts = false;
                            });
                          }
                        },
                      ),
                      const SizedBox(width: 10),
                      ChoiceChip(
                        label: const Text('Charts'),
                        selected: showCharts,
                        onSelected: (selected) {
                          if (selected) {
                            setState(() {
                              showCharts = true;
                            });
                          }
                        },
                      ),
                    ],
                  ),
                ),
                
                if (showCharts) ...[
                  // Visual acuity chart
                  Card(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: EyesightVisualAcuityChart(
                        eyesightData: data,
                      ),
                    ),
                  ),
                  
                  // Intraocular pressure chart
                  Card(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: EyesightComparisonChart(
                        eyesightData: data,
                        isKeratometry: false,
                      ),
                    ),
                  ),
                  
                  // Keratometry chart
                  Card(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: EyesightComparisonChart(
                        eyesightData: data,
                        isKeratometry: true,
                      ),
                    ),
                  ),
                  
                  // Axis comparison chart
                  Card(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: EyesightAxisChart(
                        eyesightData: data,
                      ),
                    ),
                  ),
                ] else ...[
                  // Original table content
                  _headline('Basic information'),
                  EyesightTableWidget(
                    tableContent: [
                      ['Type', 'Left', 'Right'],
                      [
                        'Visual acuity',
                        '${data?['visual_acuity']['left_eye']}',
                        '${data?['visual_acuity']['right_eye']}',
                      ],
                      [
                        'Refraction',
                        '${data?['refraction']['left_eye']}',
                        '${data?['refraction']['right_eye']}',
                      ],
                      [
                        'Intraocular pressure',
                        '${data?['intraocular_pressure']['left_eye']}',
                        '${data?['intraocular_pressure']['right_eye']}',
                      ],
                    ],
                    columnFlexValues: [2, 1, 1],
                  ),
                  _headline('Keratometry'),
                  EyesightTableWidget(
                    tableContent: [
                      ['Type', 'Left', 'Right'],
                      [
                        'Flat curvature',
                        '${data?['keratometry']['left_eye']['flat_k']}',
                        '${data?['keratometry']['right_eye']['flat_k']}',
                      ],
                      [
                        'Steep curvature',
                        '${data?['keratometry']['left_eye']['steep_k']}',
                        '${data?['keratometry']['right_eye']['steep_k']}',
                      ],
                      [
                        'Axis',
                        '${data?['keratometry']['left_eye']['axis']}',
                        '${data?['keratometry']['right_eye']['axis']}',
                      ],
                    ],
                    // Set the first column twice as wide.
                    columnFlexValues: [2, 1, 1],
                  ),
                  _headline('Other'),
                  EyesightTableWidget(
                    tableContent: [
                      ['Type', 'Information'],
                      ['Color vision', '${data?['color_vision']}'],
                      ['Diagnosis', '${data?['diagnosis']}'],
                      ['Recommendations', '${data?['recommendations']}'],
                    ],
                    columnFlexValues: [1, 1],
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _headline(String text) {
    return Container(
      height: 35,
      width: double.infinity,
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: Text(text, style: EyesightTextStyle().header),
    );
  }
}

// Visual Acuity Chart Widget
class EyesightVisualAcuityChart extends StatelessWidget {
  final Map<String, dynamic>? eyesightData;
  
  const EyesightVisualAcuityChart({
    Key? key,
    required this.eyesightData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (eyesightData == null) {
      return const Center(child: CircularProgressIndicator());
    }
    
    // Extract visual acuity data
    double leftVisualAcuity = _convertVisualAcuityToNumber(eyesightData?['visual_acuity']['left_eye']);
    double rightVisualAcuity = _convertVisualAcuityToNumber(eyesightData?['visual_acuity']['right_eye']);
    double avgVisualAcuity = 1.0; // 20/20 vision standard
    
    // Explanatory text for various visual acuity levels
    final String acuityInterpretation = _getAcuityInterpretation(
      (leftVisualAcuity + rightVisualAcuity) / 2
    );
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Visual Acuity',
          style: EyesightTextStyle().header,
        ),
        const SizedBox(height: 10),
        Text(
          'How clearly you can see compared to average vision',
          style: EyesightTextStyle().miniHeader,
        ),
        // Description for better understanding
        Container(
          margin: const EdgeInsets.symmetric(vertical: 12),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            'Visual acuity measures how clearly you can see. A value of 1.0 represents normal "20/20" vision. Higher numbers mean better than average vision, while lower numbers indicate that objects must be closer for you to see them clearly.',
            style: const TextStyle(fontSize: 12, color: Colors.black87),
          ),
        ),
        // Personalized interpretation
        Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: EyesightColors().primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: EyesightColors().primary.withOpacity(0.3)),
          ),
          child: Text(
            'What this means for you: $acuityInterpretation',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold, 
              color: EyesightColors().primary
            ),
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: 200,
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.spaceAround,
              maxY: 1.5,  // Most visual acuity values are between 0 and 1.5
              barTouchData: BarTouchData(
                enabled: true,
                handleBuiltInTouches: true,
                touchTooltipData: BarTouchTooltipData(
                  getTooltipItem: (group, groupIndex, rod, rodIndex) {
                    String eyeSide = rodIndex == 0 ? 'Left Eye' : rodIndex == 1 ? 'Right Eye' : 'Average';
                    // Convert decimal visual acuity back to Snellen notation for the tooltip
                    String snellenValue = _decimalToSnellen(rod.toY);
                    return BarTooltipItem(
                      '$eyeSide\n$snellenValue (${rod.toY.toStringAsFixed(2)})',
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
                      return const Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: Text(
                          'Visual Acuity',
                          style: TextStyle(
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
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      // Show Snellen equivalents on the y-axis
                      String label = '';
                      if (value == 0.5) label = '20/40';
                      else if (value == 1.0) label = '20/20';
                      else if (value == 1.5) label = '20/13';
                      
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Text(
                          label,
                          style: const TextStyle(fontSize: 10),
                        ),
                      );
                    },
                    reservedSize: 50,
                  ),
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
                horizontalInterval: 0.25,
              ),
              borderData: FlBorderData(show: false),
              barGroups: [
                BarChartGroupData(
                  x: 0,
                  barRods: [
                    BarChartRodData(
                      toY: leftVisualAcuity,
                      color: EyesightColors().primary,
                      width: 22,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(6),
                        topRight: Radius.circular(6),
                      ),
                    ),
                    BarChartRodData(
                      toY: rightVisualAcuity,
                      color: EyesightColors().secondary,
                      width: 22,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(6),
                        topRight: Radius.circular(6),
                      ),
                    ),
                    BarChartRodData(
                      toY: avgVisualAcuity,
                      color: Colors.grey,
                      width: 22,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(6),
                        topRight: Radius.circular(6),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _legendItem(EyesightColors().primary, "Left Eye"),
            const SizedBox(width: 20),
            _legendItem(EyesightColors().secondary, "Right Eye"),
            const SizedBox(width: 20),
            _legendItem(Colors.grey, "Average"),
          ],
        ),
      ],
    );
  }
  
  Widget _legendItem(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          color: color,
        ),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
  
  String _getAcuityInterpretation(double avgAcuity) {
    if (avgAcuity >= 1.2) {
      return "Your vision is better than average. You can see details that many people cannot.";
    } else if (avgAcuity >= 0.9) {
      return "Your vision is within normal range. Most everyday tasks should be comfortable.";
    } else if (avgAcuity >= 0.5) {
      return "Your vision is slightly below average. Reading small print or distant signs may be challenging without correction.";
    } else if (avgAcuity >= 0.3) {
      return "Your vision is moderately reduced. Correction with glasses or contacts is recommended for daily activities.";
    } else {
      return "Your vision is significantly reduced. Please discuss options with your eye doctor.";
    }
  }
  
  String _decimalToSnellen(double decimal) {
    if (decimal <= 0) return "N/A";
    
    // Standard conversion for 20/x notation
    int denominator = (20 / decimal).round();
    return "20/$denominator";
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
}

// Axis Chart Widget
class EyesightAxisChart extends StatelessWidget {
  final Map<String, dynamic>? eyesightData;
  
  const EyesightAxisChart({
    Key? key,
    required this.eyesightData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (eyesightData == null) {
      return const Center(child: CircularProgressIndicator());
    }
    
    // Extract axis data
    double leftAxis = _parseDouble(eyesightData?['keratometry']['left_eye']['axis']);
    double rightAxis = _parseDouble(eyesightData?['keratometry']['right_eye']['axis']);
    double avgAxis = 90.0; // Average value
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Corneal Axis Comparison',
          style: EyesightTextStyle().header,
        ),
        const SizedBox(height: 10),
        Text(
          'Your eyes compared to average values (measured in degrees)',
          style: EyesightTextStyle().miniHeader,
        ),
        // Description for better understanding
        Container(
          margin: const EdgeInsets.symmetric(vertical: 12),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Text(
            'The corneal axis shows the orientation of your corneal astigmatism. It indicates which direction your cornea is steeper. Values typically range from 0° to 180°. The axis value itself is less important than whether it aligns with any astigmatism in your lens prescription.',
            style: TextStyle(fontSize: 12, color: Colors.black87),
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: 200,
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.spaceAround,
              maxY: 200,  // Axis values can go up to around 180 degrees
              barTouchData: BarTouchData(
                enabled: true,
                handleBuiltInTouches: true,
                touchTooltipData: BarTouchTooltipData(
                  getTooltipItem: (group, groupIndex, rod, rodIndex) {
                    String eyeSide = rodIndex == 0 ? 'Left Eye' : rodIndex == 1 ? 'Right Eye' : 'Average';
                    return BarTooltipItem(
                      '$eyeSide\n${rod.toY.toStringAsFixed(1)}°',
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
                      return const Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: Text(
                          'Corneal Axis',
                          style: TextStyle(
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
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 40,
                  ),
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
                horizontalInterval: 30,
              ),
              borderData: FlBorderData(show: false),
              barGroups: [
                BarChartGroupData(
                  x: 0,
                  barRods: [
                    BarChartRodData(
                      toY: leftAxis,
                      color: EyesightColors().primary,
                      width: 15,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(6),
                        topRight: Radius.circular(6),
                      ),
                    ),
                    BarChartRodData(
                      toY: rightAxis,
                      color: EyesightColors().secondary,
                      width: 15,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(6),
                        topRight: Radius.circular(6),
                      ),
                    ),
                    BarChartRodData(
                      toY: avgAxis,
                      color: Colors.grey,
                      width: 15,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(6),
                        topRight: Radius.circular(6),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _legendItem(EyesightColors().primary, "Left Eye"),
            const SizedBox(width: 20),
            _legendItem(EyesightColors().secondary, "Right Eye"),
            const SizedBox(width: 20),
            _legendItem(Colors.grey, "Average"),
          ],
        ),
      ],
    );
  }
  
  Widget _legendItem(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          color: color,
        ),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
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
}

// Main Chart Widget
class EyesightComparisonChart extends StatelessWidget {
  final Map<String, dynamic>? eyesightData;
  final bool isKeratometry;
  
  const EyesightComparisonChart({
    Key? key,
    required this.eyesightData,
    this.isKeratometry = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (eyesightData == null) {
      return const Center(child: CircularProgressIndicator());
    }
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          isKeratometry ? 'Keratometry Comparison' : 'Intraocular Pressure',
          style: EyesightTextStyle().header,
        ),
        const SizedBox(height: 10),
        Text(
          isKeratometry 
              ? 'Your corneal curvature compared to average values'
              : 'Your eye pressure compared to average values',
          style: EyesightTextStyle().miniHeader,
        ),
        // Description for better understanding
        Container(
          margin: const EdgeInsets.symmetric(vertical: 12),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            isKeratometry
                ? 'Keratometry measures the curvature of your cornea. Flat K and Steep K values represent the different curvatures across your cornea surface. Normal values range around 42-46 diopters. Values outside this range may indicate conditions like astigmatism or keratoconus.'
                : 'Intraocular Pressure (IOP) is the fluid pressure inside your eye. Normal IOP ranges from 12-22 mmHg. Higher values may indicate glaucoma risk, while lower values can sometimes indicate other eye conditions.',
            style: const TextStyle(fontSize: 12, color: Colors.black87),
          ),
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
                handleBuiltInTouches: true,
                touchTooltipData: BarTouchTooltipData(
                  getTooltipItem: (group, groupIndex, rod, rodIndex) {
                    String metricName = _getMetricName(group.x.toInt(), isKeratometry);
                    String eyeSide = rodIndex == 0 ? 'Left Eye' : rodIndex == 1 ? 'Right Eye' : 'Average';
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
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 40,
                  ),
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
        Container(
          width: 16,
          height: 16,
          color: color,
        ),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
  
  List<BarChartGroupData> _getBarGroups(bool isKeratometry) {
    if (isKeratometry) {
      // Keratometry data - only include the K values, not the axis
      // as axis values are on a completely different scale
      double leftFlatK = _parseDouble(eyesightData?['keratometry']['left_eye']['flat_k']);
      double rightFlatK = _parseDouble(eyesightData?['keratometry']['right_eye']['flat_k']);
      double avgFlatK = 43.5; // Average value
      
      double leftSteepK = _parseDouble(eyesightData?['keratometry']['left_eye']['steep_k']);
      double rightSteepK = _parseDouble(eyesightData?['keratometry']['right_eye']['steep_k']);
      double avgSteepK = 44.2; // Average value
      
      return [
        _createBarGroup(0, [leftFlatK, rightFlatK, avgFlatK]),
        _createBarGroup(1, [leftSteepK, rightSteepK, avgSteepK]),
      ];
    } else {
      // Only show intraocular pressure, visual acuity has its own chart
      double leftIOP = _parseDouble(eyesightData?['intraocular_pressure']['left_eye']);
      double rightIOP = _parseDouble(eyesightData?['intraocular_pressure']['right_eye']);
      double avgIOP = 16.0; // Average value
      
      return [
        _createBarGroup(0, [leftIOP, rightIOP, avgIOP]),
      ];
    }
      // Visual metrics data
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
        case 0: return 'Flat K';
        case 1: return 'Steep K';
        default: return '';
      }
    } else {
      return 'IOP (mmHg)';
    }
    }