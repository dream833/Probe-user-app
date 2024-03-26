// To parse this JSON data, do
//
//     final memberModel = memberModelFromJson(jsonString);

import 'dart:convert';

MemberModel memberModelFromJson(String str) => MemberModel.fromJson(json.decode(str));

String memberModelToJson(MemberModel data) => json.encode(data.toJson());

class MemberModel {
    int userId;
    String name;
    String relationship;
    int age;
    String gender;
    int medicineId;
    DateTime? updatedAt;
    DateTime? createdAt;
    int id;

    MemberModel({
        required this.userId,
        required this.name,
        required this.relationship,
        required this.age,
        required this.gender,
        required this.medicineId,
        required this.updatedAt,
        required this.createdAt,
        required this.id,
    });

    factory MemberModel.fromJson(Map<String, dynamic> json) => MemberModel(
        userId: json["user_id"],
        name: json["name"],
        relationship: json["relationship"],
        age: json["age"],
        gender: json["gender"],
        medicineId: 0,
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "user_id": userId,
        "name": name,
        "relationship": relationship,
        "age": age,
        "gender": gender,
        "medicine_id": medicineId,
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "id": id,
    };
}
