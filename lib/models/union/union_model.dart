// To parse this JSON data, do
//
//     final unionModel = unionModelFromJson(jsonString);

import 'dart:convert';

UnionModel unionModelFromJson(String str) => UnionModel.fromJson(json.decode(str));

String unionModelToJson(UnionModel data) => json.encode(data.toJson());

class UnionModel {
  int? id;
  String? name;
  int? divisionId;
  String? createdAt;
  String? updatedAt;
  List<Union>? unions;

  UnionModel({
    this.id,
    this.name,
    this.divisionId,
    this.createdAt,
    this.updatedAt,
    this.unions,
  });

  factory UnionModel.fromJson(Map<String, dynamic> json) => UnionModel(
    id: json["id"],
    name: json["name"],
    divisionId: json["division_id"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    unions: json["unions"] == null ? [] : List<Union>.from(json["unions"]!.map((x) => Union.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "division_id": divisionId,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "unions": unions == null ? [] : List<dynamic>.from(unions!.map((x) => x.toJson())),
  };
}

class Union {
  int? id;
  String? name;
  int? thanaId;
  DateTime? createdAt;
  DateTime? updatedAt;

  Union({
    this.id,
    this.name,
    this.thanaId,
    this.createdAt,
    this.updatedAt,
  });

  factory Union.fromJson(Map<String, dynamic> json) => Union(
    id: json["id"],
    name: json["name"],
    thanaId: json["thana_id"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "thana_id": thanaId,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
