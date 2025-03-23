import '../models/medication.dart';

class MedicationDataService {
  static List<Medication> getMedications() {
    return [
          Medication(
            name: "Burana",
            dosage: "400mg",
            instructions: "Take as needed for pain, max 3 times per day",
            prescribedBy: "Dr. Gerhard",
            prescriptionDate: DateTime.now().subtract(const Duration(days: 10)),
            refillDate: DateTime.now().add(const Duration(days: 20)),
            expirationDate: DateTime.now().add(const Duration(days: 180)),
            remainingRefills: 1,
            isActive: true,
          ),
          Medication(
            name: "Panacod",
            dosage: "500mg/30mg",
            instructions: "Take one tablet as needed, max 4 times per day",
            prescribedBy: "Dr. Gerhard",
            prescriptionDate: DateTime.now().subtract(const Duration(days: 5)),
            refillDate: DateTime.now().add(const Duration(days: 3)),
            expirationDate: DateTime.now().add(const Duration(days: 365)),
            remainingRefills: 2,
            isActive: true,
          ),
          Medication(
            name: "Resepti #3",
            dosage: "5kg",
            instructions: "jotain jotain jotain jotain jotain jotain",
            prescribedBy: "Dr. Gerhard",
            prescriptionDate: DateTime.now().subtract(const Duration(days: 2)),
            refillDate: DateTime.now().add(const Duration(days: 8)),
            expirationDate: DateTime.now().add(const Duration(days: 730)),
            remainingRefills: 0,
            isActive: true,
          ),
          Medication(
            name: "Resepti #4",
            dosage: "1kg",
            instructions: "jotain jotain jotain jotain jotain jotain",
            prescribedBy: "Dr. Gerhard",
            prescriptionDate: DateTime.now().subtract(const Duration(days: 20)),
            refillDate: DateTime.now().add(const Duration(days: 40)),
            expirationDate: DateTime.now().add(const Duration(days: 540)),
            remainingRefills: 3,
            isActive: true,
          ),
          Medication(
            name: "Resepti #5",
            dosage: "100mg",
            instructions: "jotain jotain jotain jotain jotain jotain",
            prescribedBy: "Dr. Gerhard",
            prescriptionDate: DateTime.now().subtract(const Duration(days: 100)),
            refillDate: DateTime.now().subtract(const Duration(days: 70)),
            expirationDate: DateTime.now().subtract(const Duration(days: 10)),
            remainingRefills: 0,
            isActive: false,
          ),
          Medication(
            name: "Resepti #6",
            dosage: "200mg",
            instructions: "jotain jotain jotain jotain jotain jotain",
            prescribedBy: "Dr. Gerhard",
            prescriptionDate: DateTime.now().subtract(const Duration(days: 250)),
            refillDate: DateTime.now().subtract(const Duration(days: 200)),
            expirationDate: DateTime.now().subtract(const Duration(days: 100)),
            remainingRefills: 0,
            isActive: false,
          ),
    ];
  }
  static List<Medication> getActiveMedications() {
    return getMedications().where((med) => med.isActive).toList();
  }
  
  static List<Medication> getExpiredMedications() {
    return getMedications().where((med) => !med.isActive).toList();
  }
}
