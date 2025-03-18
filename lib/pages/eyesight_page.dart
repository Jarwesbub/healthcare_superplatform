import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:healthcare_superplatform/widgets/custom_appbar.dart';
import 'package:healthcare_superplatform/widgets/table_widget.dart';

class EyesightPage extends StatefulWidget {
  const EyesightPage({super.key});

  @override
  State<EyesightPage> createState() => _EyeSightState();
}

class _EyeSightState extends State<EyesightPage> {
  final Map<String, Color> itemColors = {
    'primary': Color(0xFF95F3BC),
    'secondary': Colors.white,
  };
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
      appBar: const CustomAppBar(title: 'Your eyesight stats'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        child: ListView(
          children: [
            const SizedBox(height: 10),
            SvgPicture.asset('assets/images/eye.svg'),
            _headline('Basic information'),
            TableWidget(
              rows: 3,
              items: {
                'titles': ['Type', 'Left', 'Right'],
                'row1': [
                  'Visual acuity',
                  '${data?['visual_acuity']['left_eye']}',
                  '${data?['visual_acuity']['right_eye']}',
                ],
                'row2': [
                  'Refraction',
                  '${data?['refraction']['left_eye']}',
                  '${data?['refraction']['right_eye']}',
                ],
                'row3': [
                  'Intraocular pressure',
                  '${data?['intraocular_pressure']['left_eye']}',
                  '${data?['intraocular_pressure']['right_eye']}',
                ],
              },
            ),
            _headline('Keratometry'),
            TableWidget(
              rows: 3,
              items: {
                'titles': ['Type', 'Left', 'Right'],
                'row1': [
                  'Flat curvature',
                  '${data?['keratometry']['left_eye']['flat_k']}',
                  '${data?['keratometry']['right_eye']['flat_k']}',
                ],
                'row2': [
                  'Steep curvature',
                  '${data?['keratometry']['left_eye']['steep_k']}',
                  '${data?['keratometry']['right_eye']['steep_k']}',
                ],
                'row3': [
                  'Axis',
                  '${data?['keratometry']['left_eye']['axis']}',
                  '${data?['keratometry']['right_eye']['axis']}',
                ],
              },
            ),
            _headline('Other'),
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
      margin: const EdgeInsets.symmetric(vertical: 40),
      decoration: BoxDecoration(color: itemColors['primary']),
      child: Text(
        text,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }
}
