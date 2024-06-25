import 'dart:convert';

class LabTestModels {
  String? message;
  List<DiagnosticTestName>? diagnosticTestNames;
  List<DiagnosticPeName>? diagnosticProfileNames;
  List<DiagnosticPeName>? diagnosticPackageNames;

  LabTestModels({
    this.message,
    this.diagnosticTestNames,
    this.diagnosticProfileNames,
    this.diagnosticPackageNames,
  });

  factory LabTestModels.fromRawJson(String str) =>
      LabTestModels.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LabTestModels.fromJson(Map<String, dynamic> json) => LabTestModels(
        message: json["message"],
        diagnosticTestNames: json["diagnosticTestNames"] == null
            ? []
            : List<DiagnosticTestName>.from(json["diagnosticTestNames"]!
                .map((x) => DiagnosticTestName.fromJson(x))),
        diagnosticProfileNames: json["diagnosticProfileNames"] == null
            ? []
            : List<DiagnosticPeName>.from(json["diagnosticProfileNames"]!
                .map((x) => DiagnosticPeName.fromJson(x))),
        diagnosticPackageNames: json["diagnosticPackageNames"] == null
            ? []
            : List<DiagnosticPeName>.from(json["diagnosticPackageNames"]!
                .map((x) => DiagnosticPeName.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "diagnosticTestNames": diagnosticTestNames == null
            ? []
            : List<dynamic>.from(diagnosticTestNames!.map((x) => x.toJson())),
        "diagnosticProfileNames": diagnosticProfileNames == null
            ? []
            : List<dynamic>.from(
                diagnosticProfileNames!.map((x) => x.toJson())),
        "diagnosticPackageNames": diagnosticPackageNames == null
            ? []
            : List<dynamic>.from(
                diagnosticPackageNames!.map((x) => x.toJson())),
      };
}

class DiagnosticPeName {
  int? id;
  String? name;
  String? code;
  int? rate;
  String? profiles;
  String? tests;
  int? duration;
  String? comments;
  String? description;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  int? minimumReportnumber;
  String? timeframe;
  String? sample;
  String? preparation;
  int? homeCollection;

  DiagnosticPeName({
    this.id,
    this.name,
    this.code,
    this.rate,
    this.profiles,
    this.tests,
    this.duration,
    this.comments,
    this.description,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.minimumReportnumber,
    this.timeframe,
    this.sample,
    this.preparation,
    this.homeCollection,
  });

  factory DiagnosticPeName.fromRawJson(String str) =>
      DiagnosticPeName.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DiagnosticPeName.fromJson(Map<String, dynamic> json) =>
      DiagnosticPeName(
        id: json["id"],
        name: json["name"],
        code: json["code"],
        rate: json["rate"],
        profiles: json["profiles"],
        tests: json["tests"],
        duration: json["duration"],
        comments: json["comments"],
        description: json["description"],
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
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "code": code,
        "rate": rate,
        "profiles": profiles,
        "tests": tests,
        "duration": duration,
        "comments": comments,
        "description": description,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
        "minimumReportnumber": minimumReportnumber,
        "timeframe": timeframe,
        "sample": sample,
        "preparation": preparation,
        "homeCollection": homeCollection,
      };
}

class DiagnosticTestName {
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

  DiagnosticTestName({
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
  });

  factory DiagnosticTestName.fromRawJson(String str) =>
      DiagnosticTestName.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DiagnosticTestName.fromJson(Map<String, dynamic> json) =>
      DiagnosticTestName(
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
      };
}
