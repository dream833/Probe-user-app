class UserReportModel {
  int id;
  int userId;
  int? familyMemberId; // This can be null
  String name;
  String file;
  String date;
  String createdAt;
  String updatedAt;

  UserReportModel({
    required this.id,
    required this.userId,
    this.familyMemberId,
    required this.name,
    required this.file,
    required this.date,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserReportModel.fromJson(Map<String, dynamic> json) {
    return UserReportModel(
      id: json['id'],
      userId: json['user_id'],
      familyMemberId: json['family_member_id'] ?? 0,
      name: json['name'],
      file: json['file'],
      date: json['date'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}

// class AdminReportModel {
//   int id;
//   int userId;
//  // This can be null
//   String name;
//   String file;
//   String date;
//   String createdAt;
//   String updatedAt;

//   AdminReportModel({
//     required this.id,
//     required this.userId,

//     required this.name,
//     required this.file,
//     required this.date,
//     required this.createdAt,
//     required this.updatedAt,
//   });

//   factory AdminReportModel.fromJson(Map<String, dynamic> json) {
//     return AdminReportModel(
//       id: json['id'],
//       userId: json['user_id'],
//       name: json['report_name'],
//       file: json['file'],
//       date: json['date'],
//       createdAt: json['created_at'],
//       updatedAt: json['updated_at'],
//     );
//   }
// }
class AdminReportModel {
  String? message;
  List<UserReports>? userReports;
  String? baseUrl;

  AdminReportModel({this.message, this.userReports, this.baseUrl});

  AdminReportModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['userReports'] != null) {
      userReports = <UserReports>[];
      json['userReports'].forEach((v) {
        userReports!.add(UserReports.fromJson(v));
      });
    }
    baseUrl = json['base_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (userReports != null) {
      data['userReports'] = userReports!.map((v) => v.toJson()).toList();
    }
    data['base_url'] = baseUrl;
    return data;
  }
}

class UserReports {
  int? id;
  int? userId;
  String? reportName;
  String? report;
  String? reportDate;
  String? createdAt;
  String? updatedAt;

  UserReports(
      {this.id,
      this.userId,
      this.reportName,
      this.report,
      this.reportDate,
      this.createdAt,
      this.updatedAt});

  UserReports.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    reportName = json['report_name'];
    report = json['report'];
    reportDate = json['report_date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['report_name'] = reportName;
    data['report'] = report;
    data['report_date'] = reportDate;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
