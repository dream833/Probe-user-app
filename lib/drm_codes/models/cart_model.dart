import 'dart:convert';

class Cartmodel {
  String? message;
  Prescriptions? prescriptions;

  Cartmodel({
    this.message,
    this.prescriptions,
  });

  factory Cartmodel.fromRawJson(String str) =>
      Cartmodel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Cartmodel.fromJson(Map<String, dynamic> json) => Cartmodel(
        message: json["message"],
        prescriptions: json["prescriptions"] == null
            ? null
            : Prescriptions.fromJson(json["prescriptions"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "prescriptions": prescriptions?.toJson(),
      };
}

class Prescriptions {
  int? id;
  int? patientId;
  dynamic patientName;
  dynamic name;
  String? price;
  dynamic sample;
  int? homeCollection;
  dynamic method;
  dynamic timeframe;
  dynamic comments;
  dynamic preparation;
  DateTime? testDate;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? status;
  List<DiagnosticTest>? diagnosticTests;
  List<dynamic>? diagnosticPackages;
  List<DiagnosticProfile>? diagnosticProfiles;

  Prescriptions({
    this.id,
    this.patientId,
    this.patientName,
    this.name,
    this.price,
    this.sample,
    this.homeCollection,
    this.method,
    this.timeframe,
    this.comments,
    this.preparation,
    this.testDate,
    this.createdAt,
    this.updatedAt,
    this.status,
    this.diagnosticTests,
    this.diagnosticPackages,
    this.diagnosticProfiles,
  });

  factory Prescriptions.fromRawJson(String str) =>
      Prescriptions.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Prescriptions.fromJson(Map<String, dynamic> json) => Prescriptions(
        id: json["id"],
        patientId: json["patient_id"],
        patientName: json["patient_name"],
        name: json["name"],
        price: json["price"],
        sample: json["sample"],
        homeCollection: json["homeCollection"],
        method: json["method"],
        timeframe: json["timeframe"],
        comments: json["comments"],
        preparation: json["preparation"],
        testDate: json["test_date"] == null
            ? null
            : DateTime.parse(json["test_date"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        status: json["status"],
        diagnosticTests: json["diagnostic_tests"] == null
            ? []
            : List<DiagnosticTest>.from(json["diagnostic_tests"]!
                .map((x) => DiagnosticTest.fromJson(x))),
        diagnosticPackages: json["diagnostic_packages"] == null
            ? []
            : List<dynamic>.from(json["diagnostic_packages"]!.map((x) => x)),
        diagnosticProfiles: json["diagnostic_profiles"] == null
            ? []
            : List<DiagnosticProfile>.from(json["diagnostic_profiles"]!
                .map((x) => DiagnosticProfile.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "patient_id": patientId,
        "patient_name": patientName,
        "name": name,
        "price": price,
        "sample": sample,
        "homeCollection": homeCollection,
        "method": method,
        "timeframe": timeframe,
        "comments": comments,
        "preparation": preparation,
        "test_date":
            "${testDate!.year.toString().padLeft(4, '0')}-${testDate!.month.toString().padLeft(2, '0')}-${testDate!.day.toString().padLeft(2, '0')}",
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "status": status,
        "diagnostic_tests": diagnosticTests == null
            ? []
            : List<dynamic>.from(diagnosticTests!.map((x) => x.toJson())),
        "diagnostic_packages": diagnosticPackages == null
            ? []
            : List<dynamic>.from(diagnosticPackages!.map((x) => x)),
        "diagnostic_profiles": diagnosticProfiles == null
            ? []
            : List<dynamic>.from(diagnosticProfiles!.map((x) => x.toJson())),
      };
}

class DiagnosticProfile {
  int? id;
  String? name;
  String? description;
  String? code;
  int? rate;
  String? tests;
  String? comments;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  int? minimumReportnumber;
  String? timeframe;
  String? sample;
  String? preparation;
  int? homeCollection;
  DiagnosticProfilePivot? pivot;

  DiagnosticProfile({
    this.id,
    this.name,
    this.description,
    this.code,
    this.rate,
    this.tests,
    this.comments,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.minimumReportnumber,
    this.timeframe,
    this.sample,
    this.preparation,
    this.homeCollection,
    this.pivot,
  });

  factory DiagnosticProfile.fromRawJson(String str) =>
      DiagnosticProfile.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DiagnosticProfile.fromJson(Map<String, dynamic> json) =>
      DiagnosticProfile(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        code: json["code"],
        rate: json["rate"],
        tests: json["tests"],
        comments: json["comments"],
        status: json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        minimumReportnumber: json["minimumReportnumber"],
        timeframe: json["timeframe"],
        sample: json["sample"],
        preparation: json["preparation"],
        homeCollection: json["homeCollection"],
        pivot: json["pivot"] == null
            ? null
            : DiagnosticProfilePivot.fromJson(json["pivot"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "code": code,
        "rate": rate,
        "tests": tests,
        "comments": comments,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
        "minimumReportnumber": minimumReportnumber,
        "timeframe": timeframe,
        "sample": sample,
        "preparation": preparation,
        "homeCollection": homeCollection,
        "pivot": pivot?.toJson(),
      };
}

class DiagnosticProfilePivot {
  int? appuserTestBookingId;
  int? diagnosticProfileId;
  DateTime? createdAt;

  DiagnosticProfilePivot({
    this.appuserTestBookingId,
    this.diagnosticProfileId,
    this.createdAt,
  });

  factory DiagnosticProfilePivot.fromRawJson(String str) =>
      DiagnosticProfilePivot.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DiagnosticProfilePivot.fromJson(Map<String, dynamic> json) =>
      DiagnosticProfilePivot(
        appuserTestBookingId: json["appuser_test_booking_id"],
        diagnosticProfileId: json["diagnostic_profile_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "appuser_test_booking_id": appuserTestBookingId,
        "diagnostic_profile_id": diagnosticProfileId,
        "created_at": createdAt?.toIso8601String(),
      };
}

class DiagnosticTest {
  int? id;
  String? name;
  String? method;
  String? code;
  String? unit;
  int? rate;
  String? normalRange;
  String? comments;
  int? diagnosticDepartmentId;
  String? specimen;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  dynamic minimumReportnumber;
  dynamic timeframe;
  dynamic sample;
  dynamic preparation;
  int? homeCollection;
  DiagnosticTestPivot? pivot;

  DiagnosticTest({
    this.id,
    this.name,
    this.method,
    this.code,
    this.unit,
    this.rate,
    this.normalRange,
    this.comments,
    this.diagnosticDepartmentId,
    this.specimen,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.minimumReportnumber,
    this.timeframe,
    this.sample,
    this.preparation,
    this.homeCollection,
    this.pivot,
  });

  factory DiagnosticTest.fromRawJson(String str) =>
      DiagnosticTest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DiagnosticTest.fromJson(Map<String, dynamic> json) => DiagnosticTest(
        id: json["id"],
        name: json["name"],
        method: json["method"],
        code: json["code"],
        unit: json["unit"],
        rate: json["rate"],
        normalRange: json["normal_range"],
        comments: json["comments"],
        diagnosticDepartmentId: json["diagnostic_department_id"],
        specimen: json["specimen"],
        status: json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        minimumReportnumber: json["minimumReportnumber"],
        timeframe: json["timeframe"],
        sample: json["sample"],
        preparation: json["preparation"],
        homeCollection: json["homeCollection"],
        pivot: json["pivot"] == null
            ? null
            : DiagnosticTestPivot.fromJson(json["pivot"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "method": method,
        "code": code,
        "unit": unit,
        "rate": rate,
        "normal_range": normalRange,
        "comments": comments,
        "diagnostic_department_id": diagnosticDepartmentId,
        "specimen": specimen,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
        "minimumReportnumber": minimumReportnumber,
        "timeframe": timeframe,
        "sample": sample,
        "preparation": preparation,
        "homeCollection": homeCollection,
        "pivot": pivot?.toJson(),
      };
}

class DiagnosticTestPivot {
  int? appuserTestBookingId;
  int? diagnosticTestId;
  DateTime? createdAt;

  DiagnosticTestPivot({
    this.appuserTestBookingId,
    this.diagnosticTestId,
    this.createdAt,
  });

  factory DiagnosticTestPivot.fromRawJson(String str) =>
      DiagnosticTestPivot.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DiagnosticTestPivot.fromJson(Map<String, dynamic> json) =>
      DiagnosticTestPivot(
        appuserTestBookingId: json["appuser_test_booking_id"],
        diagnosticTestId: json["diagnostic_test_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "appuser_test_booking_id": appuserTestBookingId,
        "diagnostic_test_id": diagnosticTestId,
        "created_at": createdAt?.toIso8601String(),
      };
}
