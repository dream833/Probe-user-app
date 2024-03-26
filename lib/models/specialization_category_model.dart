// To parse this JSON data, do
//
//     final specializationCategory = specializationCategoryFromJson(jsonString);

import 'dart:convert';

SpecializationCategory specializationCategoryFromJson(String str) =>
    SpecializationCategory.fromJson(json.decode(str));

String specializationCategoryToJson(SpecializationCategory data) =>
    json.encode(data.toJson());

class SpecializationCategory {
  int? id;
  String? name;
  String? image;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? doctorsCount;

  SpecializationCategory({
    this.id,
    this.name,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.doctorsCount,
  });

  factory SpecializationCategory.fromJson(Map<String, dynamic> json) =>
      SpecializationCategory(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        doctorsCount: json["doctors_count"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "doctors_count": doctorsCount,
      };
}
