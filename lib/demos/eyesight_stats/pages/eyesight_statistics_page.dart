import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:healthcare_superplatform/data/page_constants.dart';
import 'package:healthcare_superplatform/demos/eyesight_stats/models/eyesight_colors.dart';
import 'package:healthcare_superplatform/demos/eyesight_stats/widgets/eyesight_mobile_appbar.dart';
import 'package:healthcare_superplatform/demos/eyesight_stats/pages/optical_test_results_page.dart';

class EyesightApp extends StatelessWidget {
  const EyesightApp({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = EyesightColors();

    return MaterialApp(
      title: 'Eyesight Statistics',
      theme: ThemeData(
        cardTheme: CardTheme(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          color: colors.boxColor,
        ),
        fontFamily: 'Roboto',
        textTheme: TextTheme(
          titleLarge: TextStyle(color: colors.textPrimary),
          titleMedium: TextStyle(color: colors.textPrimary),
          bodyLarge: TextStyle(color: colors.textPrimary),
          bodyMedium: TextStyle(color: colors.textSecondary),
        ),
        chipTheme: ChipThemeData(
          selectedColor: colors.customPrimary,
          backgroundColor: colors.grey0,
          labelStyle: TextStyle(color: colors.textPrimary),
        ),
        dividerTheme: DividerThemeData(color: colors.grey0, thickness: 1),
      ),
      home: const EyesightStatisticsPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class EyesightStatisticsPage extends StatefulWidget {
  const EyesightStatisticsPage({super.key});

  @override
  State<EyesightStatisticsPage> createState() => _EyesightStatisticsPageState();
}

class _EyesightStatisticsPageState extends State<EyesightStatisticsPage> {
  String _selectedTimeRange = '1 Month';
  final List<String> _timeRanges = [
    '1 Month',
    '3 Months',
    '1 Year',
    'All Time',
  ];
  late final Map<String, List<EyesightData>> _eyesightData;
  late final EyesightColors colors = EyesightColors();

  @override
  void initState() {
    super.initState();
    _eyesightData = {
      '1 Month': _getMonthData(),
      '3 Months': _getThreeMonthData(),
      '1 Year': _getYearData(),
      'All Time': _getAllTimeData(),
    };
  }

  // weekly
  List<EyesightData> _getMonthData() {
    return [
      EyesightData(DateTime(2025, 3, 16), 88, 89),
      EyesightData(DateTime(2025, 3, 23), 87, 89),
      EyesightData(DateTime(2025, 3, 30), 87, 88),
      EyesightData(DateTime(2025, 4, 6), 86, 88),
      EyesightData(DateTime(2025, 4, 13), 86, 88),
    ];
  }

  // 3 months
  List<EyesightData> _getThreeMonthData() {
    return [
      EyesightData(DateTime(2025, 1, 19), 90, 91),
      EyesightData(DateTime(2025, 2, 2), 89, 90),
      EyesightData(DateTime(2025, 2, 16), 89, 90),
      EyesightData(DateTime(2025, 3, 2), 88, 89),
      EyesightData(DateTime(2025, 3, 16), 88, 89),
      EyesightData(DateTime(2025, 3, 30), 87, 88),
      EyesightData(DateTime(2025, 4, 13), 86, 88),
    ];
  }

  // 1 year
  List<EyesightData> _getYearData() {
    return [
      EyesightData(DateTime(2024, 4, 15), 91, 92),
      EyesightData(DateTime(2024, 5, 15), 91, 92),
      EyesightData(DateTime(2024, 6, 15), 90, 91),
      EyesightData(DateTime(2024, 7, 15), 90, 91),
      EyesightData(DateTime(2024, 8, 15), 89, 90),
      EyesightData(DateTime(2024, 9, 15), 89, 90),
      EyesightData(DateTime(2024, 10, 15), 89, 89),
      EyesightData(DateTime(2024, 11, 15), 88, 89),
      EyesightData(DateTime(2024, 12, 15), 88, 89),
      EyesightData(DateTime(2025, 1, 15), 88, 89),
      EyesightData(DateTime(2025, 2, 15), 87, 88),
      EyesightData(DateTime(2025, 3, 15), 87, 88),
      EyesightData(DateTime(2025, 4, 13), 86, 88),
    ];
  }

  // all time
  List<EyesightData> _getAllTimeData() {
    return [
      EyesightData(DateTime(2023, 1, 15), 92, 93),
      EyesightData(DateTime(2023, 4, 15), 92, 92),
      EyesightData(DateTime(2023, 7, 15), 91, 92),
      EyesightData(DateTime(2023, 10, 15), 91, 91),
      EyesightData(DateTime(2024, 1, 15), 90, 91),
      EyesightData(DateTime(2024, 4, 15), 90, 91),
      EyesightData(DateTime(2024, 7, 15), 89, 90),
      EyesightData(DateTime(2024, 10, 15), 89, 90),
      EyesightData(DateTime(2025, 1, 15), 88, 89),
      EyesightData(DateTime(2025, 4, 13), 86, 88),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final currentData = _eyesightData[_selectedTimeRange]!.last;
    final overallScore =
        ((currentData.leftEyeScore + currentData.rightEyeScore) / 2).round();

    return Scaffold(
      appBar: EyesightMobileAppBar(
        title: 'Statistics',
        isBackButtonVisible: true,
      ),
      backgroundColor: EyesightColors().surface,
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: PageConstants.mobileViewLimit.toDouble(),
          ),
          child: ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              _buildSectionHeader('Eye Statistics', ''),
              Card(
                color: EyesightColors().boxColor,
                margin: const EdgeInsets.only(bottom: 24),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      // Score for left eye
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.visibility,
                                  size: 18,
                                  color: colors.grey1,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  'Left Eye',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: colors.grey2,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: '${currentData.leftEyeScore}',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: colors.textPrimary,
                                    ),
                                  ),
                                  _getDecreaseTextSpan(
                                    _eyesightData[_selectedTimeRange]!,
                                    true,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Score for right eye
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.visibility,
                                  size: 18,
                                  color: colors.grey1,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  'Right Eye',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: colors.grey2,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: '${currentData.rightEyeScore}',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: colors.textPrimary,
                                    ),
                                  ),
                                  _getDecreaseTextSpan(
                                    _eyesightData[_selectedTimeRange]!,
                                    false,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              _buildSectionHeader('Trend Analysis', ''),

              Card(
                color: EyesightColors().boxColor,
                margin: const EdgeInsets.only(bottom: 8),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 12.0,
                  ),
                  child: SizedBox(
                    height: 36,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _timeRanges.length,
                      itemBuilder: (context, index) {
                        final isSelected =
                            _timeRanges[index] == _selectedTimeRange;
                        return Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: ChoiceChip(
                            label: Text(_timeRanges[index]),
                            selected: isSelected,
                            onSelected: (selected) {
                              if (selected) {
                                setState(() {
                                  _selectedTimeRange = _timeRanges[index];
                                });
                              }
                            },
                            backgroundColor: colors.grey0,
                            selectedColor: colors.customPrimary,
                            labelStyle: TextStyle(
                              color:
                                  isSelected
                                      ? Colors.white
                                      : colors.textPrimary,
                              fontWeight:
                                  isSelected
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),

              // Chart starts here
              Card(
                color: EyesightColors().boxColor,
                margin: const EdgeInsets.only(bottom: 24),
                child: SizedBox(
                  height: 250,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: _buildChart(),
                  ),
                ),
              ),

              _buildSectionHeader('Eyesight Metrics', 'View Details'),

              Card(
                color: EyesightColors().boxColor,
                margin: const EdgeInsets.only(bottom: 24),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      _buildMetricRow(
                        'Overall Score',
                        '$overallScore',
                        _getScoreRating(overallScore),
                      ),
                      const Divider(),
                      _buildMetricRow(
                        'Left Eye',
                        '${currentData.leftEyeScore}',
                        _getEyeScoreRating(currentData.leftEyeScore),
                      ),
                      const Divider(),
                      _buildMetricRow(
                        'Right Eye',
                        '${currentData.rightEyeScore}',
                        _getEyeScoreRating(currentData.rightEyeScore),
                      ),
                      const Divider(),
                      _buildMetricRow(
                        'Next Checkup',
                        _getRecommendedCheckupInterval(
                          currentData.leftEyeScore,
                          currentData.rightEyeScore,
                        ),
                        'Recommend',
                      ),
                    ],
                  ),
                ),
              ),

              Card(
                color: EyesightColors().boxColor,
                margin: const EdgeInsets.only(bottom: 24),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildActionButton(
                        'Optical Results',
                        Icons.calendar_today,
                        () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => const OpticalTestResultsPage(),
                            ),
                          );
                        },
                      ),
                      _buildActionButton(
                        'Test History',
                        Icons.assignment,
                        () => _showTestHistorySheet(context),
                      ),
                      _buildActionButton(
                        'Export',
                        Icons.drive_folder_upload,
                        () {},
                      ),
                    ],
                  ),
                ),
              ),

              _buildSectionHeader('Recommendations', ''),

              Card(
                color: EyesightColors().boxColor,
                margin: const EdgeInsets.only(bottom: 24),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        leading: Icon(Icons.schedule, color: colors.primary),
                        title: Text(
                          'Schedule Regular Eye Exams',
                          style: TextStyle(color: colors.textPrimary),
                        ),
                        subtitle: Text(
                          'Every ${_getRecommendedCheckupInterval(currentData.leftEyeScore, currentData.rightEyeScore)}',
                          style: TextStyle(color: colors.textSecondary),
                        ),
                        contentPadding: EdgeInsets.zero,
                      ),
                      const Divider(),
                      ListTile(
                        leading: Icon(Icons.timer, color: colors.primary),
                        title: Text(
                          'Take Screen Breaks',
                          style: TextStyle(color: colors.textPrimary),
                        ),
                        subtitle: Text(
                          'Use the 20-20-20 rule: Every 20 minutes, look at something 20 feet away for 20 seconds',
                          style: TextStyle(color: colors.textSecondary),
                        ),
                        contentPadding: EdgeInsets.zero,
                      ),
                      const Divider(),
                      ListTile(
                        leading: Icon(
                          Icons.lightbulb_outline,
                          color: colors.primary,
                        ),
                        title: Text(
                          'Ensure Proper Lighting',
                          style: TextStyle(color: colors.textPrimary),
                        ),
                        subtitle: Text(
                          'Maintain good lighting while reading and working to reduce eye strain',
                          style: TextStyle(color: colors.textSecondary),
                        ),
                        contentPadding: EdgeInsets.zero,
                      ),
                      const Divider(),
                      ListTile(
                        leading: Icon(
                          Icons.favorite_outline,
                          color:
                              currentData.leftEyeScore < 80
                                  ? Colors.redAccent
                                  : colors.primary,
                        ),
                        title: Text(
                          _getAdditionalRecommendation(
                            currentData.leftEyeScore,
                            currentData.rightEyeScore,
                          ).replaceAll('• ', ''),
                          style: TextStyle(color: colors.textPrimary),
                        ),
                        contentPadding: EdgeInsets.zero,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, String action) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: colors.textSecondary,
            ),
          ),
          if (action.isNotEmpty)
            Text(
              action,
              style: TextStyle(
                fontSize: 14,
                color: colors.customPrimary,
                fontWeight: FontWeight.w500,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildMetricRow(String title, String value, String status) {
    Color statusColor;
    if (status == 'Excellent' || status == 'Good') {
      statusColor = Colors.green;
    } else if (status == 'Average') {
      statusColor = Colors.amber;
    } else if (status == 'Fair') {
      statusColor = Colors.orange;
    } else if (status == 'Poor') {
      statusColor = Colors.red;
    } else {
      statusColor = colors.customPrimary;
    }

    String decreaseText = '';

    if (title == 'Left Eye' || title == 'Right Eye') {
      final currentData = _eyesightData[_selectedTimeRange]!;
      final firstData = currentData.first;
      final lastData = currentData.last;

      int firstScore = 0;
      int lastScore = 0;

      if (title == 'Left Eye') {
        firstScore = firstData.leftEyeScore;
        lastScore = lastData.leftEyeScore;
      } else {
        firstScore = firstData.rightEyeScore;
        lastScore = lastData.rightEyeScore;
      }

      int decrease = firstScore - lastScore;
      if (decrease > 0) {
        decreaseText = ' ↓$decrease';
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(
              title,
              style: TextStyle(fontSize: 16, color: colors.textSecondary),
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: value,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: colors.textPrimary,
                        ),
                      ),
                      if (decreaseText.isNotEmpty)
                        TextSpan(
                          text: decreaseText,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: statusColor.withAlpha(50)),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      fontSize: 12,
                      color: statusColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(String label, IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
        child: Column(
          children: [
            Icon(icon, color: colors.grey2, size: 28),
            const SizedBox(height: 4),
            Text(label, style: TextStyle(fontSize: 14, color: colors.grey2)),
          ],
        ),
      ),
    );
  }

  Widget _buildChart() {
    final data = _eyesightData[_selectedTimeRange]!;
    String currentValue = ''; // Keeps track of horizontal chart titles.
    return LineChart(
      LineChartData(
        gridData: FlGridData(
          show: true,
          drawHorizontalLine: true,
          drawVerticalLine: false,
          horizontalInterval: 10,
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: colors.grey0,
              strokeWidth: 1,
              dashArray: [5, 5],
            );
          },
        ),
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 22,
              getTitlesWidget: (value, meta) {
                int interval = (data.length / 4).round();
                if (interval < 1) interval = 1;

                if (value.toInt() % interval == 0 &&
                    value.toInt() < data.length) {
                  final date = data[value.toInt()].date;
                  if (currentValue == '${date.day}/${date.month}') {
                    // Don't show same date and months.
                    return Text('');
                  }
                  currentValue = '${date.day}/${date.month}';
                  // Show day and month normally.
                  return Text('${date.day}/${date.month}');
                }
                return const Text('');
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                if (value % 10 == 0 && value >= 60 && value <= 100) {
                  return Text(value.toInt().toString());
                }
                return const Text('');
              },
              reservedSize: 30,
            ),
          ),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        borderData: FlBorderData(
          show: true,
          border: Border(
            bottom: BorderSide(color: colors.grey0, width: 1),
            left: BorderSide(color: colors.grey0, width: 1),
            right: BorderSide.none,
            top: BorderSide.none,
          ),
        ),
        minX: 0,
        maxX: data.length.toDouble() - 1,
        minY: 60,
        maxY: 100,
        lineBarsData: [
          LineChartBarData(
            spots: List.generate(
              data.length,
              (index) =>
                  FlSpot(index.toDouble(), data[index].leftEyeScore.toDouble()),
            ),
            isCurved: true,
            color: colors.primary,
            barWidth: 2.5,
            isStrokeCapRound: true,
            dotData: FlDotData(
              show: true,
              getDotPainter: (spot, percent, barData, index) {
                return FlDotCirclePainter(
                  radius: 4,
                  color: Colors.white,
                  strokeWidth: 2,
                  strokeColor: colors.primary,
                );
              },
              checkToShowDot: (spot, barData) {
                if (data.length <= 8) {
                  return true;
                }
                return spot.x.toInt() % (data.length ~/ 5) == 0 ||
                    spot.x.toInt() == data.length - 1;
              },
            ),
            belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(
                colors: [
                  colors.primary.withAlpha(40),
                  colors.primary.withAlpha(10),
                ],
                stops: const [0.4, 1.0],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          LineChartBarData(
            spots: List.generate(
              data.length,
              (index) => FlSpot(
                index.toDouble(),
                data[index].rightEyeScore.toDouble(),
              ),
            ),
            isCurved: true,
            color: colors.secondary,
            barWidth: 2.5,
            isStrokeCapRound: true,
            dotData: FlDotData(
              show: true,
              getDotPainter: (spot, percent, barData, index) {
                return FlDotCirclePainter(
                  radius: 4,
                  color: Colors.white,
                  strokeWidth: 2,
                  strokeColor: colors.secondary,
                );
              },
              checkToShowDot: (spot, barData) {
                if (data.length <= 8) {
                  return true;
                }
                return spot.x.toInt() % (data.length ~/ 5) == 0 ||
                    spot.x.toInt() == data.length - 1;
              },
            ),
            belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(
                colors: [
                  colors.secondary.withAlpha(40),
                  colors.secondary.withAlpha(10),
                ],
                stops: const [0.4, 1.0],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ],
        lineTouchData: LineTouchData(
          enabled: true,
          touchTooltipData: LineTouchTooltipData(
            // tooltipBgColor: colors.boxColor,
            getTooltipItems: (List<LineBarSpot> touchedSpots) {
              return touchedSpots.map((spot) {
                final index = spot.x.toInt();
                final data = _eyesightData[_selectedTimeRange]![index];
                final date = data.date;

                String eyeType;
                int score;
                Color color;

                if (spot.barIndex == 0) {
                  eyeType = 'Left Eye';
                  score = data.leftEyeScore;
                  color = colors.primary;
                } else {
                  eyeType = 'Right Eye';
                  score = data.rightEyeScore;
                  color = colors.secondary;
                }

                return LineTooltipItem(
                  '$eyeType: $score\n${date.day}/${date.month}/${date.year}',
                  TextStyle(color: color, fontWeight: FontWeight.bold),
                );
              }).toList();
            },
          ),
        ),
      ),
    );
  }

  TextSpan _getDecreaseTextSpan(List<EyesightData> data, bool isLeftEye) {
    final firstData = data.first;
    final lastData = data.last;

    int firstScore =
        isLeftEye ? firstData.leftEyeScore : firstData.rightEyeScore;
    int lastScore = isLeftEye ? lastData.leftEyeScore : lastData.rightEyeScore;

    int decrease = firstScore - lastScore;

    if (decrease > 0) {
      return TextSpan(
        text: ' ↓$decrease',
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.red,
        ),
      );
    }

    return const TextSpan(text: '');
  }

  // History starts here
  void _showTestHistorySheet(BuildContext context) {
    final allTimeData = _eyesightData['All Time']!;
    final sortedData = List<EyesightData>.from(allTimeData)
      ..sort((a, b) => b.date.compareTo(a.date));

    showModalBottomSheet(
      backgroundColor: EyesightColors().boxColor,
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.7,
          minChildSize: 0.5,
          maxChildSize: 0.95,
          expand: false,
          builder: (context, scrollController) {
            return Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Column(
                    children: [
                      Container(
                        height: 5,
                        width: 40,
                        decoration: BoxDecoration(
                          color: colors.grey0,
                          borderRadius: BorderRadius.circular(2.5),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Eyesight Test History',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: colors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Showing ${sortedData.length} tests',
                        style: TextStyle(
                          fontSize: 14,
                          color: colors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Text(
                          'Date',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: colors.textPrimary,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          'Left Eye',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: colors.textPrimary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          'Right Eye',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: colors.textPrimary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          'Average',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: colors.textPrimary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: ListView.builder(
                    controller: scrollController,
                    itemCount: sortedData.length,
                    itemBuilder: (context, index) {
                      final testData = sortedData[index];
                      final avgScore =
                          ((testData.leftEyeScore + testData.rightEyeScore) / 2)
                              .round();
                      final day = testData.date.day.toString().padLeft(2, '0');
                      final month = testData.date.month.toString().padLeft(
                        2,
                        '0',
                      );
                      final year = testData.date.year;

                      String leftChange = '';
                      String rightChange = '';

                      if (index < sortedData.length - 1) {
                        final prevTest = sortedData[index + 1];
                        final leftDiff =
                            testData.leftEyeScore - prevTest.leftEyeScore;
                        final rightDiff =
                            testData.rightEyeScore - prevTest.rightEyeScore;

                        leftChange = _formatScoreChange(leftDiff);
                        rightChange = _formatScoreChange(rightDiff);
                      }

                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: colors.grey0, width: 0.5),
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '$day/$month/$year',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      color: colors.textPrimary,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    _formatDayOfWeek(testData.date),
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: colors.textSecondary,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Score for the left eye
                            Expanded(
                              flex: 2,
                              child: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: testData.leftEyeScore.toString(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15,
                                        color: _getColorForScore(
                                          testData.leftEyeScore,
                                        ),
                                      ),
                                    ),
                                    TextSpan(
                                      text: leftChange,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color:
                                            leftChange.contains('+')
                                                ? Colors.green
                                                : (leftChange.isEmpty
                                                    ? Colors.transparent
                                                    : Colors.red),
                                        fontWeight:
                                            leftChange.contains('↓')
                                                ? FontWeight.bold
                                                : FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            // Score for the right eye
                            Expanded(
                              flex: 2,
                              child: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: testData.rightEyeScore.toString(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15,
                                        color: _getColorForScore(
                                          testData.rightEyeScore,
                                        ),
                                      ),
                                    ),
                                    TextSpan(
                                      text: rightChange,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color:
                                            rightChange.contains('+')
                                                ? Colors.green
                                                : (rightChange.isEmpty
                                                    ? Colors.transparent
                                                    : Colors.red),
                                        fontWeight:
                                            rightChange.contains('↓')
                                                ? FontWeight.bold
                                                : FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            // Average score
                            Expanded(
                              flex: 2,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: _getColorForScore(
                                    avgScore,
                                  ).withAlpha(26),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: _getColorForScore(
                                      avgScore,
                                    ).withAlpha(77),
                                    width: 1,
                                  ),
                                ),
                                child: Text(
                                  avgScore.toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: _getColorForScore(avgScore),
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  String _formatScoreChange(int diff) {
    if (diff == 0) return '';
    if (diff > 0) return ' (+$diff)';
    return ' (↓${diff.abs()})';
  }

  String _formatDayOfWeek(DateTime date) {
    final days = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];
    return days[(date.weekday - 1) % 7];
  }

  Color _getColorForScore(int score) {
    if (score >= 90) return Colors.green[700]!;
    if (score >= 80) return Colors.lightGreen[700]!;
    if (score >= 70) return Colors.amber[700]!;
    if (score >= 60) return Colors.orange[700]!;
    return Colors.red[700]!;
  }

  String _getScoreRating(int score) {
    if (score >= 90) return 'Excellent';
    if (score >= 80) return 'Good';
    if (score >= 70) return 'Average';
    if (score >= 60) return 'Fair';
    return 'Poor';
  }

  String _getEyeScoreRating(int score) {
    if (score >= 90) return 'Excellent';
    if (score >= 80) return 'Good';
    if (score >= 70) return 'Average';
    if (score >= 60) return 'Fair';
    return 'Poor';
  }

  String _getRecommendedCheckupInterval(int leftScore, int rightScore) {
    final avgScore = (leftScore + rightScore) / 2;
    if (avgScore >= 85) return '12 months';
    if (avgScore >= 75) return '9 months';
    if (avgScore >= 65) return '6 months';
    return '3 months';
  }

  String _getAdditionalRecommendation(int leftScore, int rightScore) {
    final avgScore = (leftScore + rightScore) / 2;
    if (avgScore < 70) {
      return '• Consider specialized vision therapy exercises';
    } else if (avgScore < 80) {
      return '• Incorporate eye-healthy foods in your diet';
    } else {
      return '• Maintain your current eye care routine';
    }
  }
}

class EyesightData {
  final DateTime date;
  final int leftEyeScore;
  final int rightEyeScore;

  EyesightData(this.date, this.leftEyeScore, this.rightEyeScore);
}
