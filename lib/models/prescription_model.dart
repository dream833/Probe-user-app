class PrescriptionModel {
  String? patientFullName;
  String? patientGender;
  String? patientDateOfBirth;
  String? doctorName;
  List<Medicine>? medicines;
  List<FollowUpDate>? followUp;
  List<Referral>? referral;
  String? diagnosis;
  String? caseHistory;
  String? labTests;
  String? vitalUpdates;
  String? followUpDate;
  String? followUpTime;

  PrescriptionModel({
    this.patientFullName,
    this.patientDateOfBirth,
    this.patientGender,
    this.doctorName,
    this.referral,
    this.followUp,
    this.medicines,
    this.caseHistory,
    this.vitalUpdates,
    this.labTests,
    this.diagnosis,
    this.followUpDate,
    this.followUpTime,
  });

  PrescriptionModel.fromJson(Map<String, dynamic> json) {
    patientFullName = json['patientFullName'];
    patientDateOfBirth = json['patientDateOfBirth'];
    patientGender = json['patientGender'];
    doctorName = json['doctorName'];
    vitalUpdates = json['vital_update'];
    caseHistory = json['case_history'];

    if (json['medicines'] != null) {
      medicines = List<Medicine>.from(
        json['medicines'].map((medicine) => Medicine.fromJson(medicine)),
      );
    }
    if (json['follow_up'] != null) {
      medicines = List<Medicine>.from(
        json['follow_up'].map((medicine) => Medicine.fromJson(medicine)),
      );
    }
    if (json['referral'] != null) {
      medicines = List<Medicine>.from(
        json['referral'].map((medicine) => Medicine.fromJson(medicine)),
      );
    }
    diagnosis = json['diagnosis'];
    followUpDate = json['followUpDate'];
    followUpTime = json['followUpTime'];
  }

  PrescriptionModel copyWith({
    String? patientFullName,
    String? patientDateOfBirth,
    String? patientGender,
    String? patientContactInformation,
    String? doctorName,
    String? caseHistory,
    String? vitalUpdates,
    String? labTests,
    List<Medicine>? medicines,
    List<FollowUpDate>? followUp,
    List<Referral>? referral,
    String? diagnosis,
    String? followUpDate,
    String? followUpTime,
  }) {
    return PrescriptionModel(
      patientFullName: patientFullName ?? this.patientFullName,
      patientDateOfBirth: patientDateOfBirth ?? this.patientDateOfBirth,
      patientGender: patientGender ?? this.patientGender,
      doctorName: doctorName ?? this.doctorName,
      medicines: medicines ?? this.medicines,
      caseHistory: caseHistory ?? this.caseHistory,
      labTests: this.labTests ?? this.labTests,
      vitalUpdates: this.labTests ?? this.labTests,
      diagnosis: diagnosis ?? this.diagnosis,
      referral: referral ?? this.referral,
      followUp: followUp ?? this.followUp,
      followUpDate: followUpDate ?? this.followUpDate,
      followUpTime: followUpTime ?? this.followUpTime,
    );
  }

  // Method to convert PrescriptionModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'patientFullName': patientFullName,
      'patientGender': patientGender,
      'patientDateOfBirth': patientDateOfBirth,
      'doctorName': doctorName,
      'medicines': medicines?.map((medicine) => medicine.toJson()).toList(),
      'referral': referral?.map((referral) => referral.toJson()).toList(),
      'follow_up': followUp?.map((followUp) => followUp.toJson()).toList(),
      'diagnosis': diagnosis,
      'lab_tests': labTests,
      'vital_update': vitalUpdates,
      'case_history': caseHistory,
      'followUpDate': followUpDate,
      'followUpTime': followUpTime,
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

class Referral {
  String doctorname;
  String speciality;

  Referral({
    required this.doctorname,
    required this.speciality,
  });

  Map<String, dynamic> toJson() {
    return {
      'doctor_name': doctorname,
      'speciality': speciality,
    };
  }

  factory Referral.fromJson(Map<String, dynamic> json) {
    return Referral(
      doctorname: json['doctor_name'],
      speciality: json['speciality'],
    );
  }
}

class FollowUpDate {
  String followupdate;
  String note;

  FollowUpDate({
    required this.followupdate,
    required this.note,
  });

  Map<String, dynamic> toJson() {
    return {
      'follow_up_date': followupdate,
      'note': note,
    };
  }

  factory FollowUpDate.fromJson(Map<String, dynamic> json) {
    return FollowUpDate(
      followupdate: json['follow_up_date'],
      note: json['note'],
    );
  }
}
