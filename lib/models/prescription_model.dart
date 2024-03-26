class PrescriptionModel {
  String? patientFullName;
  String? patientGender;
  String? patientDateOfBirth;
  String? patientContactInformation;
  String? doctorName;
  String? medicalLicenseNumber;
  String? doctorContactInformation;
  String? clinicOrHospitalName;
  List<Medicine>? medicines;
  String? diagnosis;
  String? specialInstructions;
  String? followUpDate;
  String? followUpTime;
  String emergencyContact = '';
  PrescriptionModel({
    this.patientFullName,
    this.patientDateOfBirth,
    this.patientGender,
    this.patientContactInformation,
    this.doctorName,
    this.medicalLicenseNumber,
    this.doctorContactInformation,
    this.clinicOrHospitalName,
    this.medicines,
    this.diagnosis,
    this.specialInstructions,
    this.followUpDate,
    this.followUpTime,
    this.emergencyContact = '',
  });
  PrescriptionModel.fromJson(Map<String, dynamic> json) {
    patientFullName = json['patientFullName'];
    patientDateOfBirth = json['patientDateOfBirth'];
    patientGender = json['patientGender'];
    patientContactInformation = json['patientContactInformation'];
    doctorName = json['doctorName'];
    medicalLicenseNumber = json['medicalLicenseNumber'];
    doctorContactInformation = json['doctorContactInformation'];
    clinicOrHospitalName = json['clinicOrHospitalName'];
    if (json['medicines'] != null) {
      medicines = List<Medicine>.from(
        json['medicines'].map((medicine) => Medicine.fromJson(medicine)),
      );
    }
    diagnosis = json['diagnosis'];
    specialInstructions = json['specialInstructions'];
    followUpDate = json['followUpDate'];
    followUpTime = json['followUpTime'];
    emergencyContact = json['emergencyContact'] ?? '';
  }
  PrescriptionModel copyWith({
    String? patientFullName,
    String? patientDateOfBirth,
    String? patientGender,
    String? patientContactInformation,
    String? doctorName,
    String? medicalLicenseNumber,
    String? doctorContactInformation,
    String? clinicOrHospitalName,
    List<Medicine>? medicines,
    String? diagnosis,
    String? specialInstructions,
    String? followUpDate,
    String? followUpTime,
    String? emergencyContact,
  }) {
    return PrescriptionModel(
      patientFullName: patientFullName ?? this.patientFullName,
      patientDateOfBirth: patientDateOfBirth ?? this.patientDateOfBirth,
      patientGender: patientGender ?? this.patientGender,
      patientContactInformation:
          patientContactInformation ?? this.patientContactInformation,
      doctorName: doctorName ?? this.doctorName,
      medicalLicenseNumber: medicalLicenseNumber ?? this.medicalLicenseNumber,
      doctorContactInformation:
          doctorContactInformation ?? this.doctorContactInformation,
      clinicOrHospitalName: clinicOrHospitalName ?? this.clinicOrHospitalName,
      medicines: medicines ?? this.medicines,
      diagnosis: diagnosis ?? this.diagnosis,
      specialInstructions: specialInstructions ?? this.specialInstructions,
      followUpDate: followUpDate ?? this.followUpDate,
      followUpTime: followUpTime ?? this.followUpTime,
      emergencyContact: emergencyContact ?? this.emergencyContact,
    );
  }

  // Method to convert PrescriptionModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'patientFullName': patientFullName,
      'patientGender': patientGender,
      'patientDateOfBirth': patientDateOfBirth,
      'patientContactInformation': patientContactInformation,
      'doctorName': doctorName,
      'medicalLicenseNumber': medicalLicenseNumber,
      'doctorContactInformation': doctorContactInformation,
      'clinicOrHospitalName': clinicOrHospitalName,
      'medicines': medicines?.map((medicine) => medicine.toJson()).toList(),
      'diagnosis': diagnosis,
      'specialInstructions': specialInstructions,
      'followUpDate': followUpDate,
      'followUpTime': followUpTime,
      'emergencyContact': emergencyContact,
    };
  }
}

class Medicine {
  String description;
  String name;
  String time;
  int quantity;
  String duration;
  Medicine({
    required this.description,
    required this.name,
    required this.time,
    required this.quantity,
    required this.duration,
  });
  Map<String, dynamic> toJson() {
    return {
      'description': description,
      'name': name,
      'time': time,
      'quantity': quantity,
      'duration': duration,
    };
  }

  factory Medicine.fromJson(Map<String, dynamic> json) {
    return Medicine(
      description: json['description'],
      name: json['name'],
      time: json['time'],
      quantity: json['quantity'],
      duration: json['duration'],
    );
  }
}
