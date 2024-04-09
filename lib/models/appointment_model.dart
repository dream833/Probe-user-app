import 'package:uddipan/models/availability_model.dart';
import 'package:uddipan/models/doctor_model.dart';
import 'package:uddipan/models/member_model.dart';
import 'package:uddipan/models/transaction_model.dart';
import 'package:uddipan/models/user_report_model.dart';

class AppoinmentModel {
  int id;
  String? patientName;
  String? gender;
  int? age;
  String? serialNo;
  String? phone;
  String? clinic;
  String? clinicAddress;
  dynamic uploadDocs;

  List<UserReportModel>? userReport;
  dynamic prescription;
  dynamic status;
  dynamic payment;
  int? availabilityId;
  DateTime? createdAt;
  DateTime? updatedAt;
  AvailabilityModel? availability;
  DoctorModel? doctorModel;
  MemberModel? memberModel;
  TransactionModel? transationModel;
  bool isForYou;
  bool isForFamilyMember;
  AppoinmentModel({
    required this.id,
    this.patientName,
    this.gender,
    this.age,
    this.serialNo,
    this.phone,
    this.clinic,
    this.clinicAddress,
    this.uploadDocs,
    this.userReport,
    this.prescription,
    this.status,
    this.payment,
    this.availabilityId,
    this.createdAt,
    this.updatedAt,
    this.availability,
    this.doctorModel,
    this.memberModel,
    this.transationModel,
    required this.isForYou,
    required this.isForFamilyMember,
  });

  factory AppoinmentModel.fromJson(Map<String, dynamic> json) {
    return AppoinmentModel(
      id: json["id"],
      patientName: json["patient_name"],
      gender: json["gender"],
      age: json["age"],
      serialNo: json["serial_no"],
      phone: json["phone"],
      clinic: json["clinic"],
      clinicAddress: json["clinic_address"],
      uploadDocs: json["upload_docs"],
      prescription: json["prescription"],
      status: json["status"],
      payment: json["payment"],
      availabilityId: json["availability_id"],
      createdAt: json["created_at"] == null
          ? null
          : DateTime.parse(json["created_at"]),
      updatedAt: json["updated_at"] == null
          ? null
          : DateTime.parse(json["updated_at"]),
      availability: json["availability"] == null
          ? null
          : AvailabilityModel.fromJson(json["availability"]),
      doctorModel:
          json["doctor"] == null ? null : DoctorModel.fromJson(json["doctor"]),
      memberModel: json["family_member"] == null
          ? null
          : MemberModel.fromJson(json["family_member"]),
      transationModel: json["transactioninfo"] == null
          ? null
          : TransactionModel.fromJson(json["transactioninfo"]),
      userReport: json["user_reports"] == null
          ? null
          : (json["user_reports"] as List<dynamic>)
              .map<UserReportModel>(
                  (reportJson) => UserReportModel.fromJson(reportJson))
              .toList(),
      isForYou: json['isForYou'] == 1 ? true : false,
      isForFamilyMember: json['isForFamilyMember'] == 1 ? true : false,
    );
  }

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
        "lab_report": userReport,
        "prescription": prescription,
        "status": status,
        "payment": payment,
        "availability_id": availabilityId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "availability": availability?.toJson(),
      };
}
