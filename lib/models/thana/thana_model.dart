// To parse this JSON data, do
//
//     final thanaModel = thanaModelFromJson(jsonString);

import 'dart:convert';

ThanaModel thanaModelFromJson(String str) => ThanaModel.fromJson(json.decode(str));

String thanaModelToJson(ThanaModel data) => json.encode(data.toJson());

class ThanaModel {
  int? id;
  String? name;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? districtId;
  List<Thana>? thanas;

  ThanaModel({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.districtId,
    this.thanas,
  });

  factory ThanaModel.fromJson(Map<String, dynamic> json) => ThanaModel(
    id: json["id"],
    name: json["name"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    districtId: json["district_id"],
    thanas: json["thanas"] == null ? [] : List<Thana>.from(json["thanas"]!.map((x) => Thana.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "district_id": districtId,
    "thanas": thanas == null ? [] : List<dynamic>.from(thanas!.map((x) => x.toJson())),
  };
}

class Thana {
  int? id;
  String? name;
  int? divisionId;
  String? createdAt;
  String? updatedAt;

  Thana({
    this.id,
    this.name,
    this.divisionId,
    this.createdAt,
    this.updatedAt,
  });

  factory Thana.fromJson(Map<String, dynamic> json) => Thana(
    id: json["id"],
    name: json["name"],
    divisionId: json["division_id"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "division_id": divisionId,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}
