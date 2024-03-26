import 'dart:convert';

import 'package:uddipan/models/member_model.dart';

HealthCareModel healthCareModelFromJson(String str) =>
    HealthCareModel.fromJson(json.decode(str));

String healthCareModelToJson(HealthCareModel data) =>
    json.encode(data.toJson());

class HealthCareModel {
  int id;
  int userId;
  MemberModel member;
  String height;
  String weight;
  String bloodPressure;
  String bloodGroup;
  String sugar;
  DateTime recordDate;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic medicineId;

  HealthCareModel({
    required this.id,
    required this.userId,
    required this.member,
    required this.height,
    required this.weight,
    required this.bloodPressure,
    required this.bloodGroup,
    required this.sugar,
    required this.recordDate,
    required this.createdAt,
    required this.updatedAt,
    required this.medicineId,
  });

  factory HealthCareModel.fromJson(Map<String, dynamic> json) =>
      HealthCareModel(
        id: json["id"],
        userId: json["user_id"],
        member: MemberModel.fromJson(json["family_member"]),
        height: json["height"],
        weight: json["weight"],
        bloodPressure: json["blood_pressure"],
        bloodGroup: json["blood_group"],
        sugar: json["sugar"],
        recordDate: DateTime.parse(json["record_date"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        medicineId: 0,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "member": member.toJson(),
        "height": height,
        "weight": weight,
        "blood_pressure": bloodPressure,
        "blood_group": bloodGroup,
        "sugar": sugar,
        "record_date": recordDate.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "medicine_id": medicineId,
      };
}