class Medication {
  final String name;
  final String dosage;
  final String instructions;
  final String prescribedBy;
  final DateTime prescriptionDate;
  final DateTime expirationDate;
  final DateTime refillDate;
  final int remainingRefills;

  Medication({
    required this.name,
    required this.dosage,
    required this.instructions,
    required this.prescribedBy,
    required this.prescriptionDate,
    required this.expirationDate,
    required this.refillDate,
    required this.remainingRefills,
  });
}
