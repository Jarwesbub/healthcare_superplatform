import 'package:flutter/material.dart';
import '../models/medication.dart';
import '../services/medication_data_service.dart';
import '../widgets/medication_card.dart';

class PrescriptionsPage extends StatefulWidget {
  const PrescriptionsPage({Key? key}) : super(key: key);

  @override
  State<PrescriptionsPage> createState() => _PrescriptionsPageState();
}

class _PrescriptionsPageState extends State<PrescriptionsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Medication> activeMedications =
        MedicationDataService.getActiveMedications();
    final List<Medication> expiredMedications =
        MedicationDataService.getExpiredMedications();

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Prescriptions'),
        backgroundColor: Colors.teal,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Add search functionality
            },
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              // Add filter functionality
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          tabs: const [Tab(text: 'Active'), Tab(text: 'Expired')],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Active Medications Tab
          _buildMedicationList(
            context,
            activeMedications,
            'Active Medications',
            'No active prescriptions',
          ),

          // Expired Medications Tab
          _buildMedicationList(
            context,
            expiredMedications,
            'Prescription History',
            'No expired prescriptions',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        child: const Icon(Icons.add),
        onPressed: () {
          // Add prescription functionality here if time
        },
      ),
    );
  }

  Widget _buildMedicationList(
    BuildContext context,
    List<Medication> medications,
    String title,
    String emptyMessage,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${medications.length} Prescriptions',
                style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child:
                medications.isEmpty
                    ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.medication_outlined,
                            size: 64,
                            color: Colors.grey.shade400,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            emptyMessage,
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    )
                    : ListView.builder(
                      itemCount: medications.length,
                      itemBuilder: (context, index) {
                        return MedicationCard(medication: medications[index]);
                      },
                    ),
          ),
        ],
      ),
    );
  }
}
