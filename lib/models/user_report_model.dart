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
      familyMemberId: json['family_member_id']??0,
      name: json['name'],
      file: json['file'],
      date: json['date'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
