// pages/medication_detail_page.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/medication.dart';

class PrescriptionDetailPage extends StatelessWidget {
  final Medication medication;

  const PrescriptionDetailPage({
    Key? key,
    required this.medication,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool needsRefill = medication.isActive && medication.refillDate.difference(DateTime.now()).inDays <= 3;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(medication.name),
        backgroundColor: Colors.teal,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // Edit medication functionality
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Medication Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              color: Colors.teal.shade50,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(40),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.medication,
                      size: 50,
                      color: Colors.teal,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    medication.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    medication.dosage,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
            
            // Medication Details
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle('Instructions'),
                  _buildInfoCard(
                    medication.instructions,
                    icon: Icons.description,
                  ),
                  const SizedBox(height: 20),
                  
                  _buildSectionTitle('Prescription Details'),
                  _buildDetailItem(
                    'Prescribed by',
                    medication.prescribedBy,
                    Icons.person,
                  ),
                  _buildDetailItem(
                    'Prescription date',
                    DateFormat('MMMM d, yyyy').format(medication.prescriptionDate),
                    Icons.event,
                  ),
                  _buildDetailItem(
                    'Refills remaining',
                    medication.remainingRefills.toString(),
                    Icons.repeat,
                  ),
                  _buildDetailItem(
                    'Expiration date',
                    DateFormat('MMMM d, yyyy').format(medication.refillDate.add(const Duration(days: 90))),
                    Icons.timer_off,
                  ),
                  
                  const SizedBox(height: 30),
                  
                  // Action Buttons
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.refresh),
                          label: Text(medication.isActive 
                            ? (medication.remainingRefills > 0 ? 'Request Refill' : 'Request Renewal') 
                            : 'Request Again'),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            backgroundColor: medication.isActive ? Colors.teal : Colors.blue,
                          ),
                          onPressed: () {
                            // Handle refill request
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  medication.isActive 
                                    ? (medication.remainingRefills > 0 
                                        ? 'Refill requested' 
                                        : 'Prescription renewal requested')
                                    : 'New prescription requested'
                                ),
                                backgroundColor: medication.isActive ? Colors.teal : Colors.blue,
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      OutlinedButton.icon(
                        icon: const Icon(Icons.question_answer),
                        label: const Text('Ask Doctor'),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          // Handle ask doctor functionality
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildInfoCard(String content, {required IconData icon}) {
    return Card(
      elevation: 0,
      color: Colors.grey.shade100,
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: Colors.teal),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                content,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        children: [
          Icon(
            icon,
            size: 22,
            color: Colors.teal,
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}