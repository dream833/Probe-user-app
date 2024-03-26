// To parse this JSON data, do
//
//     final reviewModel = reviewModelFromJson(jsonString);

import 'dart:convert';

ReviewModel reviewModelFromJson(String str) => ReviewModel.fromJson(json.decode(str));

String reviewModelToJson(ReviewModel data) => json.encode(data.toJson());

class ReviewModel {
    int? id;
    int? userId;
    int? doctorId;
    double? rating;
    String? review;
    DateTime? createdAt;
    DateTime? updatedAt;

    ReviewModel({
        this.id,
        this.userId,
        this.doctorId,
        this.rating,
        this.review,
        this.createdAt,
        this.updatedAt,
    });

    factory ReviewModel.fromJson(Map<String, dynamic> json) => ReviewModel(
        id: json["id"],
        userId: json["user_id"],
        doctorId: json["doctor_id"],
        rating: json["rating"],
        review: json["review"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "doctor_id": doctorId,
        "rating": rating,
        "review": review,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}
