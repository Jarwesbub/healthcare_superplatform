import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UserDataPage extends StatefulWidget {
  const UserDataPage({Key? key}) : super(key: key);

  @override
  State<UserDataPage> createState() => _UserDataPageState();
}

class _UserDataPageState extends State<UserDataPage> {
  Map<String, dynamic>? userData;

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  Future<void> loadUserData() async {
    final String response = await rootBundle.loadString(
      'assets/local/users/josefiina.json',
    );
    final data = json.decode(response);
    setState(() {
      userData = data['user'];
    });
  }

  Widget buildSection(String title, Map<String, dynamic> data) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double width = constraints.maxWidth;
        int columnCount =
            width > 800
                ? 3
                : width > 600
                ? 2
                : 1;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                  decoration: TextDecoration.none, // Ei alleviivausta
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 16,
                runSpacing: 16,
                children:
                    data.entries.map((entry) {
                      return SizedBox(
                        width:
                            (width - 32 - ((columnCount - 1) * 16)) /
                            columnCount,
                        child: Card(
                          elevation: 3,
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  entry.key,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  entry.value.toString(),
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildListAsSection(
    String title,
    List<dynamic> items,
    String Function(dynamic) displayFn,
  ) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double width = constraints.maxWidth;
        int columnCount =
            width > 800
                ? 2
                : width > 600
                ? 1
                : 1;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                  decoration: TextDecoration.none,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 16,
                runSpacing: 16,
                children:
                    items.map((item) {
                      return SizedBox(
                        width:
                            (width - 32 - ((columnCount - 1) * 16)) /
                            columnCount,
                        child: Card(
                          elevation: 3,
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Text(
                              displayFn(item),
                              style: const TextStyle(fontSize: 14),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (userData == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          buildSection("Perustiedot", {
            "Nimi": "${userData!['name']} ${userData!['surname']}",
            "Ikä": userData!['age'],
            "Sukupuoli": userData!['gender'],
            "Syntymäpäivä": userData!['birthaday'],
          }),
          buildSection(
            "Perusmittaukset",
            Map<String, dynamic>.from(userData!['basicMeasurements']),
          ),
          buildSection(
            "Laboratoriotulokset",
            Map<String, dynamic>.from(userData!['labResults']),
          ),
          buildSection(
            "Hyvinvointi",
            Map<String, dynamic>.from(userData!['wellbeing']),
          ),
          buildListAsSection(
            "Lääkkeet",
            List.from(
              userData!['medicationsAndVaccinations']['medicationList'],
            ),
            (med) => "${med['name']}: ${med['dosage']} (${med['time']})",
          ),
          buildListAsSection(
            "Diagnoosit",
            List.from(userData!['diagnoses']['diagnosisList']),
            (d) => "${d['description']} (${d['code']}, ${d['date']})",
          ),
          buildListAsSection(
            "Allergiat",
            List.from(userData!['diagnoses']['allergiesList']),
            (a) => a.toString(),
          ),
          buildSection(
            "Suun terveys",
            Map<String, dynamic>.from(userData!['dentalHealth']),
          ),
          buildSection(
            "Näkö ja kuulo",
            Map<String, dynamic>.from(userData!['visionAndHearing']),
          ),
          buildSection(
            "Työ & elämäntavat",
            Map<String, dynamic>.from(userData!['otherInfo']),
          ),
        ],
      ),
    );
  }
}
