import 'package:flutter/material.dart';
import 'dart:async';
import 'package:healthcare_superplatform/demos/eyesight_stats/models/eyesight_colors.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  bool _isDarkMode = false;
  bool _isEditing = false;
  String _name = 'John Doe';
  String _age = '30';
  double _profileCompleteness = 0.7;
  late TabController _tabController;
  final List<String> _notifications = [
    'Upcoming appointment on May 3rd',
    'Time to reorder contacts',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2,
      vsync: this,
    ); //Change length to 3 to see vision, and uncomment vision tab

    Timer(const Duration(milliseconds: 300), () {
      setState(() {
        _profileCompleteness = 0.7;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _updateProfilePicture() async {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Profile picture update functionality would go here'),
      ),
    );
  }

  void _toggleEditing() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  void _saveProfile() {
    setState(() {
      _isEditing = false;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated successfully!')),
      );
    });
  }

  void _scheduleAppointment() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 90)),
    ).then((selectedDate) {
      if (selectedDate != null) {
        showTimePicker(
          context: context,
          initialTime: const TimeOfDay(hour: 9, minute: 0),
        ).then((selectedTime) {
          if (selectedTime != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Appointment scheduled for ${selectedDate.toLocal().toString().split(' ')[0]} at ${selectedTime.format(context)}',
                ),
                backgroundColor: EyesightColors().primary,
              ),
            );
          }
        });
      }
    });
  }

  void _toggleDarkMode() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Color primaryColor =
        _isDarkMode
            ? EyesightColors().customPrimary
            : EyesightColors().customPrimary;
    final Color backgroundColor =
        _isDarkMode ? Colors.grey[900]! : Colors.white;
    final Color textColor = _isDarkMode ? Colors.white : Colors.black87;
    final Color secondaryTextColor =
        _isDarkMode ? Colors.white : Colors.grey[700]!;

    return Theme(
      data: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: Column(
          children: [
            Container(
              color: primaryColor,
              child: TabBar(
                controller: _tabController,
                indicatorColor: Colors.white,
                tabs: const [
                  Tab(icon: Icon(Icons.person), text: "Profile"),
                  //Tab(icon: Icon(Icons.visibility), text: "Vision"),
                  Tab(icon: Icon(Icons.settings), text: "Settings"),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildProfileTab(
                    backgroundColor,
                    textColor,
                    secondaryTextColor,
                    primaryColor,
                  ),
                  /* _buildVisionTab(
                    backgroundColor,
                    textColor,
                    secondaryTextColor,
                    primaryColor,
                  ),*/
                  _buildSettingsTab(
                    backgroundColor,
                    textColor,
                    secondaryTextColor,
                    primaryColor,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileTab(
    Color backgroundColor,
    Color textColor,
    Color secondaryTextColor,
    Color primaryColor,
  ) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Profile Completeness',
                      style: TextStyle(fontSize: 16, color: secondaryTextColor),
                    ),
                    Text(
                      '${(_profileCompleteness * 100).toInt()}%',
                      style: TextStyle(
                        fontSize: 16,
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                TweenAnimationBuilder<double>(
                  tween: Tween<double>(begin: 0.0, end: _profileCompleteness),
                  duration: const Duration(milliseconds: 1000),
                  builder:
                      (context, value, _) => LinearProgressIndicator(
                        value: value,
                        backgroundColor: Colors.grey[300],
                        valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                        minHeight: 8,
                        borderRadius: BorderRadius.circular(4),
                      ),
                ),
              ],
            ),
          ),

          Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(12),
            color: backgroundColor,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: _updateProfilePicture,
                    child: Stack(
                      children: [
                        Hero(
                          tag: 'profile-image',
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage: const AssetImage(
                              'assets/images/profile_placeholder.png',
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            decoration: BoxDecoration(
                              color: primaryColor,
                              shape: BoxShape.circle,
                            ),
                            padding: const EdgeInsets.all(6),
                            child: const Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                              size: 16,
                            ),
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
                        _isEditing
                            ? TextFormField(
                              initialValue: _name,
                              decoration: const InputDecoration(
                                labelText: 'Name',
                              ),
                              onChanged: (value) {
                                setState(() {
                                  _name = value;
                                });
                              },
                            )
                            : Text(
                              _name,
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: textColor,
                              ),
                            ),
                        const SizedBox(height: 4),
                        _isEditing
                            ? TextFormField(
                              initialValue: _age,
                              decoration: const InputDecoration(
                                labelText: 'Age',
                              ),
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                setState(() {
                                  _age = value;
                                });
                              },
                            )
                            : Text(
                              'Age: $_age',
                              style: TextStyle(
                                fontSize: 16,
                                color: secondaryTextColor,
                              ),
                            ),
                        if (!_isEditing) ...[
                          const SizedBox(height: 16),
                          OutlinedButton.icon(
                            onPressed: _toggleEditing,
                            icon: const Icon(Icons.edit),
                            label: const Text('Edit'),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: primaryColor,
                              side: BorderSide(color: primaryColor),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          Text(
            'Contact Information',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          const SizedBox(height: 8),
          _buildInfoCard(
            Icons.email,
            'Email',
            'john.doe@example.com',
            primaryColor,
            backgroundColor,
            textColor,
            secondaryTextColor,
          ),
          _buildInfoCard(
            Icons.phone,
            'Phone',
            '+1 (555) 123-4567',
            primaryColor,
            backgroundColor,
            textColor,
            secondaryTextColor,
          ),
          _buildInfoCard(
            Icons.location_on,
            'Address',
            '123 Vision Street, Eyetown, ST 12345',
            primaryColor,
            backgroundColor,
            textColor,
            secondaryTextColor,
          ),

          const SizedBox(height: 24),

          Text(
            'Insurance Information',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          const SizedBox(height: 8),
          _buildInfoCard(
            Icons.health_and_safety,
            'Provider',
            'VisionCare Plus',
            primaryColor,
            backgroundColor,
            textColor,
            secondaryTextColor,
          ),
          _buildInfoCard(
            Icons.credit_card,
            'Policy Number',
            'VSN-12345678',
            primaryColor,
            backgroundColor,
            textColor,
            secondaryTextColor,
          ),

          const SizedBox(height: 32),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                onPressed: _scheduleAppointment,
                icon: const Icon(Icons.calendar_today),
                label: const Text('Schedule Appointment'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _isDarkMode ? Colors.black38 : Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Medical records would open here'),
                    ),
                  );
                },
                icon: const Icon(Icons.folder),
                label: const Text('Records'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _isDarkMode ? Colors.black38 : Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildVisionTab(
    Color backgroundColor,
    Color textColor,
    Color secondaryTextColor,
    Color primaryColor,
  ) {
    final List<Map<String, dynamic>> visionHistory = [
      {
        'date': 'April 2024',
        'vision': '20/20',
        'pressure': 'Normal',
        'notes': 'Perfect vision',
      },
      {
        'date': 'October 2023',
        'vision': '20/25',
        'pressure': 'Normal',
        'notes': 'Minor deterioration',
      },
      {
        'date': 'April 2023',
        'vision': '20/20',
        'pressure': 'Normal',
        'notes': 'No issues',
      },
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor, primaryColor.withOpacity(0.7)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Row(
                  children: [
                    const Icon(Icons.visibility, color: Colors.white, size: 28),
                    const SizedBox(width: 8),
                    const Text(
                      'Current Vision Status',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.notifications),
                      onPressed: () => _showNotifications(context),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _buildVisionStatusItem(
                  'Vision',
                  '20/20 (Perfect Vision)',
                  Colors.white,
                ),
                _buildVisionStatusItem(
                  'Eye Pressure',
                  'Normal (14-16 mmHg)',
                  Colors.white,
                ),
                _buildVisionStatusItem(
                  'Last Check-up',
                  'April 10, 2024',
                  Colors.white,
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          Text(
            'Current Prescription',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          const SizedBox(height: 16),
          Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildPrescriptionInfo(
                        'Right Eye (OD)',
                        '+0.50',
                        '-0.75',
                        '180°',
                      ),
                      Container(width: 1, height: 80, color: Colors.grey[300]),
                      _buildPrescriptionInfo(
                        'Left Eye (OS)',
                        '+0.75',
                        '-0.50',
                        '175°',
                      ),
                    ],
                  ),
                  const Divider(),
                  ListTile(
                    leading: Icon(Icons.info_outline, color: primaryColor),
                    title: const Text('Additional Information'),
                    subtitle: const Text(
                      'PD: 62mm, Anti-glare coating recommended',
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton.icon(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Prescription would be shared'),
                            ),
                          );
                        },
                        icon: const Icon(Icons.share),
                        label: const Text('Share'),
                      ),
                      const SizedBox(width: 8),
                      TextButton.icon(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Prescription would be downloaded'),
                            ),
                          );
                        },
                        icon: const Icon(Icons.download),
                        label: const Text('Download PDF'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          Text(
            'Vision History',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          const SizedBox(height: 16),

          ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: visionHistory.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final record = visionHistory[index];
              return Card(
                elevation: 2,
                child: ExpansionTile(
                  title: Text(
                    record['date'],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  subtitle: Text('Vision: ${record['vision']}'),
                  leading: CircleAvatar(
                    backgroundColor: primaryColor.withOpacity(0.2),
                    child: Icon(Icons.remove_red_eye, color: primaryColor),
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildHistoryDetailRow('Vision', record['vision']),
                          _buildHistoryDetailRow(
                            'Eye Pressure',
                            record['pressure'],
                          ),
                          _buildHistoryDetailRow('Notes', record['notes']),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton.icon(
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Detailed report would open',
                                      ),
                                    ),
                                  );
                                },
                                icon: Icon(
                                  Icons.description,
                                  color: primaryColor,
                                  size: 18,
                                ),
                                label: Text(
                                  'View Full Report',
                                  style: TextStyle(color: primaryColor),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),

          const SizedBox(height: 32),

          Card(
            elevation: 4,
            color: _isDarkMode ? Colors.grey[800] : Colors.blue[50],
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.lightbulb,
                        color: _isDarkMode ? Colors.amber : Colors.orange,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Eye Care Tips',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _buildTipItem(
                    'Follow the 20-20-20 rule: Every 20 minutes, look at something 20 feet away for 20 seconds.',
                  ),
                  _buildTipItem(
                    'Maintain proper lighting when reading or working on a computer.',
                  ),
                  _buildTipItem('Keep your glasses and contact lenses clean.'),

                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('More eye care tips would be shown'),
                        ),
                      );
                    },
                    child: Text(
                      'View More Tips',
                      style: TextStyle(color: primaryColor),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsTab(
    Color backgroundColor,
    Color textColor,
    Color secondaryTextColor,
    Color primaryColor,
  ) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Account Settings',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          const SizedBox(height: 16),

          _buildSettingsCard(
            'Personal Information',
            'Update your name, contact details, and other personal information',
            Icons.person,
            primaryColor,
            backgroundColor,
            textColor,
            secondaryTextColor,
          ),

          _buildSettingsCard(
            'Notification Preferences',
            'Manage how you receive appointment reminders and updates',
            Icons.notifications_active,
            primaryColor,
            backgroundColor,
            textColor,
            secondaryTextColor,
          ),

          _buildSettingsCard(
            'Privacy & Security',
            'Manage data sharing preferences and security settings',
            Icons.security,
            primaryColor,
            backgroundColor,
            textColor,
            secondaryTextColor,
          ),

          _buildSettingsCard(
            'Appearance',
            'Customize the app theme and display preferences',
            Icons.color_lens,
            primaryColor,
            backgroundColor,
            textColor,
            secondaryTextColor,
            trailing: Switch(
              value: _isDarkMode,
              onChanged: (value) {
                setState(() {
                  _isDarkMode = value;
                });
              },
              activeColor: primaryColor,
            ),
          ),

          const SizedBox(height: 24),

          Text(
            'Help & Support',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          const SizedBox(height: 16),

          _buildSettingsCard(
            'Frequently Asked Questions',
            'Find answers to common questions',
            Icons.help,
            primaryColor,
            backgroundColor,
            textColor,
            secondaryTextColor,
          ),

          _buildSettingsCard(
            'Contact Support',
            'Get help from our support team',
            Icons.support_agent,
            primaryColor,
            backgroundColor,
            textColor,
            secondaryTextColor,
          ),

          const SizedBox(height: 32),

          Center(
            child: Column(
              children: [
                Text(
                  ' ',
                  style: TextStyle(fontSize: 14, color: secondaryTextColor),
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder:
                          (context) => AlertDialog(
                            title: const Text('Sign Out'),
                            content: const Text(
                              'Are you sure you want to sign out?',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('CANCEL'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Signed out successfully'),
                                    ),
                                  );
                                },
                                child: const Text('SIGN OUT'),
                              ),
                            ],
                          ),
                    );
                  },
                  child: Text(
                    'Sign Out',
                    style: TextStyle(color: Colors.red[300], fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(
    IconData icon,
    String title,
    String value,
    Color primaryColor,
    Color backgroundColor,
    Color textColor,
    Color secondaryTextColor,
  ) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 2,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: primaryColor.withOpacity(0.2),
          child: Icon(icon, color: primaryColor),
        ),
        title: Text(title, style: TextStyle(color: textColor)),
        subtitle: Text(value, style: TextStyle(color: secondaryTextColor)),
        trailing:
            _isEditing
                ? IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Edit $title field')),
                    );
                  },
                )
                : null,
      ),
    );
  }

  Widget _buildVisionStatusItem(String label, String value, Color textColor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 16, color: textColor.withOpacity(0.9)),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPrescriptionInfo(
    String title,
    String sphere,
    String cylinder,
    String axis,
  ) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text('Sphere: $sphere', textAlign: TextAlign.center),
          Text('Cylinder: $cylinder', textAlign: TextAlign.center),
          Text('Axis: $axis', textAlign: TextAlign.center),
        ],
      ),
    );
  }

  Widget _buildHistoryDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  Widget _buildTipItem(String tip) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle, size: 16, color: Colors.green),
          const SizedBox(width: 8),
          Expanded(child: Text(tip)),
        ],
      ),
    );
  }

  Widget _buildSettingsCard(
    String title,
    String description,
    IconData icon,
    Color primaryColor,
    Color backgroundColor,
    Color textColor,
    Color secondaryTextColor, {
    Widget? trailing,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      child: InkWell(
        onTap: () {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Opening $title settings')));
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: primaryColor.withOpacity(0.2),
                child: Icon(icon, color: primaryColor),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    Text(
                      description,
                      style: TextStyle(color: secondaryTextColor),
                    ),
                  ],
                ),
              ),
              trailing ?? Icon(Icons.chevron_right, color: secondaryTextColor),
            ],
          ),
        ),
      ),
    );
  }

  void _showNotifications(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder:
          (context) => Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Notifications',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child:
                      _notifications.isEmpty
                          ? const Center(child: Text('No notifications'))
                          : ListView.separated(
                            itemCount: _notifications.length,
                            separatorBuilder:
                                (context, index) => const Divider(),
                            itemBuilder: (context, index) {
                              return ListTile(
                                leading: CircleAvatar(
                                  backgroundColor:
                                      EyesightColors().customPrimary,
                                  child: const Icon(
                                    Icons.notifications,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                                title: Text(_notifications[index]),
                                trailing: IconButton(
                                  icon: const Icon(Icons.clear),
                                  onPressed: () {
                                    setState(() {
                                      _notifications.removeAt(index);
                                    });
                                    Navigator.pop(context);
                                  },
                                ),
                              );
                            },
                          ),
                ),
              ],
            ),
          ),
      isScrollControlled: true,
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.6,
      ),
    );
  }
}
