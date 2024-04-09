// To parse this JSON data, do
//
//     final districtModel = districtModelFromJson(jsonString);

import 'dart:convert';

DistrictModel districtModelFromJson(String str) => DistrictModel.fromJson(json.decode(str));

String districtModelToJson(DistrictModel data) => json.encode(data.toJson());

class DistrictModel {
  int? id;
  String? branchName;
  int? branchCode;
  int? regionId;
  String? createdAt;
  String? updatedAt;
  List<District>? districts;

  DistrictModel({
    this.id,
    this.branchName,
    this.branchCode,
    this.regionId,
    this.createdAt,
    this.updatedAt,
    this.districts,
  });

  factory DistrictModel.fromJson(Map<String, dynamic> json) => DistrictModel(
    id: json["id"],
    branchName: json["branch_name"],
    branchCode: json["branch_code"],
    regionId: json["region_id"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    districts: json["districts"] == null ? [] : List<District>.from(json["districts"]!.map((x) => District.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "branch_name": branchName,
    "branch_code": branchCode,
    "region_id": regionId,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "districts": districts == null ? [] : List<dynamic>.from(districts!.map((x) => x.toJson())),
  };
}

class District {
  int? id;
  String? name;
  int? branchId;
  String? createdAt;
  String? updatedAt;

  District({
    this.id,
    this.name,
    this.branchId,
    this.createdAt,
    this.updatedAt,
  });

  factory District.fromJson(Map<String, dynamic> json) => District(
    id: json["id"],
    name: json["name"],
    branchId: json["branch_id"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "branch_id": branchId,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}
