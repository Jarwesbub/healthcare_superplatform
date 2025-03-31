import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:healthcare_superplatform/demos/eyesight_stats/widgets/eyesight_table_widget.dart';
import 'package:healthcare_superplatform/demos/eyesight_stats/widgets/eyesight_appbar.dart';

class EyesightStatsPage extends StatefulWidget {
  const EyesightStatsPage({super.key});

  @override
  State<EyesightStatsPage> createState() => _EyesightStatsState();
}

class _EyesightStatsState extends State<EyesightStatsPage> {
  Map<String, dynamic>? data;

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
      appBar: const EyesightAppBar(title: 'Your eyesight stats'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        child: ListView(
          children: [
            const SizedBox(height: 10),
            SvgPicture.asset('assets/images/eye.svg'),
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
      child: Text(
        text,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }
}
