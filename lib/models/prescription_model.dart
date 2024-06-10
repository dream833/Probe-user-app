import 'dart:convert';

class PrescriptionModel {
  int? id;
  int? appointmentId;
  int? doctorId;
  String? userId;
  String? vitalUpdate;
  String? caseHistory;
  String? diagnosis;
  String? labTests;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<Referral>? referrals;
  List<FollowUp>? followUps;
  List<Medicine>? medicines;
  Appointment? appointment;

  PrescriptionModel({
    this.id,
    this.appointmentId,
    this.doctorId,
    this.userId,
    this.vitalUpdate,
    this.caseHistory,
    this.diagnosis,
    this.labTests,
    this.createdAt,
    this.updatedAt,
    this.referrals,
    this.followUps,
    this.medicines,
    this.appointment,
  });

  factory PrescriptionModel.fromRawJson(String str) =>
      PrescriptionModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PrescriptionModel.fromJson(Map<String, dynamic> json) =>
      PrescriptionModel(
        id: json["id"],
        appointmentId: json["appointment_id"],
        doctorId: json["doctor_id"],
        userId: json["user_id"],
        vitalUpdate: json["vital_update"],
        caseHistory: json["case_history"],
        diagnosis: json["diagnosis"],
        labTests: json["lab_tests"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        referrals: json["referrals"] == null
            ? []
            : List<Referral>.from(
                json["referrals"]!.map((x) => Referral.fromJson(x))),
        followUps: json["follow_ups"] == null
            ? []
            : List<FollowUp>.from(
                json["follow_ups"]!.map((x) => FollowUp.fromJson(x))),
        medicines: json["medicines"] == null
            ? []
            : List<Medicine>.from(
                json["medicines"]!.map((x) => Medicine.fromJson(x))),
        appointment: json["appointment"] == null
            ? null
            : Appointment.fromJson(json["appointment"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "appointment_id": appointmentId,
        "doctor_id": doctorId,
        "user_id": userId,
        "vital_update": vitalUpdate,
        "case_history": caseHistory,
        "diagnosis": diagnosis,
        "lab_tests": labTests,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "referrals": referrals == null
            ? []
            : List<dynamic>.from(referrals!.map((x) => x.toJson())),
        "follow_ups": followUps == null
            ? []
            : List<dynamic>.from(followUps!.map((x) => x.toJson())),
        "medicines": medicines == null
            ? []
            : List<dynamic>.from(medicines!.map((x) => x.toJson())),
        "appointment": appointment?.toJson(),
      };
}

class Appointment {
  int? id;
  String? patientName;
  String? gender;
  int? age;
  String? serialNo;
  String? phone;
  String? clinic;
  String? clinicAddress;
  dynamic uploadDocs;
  dynamic labReport;
  dynamic prescription;
  int? status;
  String? payment;
  String? paymentFile;
  String? transactionId;
  int? availabilityId;
  dynamic videoId;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? doctorId;
  int? patientId;
  DateTime? appointmentDate;
  int? isForYou;
  int? isForFamilyMember;
  dynamic familyMemberId;
  dynamic familyMember;
  List<dynamic>? userReports;

  Appointment({
    this.id,
    this.patientName,
    this.gender,
    this.age,
    this.serialNo,
    this.phone,
    this.clinic,
    this.clinicAddress,
    this.uploadDocs,
    this.labReport,
    this.prescription,
    this.status,
    this.payment,
    this.paymentFile,
    this.transactionId,
    this.availabilityId,
    this.videoId,
    this.createdAt,
    this.updatedAt,
    this.doctorId,
    this.patientId,
    this.appointmentDate,
    this.isForYou,
    this.isForFamilyMember,
    this.familyMemberId,
    this.familyMember,
    this.userReports,
  });

  factory Appointment.fromRawJson(String str) =>
      Appointment.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Appointment.fromJson(Map<String, dynamic> json) => Appointment(
        id: json["id"],
        patientName: json["patient_name"],
        gender: json["gender"],
        age: json["age"],
        serialNo: json["serial_no"],
        phone: json["phone"],
        clinic: json["clinic"],
        clinicAddress: json["clinic_address"],
        uploadDocs: json["upload_docs"],
        labReport: json["lab_report"],
        prescription: json["prescription"],
        status: json["status"],
        payment: json["payment"],
        paymentFile: json["payment_file"],
        transactionId: json["transaction_id"],
        availabilityId: json["availability_id"],
        videoId: json["video_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        doctorId: json["doctor_id"],
        patientId: json["patient_id"],
        appointmentDate: json["appointment_date"] == null
            ? null
            : DateTime.parse(json["appointment_date"]),
        isForYou: json["isForYou"],
        isForFamilyMember: json["isForFamilyMember"],
        familyMemberId: json["family_member_id"],
        familyMember: json["family_member"],
        userReports: json["user_reports"] == null
            ? []
            : List<dynamic>.from(json["user_reports"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "patient_name": patientName,
        "gender": gender,
        "age": age,
        "serial_no": serialNo,
        "phone": phone,
        "clinic": clinic,
        "clinic_address": clinicAddress,
        "upload_docs": uploadDocs,
        "lab_report": labReport,
        "prescription": prescription,
        "status": status,
        "payment": payment,
        "payment_file": paymentFile,
        "transaction_id": transactionId,
        "availability_id": availabilityId,
        "video_id": videoId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "doctor_id": doctorId,
        "patient_id": patientId,
        "appointment_date":
            "${appointmentDate!.year.toString().padLeft(4, '0')}-${appointmentDate!.month.toString().padLeft(2, '0')}-${appointmentDate!.day.toString().padLeft(2, '0')}",
        "isForYou": isForYou,
        "isForFamilyMember": isForFamilyMember,
        "family_member_id": familyMemberId,
        "family_member": familyMember,
        "user_reports": userReports == null
            ? []
            : List<dynamic>.from(userReports!.map((x) => x)),
      };
}

class FollowUp {
  int? id;
  int? prescriptionId;
  String? followUpDate;
  String? note;
  DateTime? createdAt;
  DateTime? updatedAt;

  FollowUp({
    this.id,
    this.prescriptionId,
    this.followUpDate,
    this.note,
    this.createdAt,
    this.updatedAt,
  });

  factory FollowUp.fromRawJson(String str) =>
      FollowUp.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FollowUp.fromJson(Map<String, dynamic> json) => FollowUp(
        id: json["id"],
        prescriptionId: json["prescription_id"],
        followUpDate: json["follow_up_date"],
        note: json["note"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "prescription_id": prescriptionId,
        "follow_up_date": followUpDate,
        "note": note,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class Medicine {
  int? id;
  int? prescriptionId;
  String? name;
  String? quantity;
  String? duration;
  String? dosage;
  String? absorption;
  DateTime? createdAt;
  DateTime? updatedAt;
  MedicineTime? medicineTime;

  Medicine({
    this.id,
    this.prescriptionId,
    this.name,
    this.quantity,
    this.duration,
    this.dosage,
    this.absorption,
    this.createdAt,
    this.updatedAt,
    this.medicineTime,
  });

  factory Medicine.fromRawJson(String str) =>
      Medicine.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Medicine.fromJson(Map<String, dynamic> json) => Medicine(
        id: json["id"],
        prescriptionId: json["prescription_id"],
        name: json["name"],
        quantity: json["quantity"],
        duration: json["duration"],
        dosage: json["dosage"],
        absorption: json["absorption"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        medicineTime: json["medicine_time"] == null
            ? null
            : MedicineTime.fromJson(json["medicine_time"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "prescription_id": prescriptionId,
        "name": name,
        "quantity": quantity,
        "duration": duration,
        "dosage": dosage,
        "absorption": absorption,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "medicine_time": medicineTime?.toJson(),
      };
}

class MedicineTime {
  int? id;
  int? medicineId;
  int? morning;
  int? afternoon;
  int? evening;
  DateTime? createdAt;
  DateTime? updatedAt;

  MedicineTime({
    this.id,
    this.medicineId,
    this.morning,
    this.afternoon,
    this.evening,
    this.createdAt,
    this.updatedAt,
  });

  factory MedicineTime.fromRawJson(String str) =>
      MedicineTime.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MedicineTime.fromJson(Map<String, dynamic> json) => MedicineTime(
        id: json["id"],
        medicineId: json["medicine_id"],
        morning: json["morning"],
        afternoon: json["afternoon"],
        evening: json["evening"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "medicine_id": medicineId,
        "morning": morning,
        "afternoon": afternoon,
        "evening": evening,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class Referral {
  int? id;
  int? prescriptionId;
  String? doctorName;
  String? specialty;
  DateTime? createdAt;
  DateTime? updatedAt;

  Referral({
    this.id,
    this.prescriptionId,
    this.doctorName,
    this.specialty,
    this.createdAt,
    this.updatedAt,
  });

  factory Referral.fromRawJson(String str) =>
      Referral.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Referral.fromJson(Map<String, dynamic> json) => Referral(
        id: json["id"],
        prescriptionId: json["prescription_id"],
        doctorName: json["doctor_name"],
        specialty: json["specialty"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "prescription_id": prescriptionId,
        "doctor_name": doctorName,
        "specialty": specialty,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
