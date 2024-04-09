// To parse this JSON data, do
//
//     final branchModel = branchModelFromJson(jsonString);

import 'dart:convert';

BranchModel branchModelFromJson(String str) => BranchModel.fromJson(json.decode(str));

String branchModelToJson(BranchModel data) => json.encode(data.toJson());

class BranchModel {
  int? id;
  String? regionName;
  int? regionCode;
  int? zoneId;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<Branch>? branches;

  BranchModel({
    this.id,
    this.regionName,
    this.regionCode,
    this.zoneId,
    this.createdAt,
    this.updatedAt,
    this.branches,
  });

  factory BranchModel.fromJson(Map<String, dynamic> json) => BranchModel(
    id: json["id"],
    regionName: json["region_name"],
    regionCode: json["region_code"],
    zoneId: json["zone_id"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    branches: json["branches"] == null ? [] : List<Branch>.from(json["branches"]!.map((x) => Branch.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "region_name": regionName,
    "region_code": regionCode,
    "zone_id": zoneId,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "branches": branches == null ? [] : List<dynamic>.from(branches!.map((x) => x.toJson())),
  };
}

class Branch {
  int? id;
  String? branchName;
  int? branchCode;
  int? regionId;
  String? createdAt;
  String? updatedAt;

  Branch({
    this.id,
    this.branchName,
    this.branchCode,
    this.regionId,
    this.createdAt,
    this.updatedAt,
  });

  factory Branch.fromJson(Map<String, dynamic> json) => Branch(
    id: json["id"],
    branchName: json["branch_name"],
    branchCode: json["branch_code"],
    regionId: json["region_id"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "branch_name": branchName,
    "branch_code": branchCode,
    "region_id": regionId,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}
