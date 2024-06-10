import 'dart:convert';

class AdminReportsModel {
  String? message;
  List<UserReport>? userReports;
  String? baseUrl;

  AdminReportsModel({
    this.message,
    this.userReports,
    this.baseUrl,
  });

  factory AdminReportsModel.fromRawJson(String str) =>
      AdminReportsModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AdminReportsModel.fromJson(Map<String, dynamic> json) =>
      AdminReportsModel(
        message: json["message"],
        userReports: json["userReports"] == null
            ? []
            : List<UserReport>.from(
                json["userReports"]!.map((x) => UserReport.fromJson(x))),
        baseUrl: json["base_url"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "userReports": userReports == null
            ? []
            : List<dynamic>.from(userReports!.map((x) => x.toJson())),
        "base_url": baseUrl,
      };
}

class UserReport {
  int? id;
  int? userId;
  String? reportName;
  String? report;
  DateTime? reportDate;
  DateTime? createdAt;
  DateTime? updatedAt;

  UserReport({
    this.id,
    this.userId,
    this.reportName,
    this.report,
    this.reportDate,
    this.createdAt,
    this.updatedAt,
  });

  factory UserReport.fromRawJson(String str) =>
      UserReport.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserReport.fromJson(Map<String, dynamic> json) => UserReport(
        id: json["id"],
        userId: json["user_id"],
        reportName: json["report_name"],
        report: json["report"],
        reportDate: json["report_date"] == null
            ? null
            : DateTime.parse(json["report_date"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "report_name": reportName,
        "report": report,
        "report_date":
            "${reportDate!.year.toString().padLeft(4, '0')}-${reportDate!.month.toString().padLeft(2, '0')}-${reportDate!.day.toString().padLeft(2, '0')}",
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
