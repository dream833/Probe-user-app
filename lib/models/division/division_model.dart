// To parse this JSON data, do
//
//     final divisionModel = divisionModelFromJson(jsonString);

import 'dart:convert';

DivisionModel divisionModelFromJson(String str) => DivisionModel.fromJson(json.decode(str));

String divisionModelToJson(DivisionModel data) => json.encode(data.toJson());

class DivisionModel {
  int? id;
  String? name;
  int? branchId;
  String? createdAt;
  String? updatedAt;
  List<Division>? divisions;

  DivisionModel({
    this.id,
    this.name,
    this.branchId,
    this.createdAt,
    this.updatedAt,
    this.divisions,
  });

  factory DivisionModel.fromJson(Map<String, dynamic> json) => DivisionModel(
    id: json["id"],
    name: json["name"],
    branchId: json["branch_id"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    divisions: json["divisions"] == null ? [] : List<Division>.from(json["divisions"]!.map((x) => Division.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "branch_id": branchId,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "divisions": divisions == null ? [] : List<dynamic>.from(divisions!.map((x) => x.toJson())),
  };
}

class Division {
  int? id;
  String? name;
  String? createdAt;
  DateTime? updatedAt;
  int? districtId;

  Division({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.districtId,
  });

  factory Division.fromJson(Map<String, dynamic> json) => Division(
    id: json["id"],
    name: json["name"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    districtId: json["district_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "created_at": createdAt,
    "updated_at": updatedAt?.toIso8601String(),
    "district_id": districtId,
  };
}
