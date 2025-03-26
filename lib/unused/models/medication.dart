class Medication {
  final String name;
  final String dosage;
  final String instructions;
  final String prescribedBy;
  final DateTime prescriptionDate;
  final DateTime refillDate;
  final DateTime expirationDate;
  final int remainingRefills;
  final bool isActive;

  Medication({
    required this.name,
    required this.dosage,
    required this.instructions,
    required this.prescribedBy,
    required this.prescriptionDate,
    required this.refillDate,
    required this.expirationDate,
    required this.remainingRefills,
    this.isActive = true,
  });
}