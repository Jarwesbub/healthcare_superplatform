import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:healthcare_superplatform/data/page_constants.dart';
import 'package:healthcare_superplatform/demos/eyesight_stats/models/eyesight_colors.dart';
import 'package:healthcare_superplatform/demos/eyesight_stats/pages/vision_score_utils.dart';
import 'package:healthcare_superplatform/demos/eyesight_stats/widgets/eyesight_mobile_appbar.dart';
import 'package:healthcare_superplatform/demos/eyesight_stats/widgets/eyesight_table_widget.dart';
import 'package:healthcare_superplatform/demos/eyesight_stats/widgets/charts/simplified_visual_acuity_chart.dart';
import 'package:healthcare_superplatform/demos/eyesight_stats/widgets/charts/simplified_pressure_chart.dart';
import 'package:healthcare_superplatform/demos/eyesight_stats/widgets/charts/simplified_keratometry_chart.dart';

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
      appBar: EyesightMobileAppBar(
        title: 'My Eye Health',
        isBackButtonVisible: true,
      ),
      backgroundColor: Colors.grey[50],
      body:
          data == null
              ? const Center(child: CircularProgressIndicator())
              : _buildContent(),
    );
  }

  Widget _buildContent() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: PageConstants.mobileViewLimit.toDouble(),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header section with eye icon and intro text
                _buildHeaderSection(),

                const SizedBox(height: 16),

                // Eye health summary card
                _buildSummaryCard(),

                const SizedBox(height: 24),

                // Toggle between charts and tables
                _buildViewToggle(),

                const SizedBox(height: 16),

                // Main content - either charts or tables
                if (showCharts) _buildChartsView() else _buildTablesView(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Column(
      children: [
        // Eye icon
        SvgPicture.asset('assets/images/eye.svg', height: 100),

        const SizedBox(height: 16),

        // Intro text
        Text(
          'Your Eye Health Summary',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: EyesightColors().primary,
          ),
          textAlign: TextAlign.center,
        ),

        const SizedBox(height: 8),

        const Text(
          'This report shows key measurements from your recent eye exam in simple, easy-to-understand charts.',
          style: TextStyle(fontSize: 16, height: 1.4),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildSummaryCard() {
    // Calculate a simplified vision health score (0-100%)
    double visionScore = VisionScoreUtils.calculateVisionScore(data);

    // Determine vision health status
    String visionStatus = VisionScoreUtils.getVisionStatus(visionScore);

    // Get appropriate color
    Color scoreColor = VisionScoreUtils.getScoreColor(visionScore);

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.visibility, color: EyesightColors().primary),
                const SizedBox(width: 8),
                const Text(
                  'At a Glance',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildVisionScoreIndicator(visionScore, visionStatus, scoreColor),
            const SizedBox(height: 16),
            _buildSummaryItem(
              'Diagnosis',
              _getDiagnosis(),
              Icons.medical_information,
            ),
            _buildSummaryItem(
              'Color Vision',
              _getColorVision(),
              Icons.colorize,
            ),
            _buildSummaryItem(
              'Recommendation',
              _getRecommendation(),
              Icons.medical_services,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVisionScoreIndicator(
    double score,
    String status,
    Color scoreColor,
  ) {
    return Row(
      children: [
        // Circular score indicator (enlarged)
        Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey.shade100,
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              CircularProgressIndicator(
                value: score / 100,
                strokeWidth: 6,
                backgroundColor: Colors.grey.shade200,
                valueColor: AlwaysStoppedAnimation<Color>(scoreColor),
              ),
              Text(
                '${score.round()}%',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: scoreColor,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Vision Health',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                status,
                style: TextStyle(
                  fontSize: 15,
                  color: scoreColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'Based on 1recent eye exam',
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDiagnosisSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.medical_information,
                size: 18,
                color: Colors.grey.shade700,
              ),
              const SizedBox(width: 6),
              const Text(
                'Doctor\'s Note',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            _getDiagnosis(),
            style: const TextStyle(fontSize: 14, height: 1.4),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 18, color: Colors.grey[600]),
          const SizedBox(width: 12),
          Text(
            '$label:',
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
          ),
          const SizedBox(width: 8),
          Expanded(child: Text(value, style: const TextStyle(fontSize: 15))),
        ],
      ),
    );
  }

  Widget _buildViewToggle() {
    return Center(
      child: SegmentedButton<bool>(
        segments: const [
          ButtonSegment<bool>(
            value: true,
            label: Text('Simple Charts'),
            icon: Icon(Icons.bar_chart),
          ),
          ButtonSegment<bool>(
            value: false,
            label: Text('Detailed Tables'),
            icon: Icon(Icons.table_chart),
          ),
        ],
        selected: {showCharts},
        onSelectionChanged: (Set<bool> selected) {
          setState(() {
            showCharts = selected.first;
          });
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color>((
            Set<MaterialState> states,
          ) {
            if (states.contains(MaterialState.selected)) {
              return EyesightColors().primary.withOpacity(0.1);
            }
            return Colors.transparent;
          }),
        ),
      ),
    );
  }

  Widget _buildChartsView() {
    return Column(
      children: [
        // Visual acuity chart - our simplified version
        SimplifiedVisualAcuityChart(eyesightData: data),

        const SizedBox(height: 16),

        // Intraocular Pressure Chart
        SimplifiedPressureChart(eyesightData: data),

        const SizedBox(height: 16),

        // Keratometry Chart
        SimplifiedKeratometryChart(eyesightData: data),
      ],
    );
  }

  Widget _buildTablesView() {
    return Column(
      children: [
        Card(
          elevation: 2,
          margin: const EdgeInsets.only(bottom: 16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Basic Information',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: EyesightColors().primary,
                  ),
                ),
                const SizedBox(height: 16),
                EyesightTableWidget(
                  tableContent: [
                    ['Type', 'Left Eye', 'Right Eye'],
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
                      'Eye pressure',
                      '${data?['intraocular_pressure']['left_eye']}',
                      '${data?['intraocular_pressure']['right_eye']}',
                    ],
                  ],
                  columnFlexValues: [2, 1, 1],
                ),
              ],
            ),
          ),
        ),

        Card(
          elevation: 2,
          margin: const EdgeInsets.only(bottom: 16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Cornea Measurements',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: EyesightColors().primary,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'These values describe the shape of your cornea',
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),
                const SizedBox(height: 16),
                EyesightTableWidget(
                  tableContent: [
                    ['Measurement', 'Left Eye', 'Right Eye'],
                    [
                      'Flat curve',
                      '${data?['keratometry']['left_eye']['flat_k']}',
                      '${data?['keratometry']['right_eye']['flat_k']}',
                    ],
                    [
                      'Steep curve',
                      '${data?['keratometry']['left_eye']['steep_k']}',
                      '${data?['keratometry']['right_eye']['steep_k']}',
                    ],
                    [
                      'Axis',
                      '${data?['keratometry']['left_eye']['axis']}',
                      '${data?['keratometry']['right_eye']['axis']}',
                    ],
                  ],
                  columnFlexValues: [2, 1, 1],
                ),
              ],
            ),
          ),
        ),

        Card(
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Doctor\'s Notes',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: EyesightColors().primary,
                  ),
                ),
                const SizedBox(height: 16),
                EyesightTableWidget(
                  tableContent: [
                    ['Type', 'Information'],
                    ['Color vision', '${data?['color_vision']}'],
                    ['Diagnosis', '${data?['diagnosis']}'],
                    ['Recommendations', '${data?['recommendations']}'],
                  ],
                  columnFlexValues: [1, 2],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDoctorsNotes() {
    // This method is no longer needed as we've integrated the notes into the main card
    return const SizedBox.shrink();
  }

  // Helper method to get color vision safely
  String _getColorVision() {
    return data?['color_vision'] ?? 'No color vision assessment provided.';
  } // Calculate an overall vision health score based on available metrics

  double _calculateVisionScore() {
    return VisionScoreUtils.calculateVisionScore(data);
  }

  // Helper method to remove need to check for null in template
  String _getRecommendation() {
    return data?['recommendations'] ??
        'Follow up with your eye doctor regularly.';
  }

  // Helper method to get diagnosis safely
  String _getDiagnosis() {
    return data?['diagnosis'] ?? 'No specific diagnosis provided.';
  }
}
