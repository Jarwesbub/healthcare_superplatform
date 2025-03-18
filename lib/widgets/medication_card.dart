import 'package:flutter/material.dart';
import '../models/medication.dart';
import 'package:intl/intl.dart';

class MedicationCard extends StatelessWidget {
  final Medication medication;

  const MedicationCard({
    Key? key,
    required this.medication,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool needsRefill = medication.refillDate.difference(DateTime.now()).inDays <= 3;
    
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.medication,
                    size: 40,
                    color: Colors.teal,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        medication.name,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        medication.dosage,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ],
                  ),
                ),
                PopupMenuButton(
                  icon: const Icon(Icons.more_vert),
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 'details',
                      child: Text('View Details'),
                    ),
                    const PopupMenuItem(
                      value: 'refill',
                      child: Text('Request Refill'),
                    ),
                  ],
                  onSelected: (value) {
                    //Joku hieno valikointi menu jos jaksaa
                  },
                ),
              ],
            ),
            const Divider(height: 24),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Instructions: ${medication.instructions}',
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Prescribed by: ${medication.prescribedBy}',
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Refills remaining: ${medication.remainingRefills}',
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            if (needsRefill)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.red.shade100,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.red.shade300),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.warning_amber_rounded,
                      size: 18,
                      color: Colors.red.shade700,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Refill by ${DateFormat('MMM d, yyyy').format(medication.refillDate)}',
                      style: TextStyle(
                        color: Colors.red.shade700,
                        fontWeight: FontWeight.w500,
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
}