import 'package:flutter/material.dart';
import '../models/medication.dart';
import '../services/medication_data_service.dart';
import '../widgets/medication_card.dart';

class PrescriptionsPage extends StatelessWidget {
  const PrescriptionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Medication> medications = DummyDataService.getMedications();
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Prescriptions'),
        backgroundColor: Colors.teal,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              //Search (joskus)
            },
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              //Filter (joskus)
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Active Medications',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: medications.length,
                itemBuilder: (context, index) {
                  return MedicationCard(medication: medications[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}