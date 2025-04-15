import 'package:flutter/material.dart';

/// Base class for all simplified eyesight charts
///
/// Provides common functionality and consistent styling across all charts
abstract class BaseEyesightChart extends StatelessWidget {
  final Map<String, dynamic>? eyesightData;

  const BaseEyesightChart({Key? key, required this.eyesightData})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (eyesightData == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: buildChartContent(context),
      ),
    );
  }

  /// Child classes implement this method to build their specific chart content
  Widget buildChartContent(BuildContext context);

  /// Common method to build chart title with tooltip
  Widget buildTitle(String title, String tooltipMessage) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 8),
        Tooltip(
          message: tooltipMessage,
          child: Icon(Icons.info_outline, size: 18, color: Colors.blue[300]),
        ),
      ],
    );
  }

  /// Common method to build interpretation panel
  Widget buildInterpretationPanel({
    required IconData icon,
    required Color color,
    required String text,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(icon, size: 36, color: color),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 16, height: 1.3),
            ),
          ),
        ],
      ),
    );
  }

  /// Common method to build "What This Means" section
  Widget buildExplanationSection(String explanation) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'What This Means',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        Text(explanation, style: const TextStyle(fontSize: 14, height: 1.4)),
      ],
    );
  }

  /// Common method to build legend items
  Widget buildLegendItem(Color color, String label) {
    return Row(
      children: [
        Container(width: 14, height: 14, color: color),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  /// Common method to build measurement values display
  Widget buildMeasurementValues({
    required String leftLabel,
    required String rightLabel,
    Color leftColor = Colors.blue,
    Color rightColor = Colors.green,
  }) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(fontSize: 14, color: Colors.black87),
        children: [
          const TextSpan(
            text: 'Left: ',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          TextSpan(text: '$leftLabel ', style: TextStyle(color: leftColor)),
          const TextSpan(
            text: 'Right: ',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          TextSpan(text: rightLabel, style: TextStyle(color: rightColor)),
        ],
      ),
    );
  }
}
