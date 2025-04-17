import 'package:flutter/material.dart';
import 'package:healthcare_superplatform/demos/eyesight_stats/models/eyesight_colors.dart';
import 'package:healthcare_superplatform/demos/eyesight_stats/widgets/eyesight_appbar.dart';

class OpticalTestResultsPage extends StatefulWidget {
  const OpticalTestResultsPage({super.key});

  @override
  State<OpticalTestResultsPage> createState() => _OpticalTestResultsPageState();
}

class _OpticalTestResultsPageState extends State<OpticalTestResultsPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final EyesightColors colors = EyesightColors();
  
  // Hardcoded data maybe add this to a json if we have time
  final Map<String, dynamic> _latestTest = {
    'date': DateTime(2025, 4, 10),
    'doctor': 'Dr. Sarah Johnson',
    'clinic': 'ClearView Optical Center',
    'visualAcuity': {
      'rightEye': {
        'uncorrected': '20/100',
        'corrected': '20/25',
        'snellen': '6/7.5',
      },
      'leftEye': {
        'uncorrected': '20/80',
        'corrected': '20/25',
        'snellen': '6/7.5',
      },
    },
    'refraction': {
      'rightEye': {
        'sphere': '-2.50',
        'cylinder': '-0.75',
        'axis': '175',
        'add': '+1.25',
      },
      'leftEye': {
        'sphere': '-2.75',
        'cylinder': '-0.50',
        'axis': '10',
        'add': '+1.25',
      },
    },
    'keratometry': {
      'rightEye': {
        'k1': '43.75D @ 175°',
        'k2': '44.50D @ 85°',
      },
      'leftEye': {
        'k1': '43.50D @ 10°',
        'k2': '44.00D @ 100°',
      },
    },
    'intraocularPressure': {
      'rightEye': '16 mmHg',
      'leftEye': '17 mmHg',
    },
    'pupilDistance': '63 mm',
  };
  
  // Same here json if time
  final List<Map<String, dynamic>> _testHistory = [
    {
      'date': DateTime(2025, 4, 10),
      'doctor': 'Dr. Sarah Johnson',
      'visualAcuity': {
        'rightEye': {'corrected': '20/25'},
        'leftEye': {'corrected': '20/25'},
      },
      'refraction': {
        'rightEye': {'sphere': '-2.50', 'cylinder': '-0.75'},
        'leftEye': {'sphere': '-2.75', 'cylinder': '-0.50'},
      },
      'prescription': true,
    },
    {
      'date': DateTime(2024, 10, 15),
      'doctor': 'Dr. Michael Chen',
      'visualAcuity': {
        'rightEye': {'corrected': '20/25'},
        'leftEye': {'corrected': '20/25'},
      },
      'refraction': {
        'rightEye': {'sphere': '-2.25', 'cylinder': '-0.75'},
        'leftEye': {'sphere': '-2.50', 'cylinder': '-0.50'},
      },
      'prescription': true,
    },
    {
      'date': DateTime(2024, 4, 22),
      'doctor': 'Dr. Sarah Johnson',
      'visualAcuity': {
        'rightEye': {'corrected': '20/20'},
        'leftEye': {'corrected': '20/20'},
      },
      'refraction': {
        'rightEye': {'sphere': '-2.00', 'cylinder': '-0.50'},
        'leftEye': {'sphere': '-2.25', 'cylinder': '-0.50'},
      },
      'prescription': true,
    },
    {
      'date': DateTime(2023, 5, 7),
      'doctor': 'Dr. James Wilson',
      'visualAcuity': {
        'rightEye': {'corrected': '20/20'},
        'leftEye': {'corrected': '20/20'},
      },
      'refraction': {
        'rightEye': {'sphere': '-1.75', 'cylinder': '-0.50'},
        'leftEye': {'sphere': '-2.00', 'cylinder': '-0.25'},
      },
      'prescription': true,
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EyesightAppBar(title: 'Optical Test Results', isBackButtonVisible: true),
      backgroundColor: colors.surface,
      body: Column(
        children: [
          Container(
            color: colors.boxColor,
            child: TabBar(
              controller: _tabController,
              labelColor: colors.customPrimary,
              unselectedLabelColor: colors.textSecondary,
              indicatorColor: colors.customPrimary,
              tabs: const [
                Tab(text: 'Latest Results'),
                Tab(text: 'History'),
                Tab(text: 'Prescription'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildLatestResults(),
                _buildTestHistory(),
                _buildPrescription(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLatestResults() {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        _buildTestInfoCard(),
        const SizedBox(height: 16),
        _buildSectionHeader('Visual Acuity'),
        _buildVisualAcuityCard(),
        const SizedBox(height: 16),
        _buildSectionHeader('Refraction'),
        _buildRefractionCard(),
        const SizedBox(height: 16),
        _buildSectionHeader('Additional Measurements'),
        _buildAdditionalMeasurementsCard(),
        const SizedBox(height: 16),
        _buildSectionHeader('Eye Health Assessment'),
        _buildEyeHealthCard(),
        const SizedBox(height: 24),
        _buildActionButtons(),
      ],
    );
  }

  Widget _buildTestInfoCard() {
    final date = _latestTest['date'] as DateTime;
    final formattedDate = '${date.day}/${date.month}/${date.year}';
    
    return Card(
      color: colors.boxColor,
      margin: EdgeInsets.zero,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: colors.customPrimary.withOpacity(0.1),
                  child: Icon(Icons.calendar_today, color: colors.customPrimary, size: 20),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Latest Eye Examination',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: colors.textPrimary,
                      ),
                    ),
                    Text(
                      formattedDate,
                      style: TextStyle(
                        fontSize: 14,
                        color: colors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildInfoRow(Icons.person, 'Doctor', _latestTest['doctor']),
            const SizedBox(height: 8),
            _buildInfoRow(Icons.local_hospital, 'Clinic', _latestTest['clinic']),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 16, color: colors.grey1),
        const SizedBox(width: 8),
        Text(
          '$label:',
          style: TextStyle(
            fontSize: 14,
            color: colors.textSecondary,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: colors.textPrimary,
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: colors.textSecondary,
        ),
      ),
    );
  }

  Widget _buildVisualAcuityCard() {
    final vaData = _latestTest['visualAcuity'];
    
    return Card(
      color: colors.boxColor,
      margin: EdgeInsets.zero,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                const SizedBox(width: 80),
                Expanded(
                  child: Text(
                    'Right Eye',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: colors.textSecondary,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Left Eye',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: colors.textSecondary,
                    ),
                  ),
                ),
              ],
            ),
            const Divider(),
            // Uncorrected
            _buildVisualAcuityRow(
              'Uncorrected',
              vaData['rightEye']['uncorrected'],
              vaData['leftEye']['uncorrected'],
            ),
            // Corrected
            _buildVisualAcuityRow(
              'Corrected',
              vaData['rightEye']['corrected'],
              vaData['leftEye']['corrected'],
              isHighlighted: true,
            ),
            // Snellen
            _buildVisualAcuityRow(
              'Snellen (m)',
              vaData['rightEye']['snellen'],
              vaData['leftEye']['snellen'],
            ),
            const SizedBox(height: 12),
            // Explanation
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: colors.customPrimary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.info_outline,
                    size: 18,
                    color: colors.customPrimary,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      '20/20 vision is considered normal. The first number indicates the testing distance in feet, while the second indicates the distance a person with normal vision can read the same line.',
                      style: TextStyle(
                        fontSize: 12,
                        color: colors.textSecondary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVisualAcuityRow(String label, String rightValue, String leftValue, {bool isHighlighted = false}) {
    final textStyle = TextStyle(
      fontWeight: isHighlighted ? FontWeight.bold : FontWeight.normal,
      fontSize: isHighlighted ? 16 : 14,
      color: isHighlighted ? colors.customPrimary : colors.textPrimary,
    );
    
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: colors.textSecondary,
              ),
            ),
          ),
          Expanded(
            child: Text(
              rightValue,
              textAlign: TextAlign.center,
              style: textStyle,
            ),
          ),
          Expanded(
            child: Text(
              leftValue,
              textAlign: TextAlign.center,
              style: textStyle,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRefractionCard() {
    final refractionData = _latestTest['refraction'];
    
    return Card(
      color: colors.boxColor,
      margin: EdgeInsets.zero,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Explanation
            Container(
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: colors.customPrimary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.info_outline,
                    size: 18,
                    color: colors.customPrimary,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Sphere (SPH): Measures nearsightedness (-) or farsightedness (+)\nCylinder (CYL): Measures astigmatism\nAxis: Direction of astigmatism (0-180°)\nAdd: Additional power for reading/near vision',
                      style: TextStyle(
                        fontSize: 12,
                        color: colors.textSecondary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            Row(
              children: [
                SizedBox(
                  width: 80,
                  child: Text(
                    'Measure',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: colors.textSecondary,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Right Eye',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: colors.textSecondary,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Left Eye',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: colors.textSecondary,
                    ),
                  ),
                ),
              ],
            ),
            const Divider(),
            
            // SPH
            _buildRefractionRow(
              'Sphere',
              refractionData['rightEye']['sphere'],
              refractionData['leftEye']['sphere'],
              isHighlighted: true,
            ),
            
            // CYL
            _buildRefractionRow(
              'Cylinder',
              refractionData['rightEye']['cylinder'],
              refractionData['leftEye']['cylinder'],
              isHighlighted: true,
            ),
            
            // Axis
            _buildRefractionRow(
              'Axis',
              refractionData['rightEye']['axis'],
              refractionData['leftEye']['axis'],
            ),
            
            // Add
            _buildRefractionRow(
              'Add',
              refractionData['rightEye']['add'],
              refractionData['leftEye']['add'],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRefractionRow(String label, String rightValue, String leftValue, {bool isHighlighted = false}) {
    final regularTextStyle = TextStyle(
      fontSize: 14,
      color: colors.textPrimary,
    );
    
    final highlightedTextStyle = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: _getColorForRefractionValue(rightValue),
    );
    
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: colors.textSecondary,
              ),
            ),
          ),
          Expanded(
            child: Text(
              rightValue,
              textAlign: TextAlign.center,
              style: isHighlighted ? highlightedTextStyle : regularTextStyle,
            ),
          ),
          Expanded(
            child: Text(
              leftValue,
              textAlign: TextAlign.center,
              style: isHighlighted ? 
                TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: _getColorForRefractionValue(leftValue),
                ) : regularTextStyle,
            ),
          ),
        ],
      ),
    );
  }

  Color _getColorForRefractionValue(String value) {
    try {
      final numValue = double.parse(value.replaceAll(RegExp(r'[^\d.-]'), ''));
      if (numValue == 0) return Colors.green;
      if (numValue.abs() < 1.0) return Colors.amber;
      if (numValue.abs() < 3.0) return Colors.orange;
      return Colors.red;
    } catch (e) {
      return colors.textPrimary;
    }
  }

  Widget _buildAdditionalMeasurementsCard() {
    return Card(
      color: colors.boxColor,
      margin: EdgeInsets.zero,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Keratometry
            _buildMeasurementSection(
              'Keratometry (Corneal Curvature)',
              {
                'K1 (Right)': _latestTest['keratometry']['rightEye']['k1'],
                'K2 (Right)': _latestTest['keratometry']['rightEye']['k2'],
                'K1 (Left)': _latestTest['keratometry']['leftEye']['k1'],
                'K2 (Left)': _latestTest['keratometry']['leftEye']['k2'],
              },
            ),
            const Divider(),
            
            // IOP
            _buildMeasurementSection(
              'Intraocular Pressure (IOP)',
              {
                'Right Eye': _latestTest['intraocularPressure']['rightEye'],
                'Left Eye': _latestTest['intraocularPressure']['leftEye'],
                'Normal Range': '10-21 mmHg',
              },
            ),
            const Divider(),
            
            // Pupil Distance
            _buildMeasurementSection(
              'Pupillary Distance (PD)',
              {
                'Distance': _latestTest['pupilDistance'],
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMeasurementSection(String title, Map<String, String> values) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: colors.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        ...values.entries.map((entry) => Padding(
          padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
          child: Row(
            children: [
              Text(
                '${entry.key}:',
                style: TextStyle(
                  fontSize: 13,
                  color: colors.textSecondary,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                entry.value,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: colors.textPrimary,
                ),
              ),
            ],
          ),
        )).toList(),
      ],
    );
  }

  Widget _buildEyeHealthCard() {
    return Card(
      color: colors.boxColor,
      margin: EdgeInsets.zero,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildEyeHealthItem(
              'Anterior Segment',
              'Normal appearance with clear cornea and well-formed anterior chamber.',
              Icons.check_circle,
              Colors.green,
            ),
            const Divider(),
            _buildEyeHealthItem(
              'Retina & Optic Nerve',
              'Healthy retina with clear disc margins. No signs of retinopathy.',
              Icons.check_circle,
              Colors.green,
            ),
            const Divider(),
            _buildEyeHealthItem(
              'Color Vision',
              'Normal color perception (Ishihara test 14/14).',
              Icons.check_circle,
              Colors.green,
            ),
            const Divider(),
            _buildEyeHealthItem(
              'Risk Assessment',
              'Low risk for glaucoma. Continued monitoring recommended.',
              Icons.info,
              Colors.amber,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEyeHealthItem(String title, String description, IconData icon, Color iconColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: iconColor),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: colors.textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 13,
                    color: colors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.download),
            label: const Text('Download Report'),
            style: ElevatedButton.styleFrom(
              backgroundColor: colors.customPrimary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () => _tabController.animateTo(2),
            icon: const Icon(Icons.visibility),
            label: const Text('View Prescription'),
            style: OutlinedButton.styleFrom(
              foregroundColor: colors.customPrimary,
              side: BorderSide(color: colors.customPrimary),
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTestHistory() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: _testHistory.length,
      itemBuilder: (context, index) {
        final test = _testHistory[index];
        final date = test['date'] as DateTime;
        final formattedDate = '${date.day}/${date.month}/${date.year}';
        
        return Card(
          color: colors.boxColor,
          margin: const EdgeInsets.only(bottom: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ExpansionTile(
            tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            leading: CircleAvatar(
              backgroundColor: colors.customPrimary.withOpacity(0.1),
              child: Text(
                '${date.year}'.substring(2),
                style: TextStyle(
                  color: colors.customPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            title: Text(
              formattedDate,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: colors.textPrimary,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Text(
                  test['doctor'] as String,
                  style: TextStyle(
                    fontSize: 13,
                    color: colors.textSecondary,
                  ),
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    Icon(
                      Icons.remove_red_eye,
                      size: 14,
                      color: colors.grey1,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'OD: ${test['refraction']['rightEye']['sphere']} | OS: ${test['refraction']['leftEye']['sphere']}',
                      style: TextStyle(
                        fontSize: 13,
                        color: colors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            trailing: test['prescription'] == true
                ? Icon(Icons.description, color: colors.customPrimary)
                : null,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    _buildHistoryDetailRow('Visual Acuity (R)', test['visualAcuity']['rightEye']['corrected']),
                    _buildHistoryDetailRow('Visual Acuity (L)', test['visualAcuity']['leftEye']['corrected']),
                    _buildHistoryDetailRow('Sphere (R)', test['refraction']['rightEye']['sphere']),
                    _buildHistoryDetailRow('Sphere (L)', test['refraction']['leftEye']['sphere']),
                    _buildHistoryDetailRow('Cylinder (R)', test['refraction']['rightEye']['cylinder']),
                    _buildHistoryDetailRow('Cylinder (L)', test['refraction']['leftEye']['cylinder']),
                    
                    const SizedBox(height: 12),
                    if (test['prescription'] == true)
                      OutlinedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.visibility),
                        label: const Text('View Prescription'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: colors.customPrimary,
                          side: BorderSide(color: colors.customPrimary),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHistoryDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 13,
                color: colors.textSecondary,
              ),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: colors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPrescription() {
    final refractionData = _latestTest['refraction'];
    
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        Card(
          color: colors.boxColor,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Column(
                    children: [
                      Text(
                        'OPTICAL PRESCRIPTION',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: colors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'ClearView Optical Center',
                        style: TextStyle(
                          fontSize: 16,
                          color: colors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '123 Vision Lane, Opticsville',
                        style: TextStyle(
                          fontSize: 14,
                          color: colors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Phone: (555) 123-4567',
                        style: TextStyle(
                          fontSize: 14,
                          color: colors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                
                const Divider(height: 30),
                
                // Ai filled info change if necessary
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'PATIENT',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: colors.textSecondary,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'John Smith',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: colors.textPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'DATE',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: colors.textSecondary,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '10/04/2025',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: colors.textPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 16),
                
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'DOCTOR',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: colors.textSecondary,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Dr. Sarah Johnson',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: colors.textPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'VALID UNTIL',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: colors.textSecondary,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '10/04/2027',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: colors.textPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                
                const Divider(height: 30),
                
                Table(
                  border: TableBorder.all(
                    color: colors.grey0,
                    width: 1,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  columnWidths: const {
                    0: FlexColumnWidth(1.5),
                    1: FlexColumnWidth(2),
                    2: FlexColumnWidth(2),
                    3: FlexColumnWidth(2),
                    4: FlexColumnWidth(2),
                  },
                  children: [
                    TableRow(
                      decoration: BoxDecoration(
                        color: colors.grey0.withOpacity(0.3),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8),
                        ),
                      ),
                      children: [
                        _buildTableCell('', isHeader: true),
                        _buildTableCell('Sphere (SPH)', isHeader: true),
                        _buildTableCell('Cylinder (CYL)', isHeader: true),
                        _buildTableCell('Axis', isHeader: true),
                        _buildTableCell('Add', isHeader: true),
                      ],
                    ),
                    // Right eye
                    TableRow(
                      children: [
                        _buildTableCell('Right (OD)', isRowHeader: true),
                        _buildTableCell(refractionData['rightEye']['sphere'], isHighlighted: true),
                        _buildTableCell(refractionData['rightEye']['cylinder'], isHighlighted: true),
                        _buildTableCell(refractionData['rightEye']['axis']),
                        _buildTableCell(refractionData['rightEye']['add']),
                      ],
                    ),
                    // Left eye
                    TableRow(
                      children: [
                        _buildTableCell('Left (OS)', isRowHeader: true),
                        _buildTableCell(refractionData['leftEye']['sphere'], isHighlighted: true),
                        _buildTableCell(refractionData['leftEye']['cylinder'], isHighlighted: true),
                        _buildTableCell(refractionData['leftEye']['axis']),
                        _buildTableCell(refractionData['leftEye']['add']),
                      ],
                    ),
                  ],
                ),
                
                const SizedBox(height: 20),
                
                // Ai info change if necessary
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ADDITIONAL INFORMATION',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: colors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '• Pupillary Distance (PD): ${_latestTest['pupilDistance']}',
                      style: TextStyle(
                        fontSize: 14,
                        color: colors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '• Prescription Type: Progressive',
                      style: TextStyle(
                        fontSize: 14,
                        color: colors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '• Special Instructions: Anti-reflective coating recommended',
                      style: TextStyle(
                        fontSize: 14,
                        color: colors.textPrimary,
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 24),
                
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 1,
                            width: 200,
                            color: colors.textPrimary,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Doctor\'s Signature',
                            style: TextStyle(
                              fontSize: 12,
                              color: colors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(color: colors.grey0),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.verified,
                            color: colors.customPrimary,
                            size: 24,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'DIGITALLY VERIFIED',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: colors.customPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 24),
                
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.download),
                        label: const Text('Download'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colors.customPrimary,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.share),
                        label: const Text('Share'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: colors.customPrimary,
                          side: BorderSide(color: colors.customPrimary),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTableCell(String text, {bool isHeader = false, bool isRowHeader = false, bool isHighlighted = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
      alignment: Alignment.center,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: isHeader || isRowHeader ? 12 : 14,
          fontWeight: isHeader || isRowHeader || isHighlighted ? FontWeight.bold : FontWeight.normal,
          color: isHeader || isRowHeader
              ? colors.textSecondary
              : (isHighlighted ? colors.customPrimary : colors.textPrimary),
        ),
      ),
    );
  }
}