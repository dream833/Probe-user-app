class DoctorModel {
  int? id;
  String? firstName;
  String? lastName;
  int? department;
  String? phoneNo;
  String? gender;
  String? maritalStatus;
  int? bloodGroup;
  DateTime? dob;
  DateTime? joiningDate;
  String? workExperience;
  String? presentAddress;
  String? permanentAddress;
  String? biography;
  String? specialist;
  String? educationalQualification;
  String? image;
  String? attachments;
  int? status;
  String? email;
  String? checkupSlotPeriod;
  String? newPatientVisit;
  String? oldPatientVisit;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? zoneId;
  int? regionId;
  int? branchId;
  int? districtId;
  String? registrationNo;
  int? divisionId;
  int? thanaId;
  int? unionId;
  String? totalRatingLength;
  double? averageRating;

  DoctorModel({
    this.id,
    this.firstName,
    this.lastName,
    this.department,
    this.phoneNo,
    this.gender,
    this.maritalStatus,
    this.bloodGroup,
    this.dob,
    this.joiningDate,
    this.workExperience,
    this.presentAddress,
    this.permanentAddress,
    this.registrationNo,
    this.biography,
    this.specialist,
    this.educationalQualification,
    this.image,
    this.attachments,
    this.status,
    this.email,
    this.checkupSlotPeriod,
    this.newPatientVisit,
    this.oldPatientVisit,
    this.createdAt,
    this.updatedAt,
    this.zoneId,
    this.regionId,
    this.branchId,
    this.districtId,
    this.divisionId,
    this.thanaId,
    this.unionId,
    this.totalRatingLength,
    this.averageRating,
  });

  factory DoctorModel.fromJson(Map<String, dynamic> json) => DoctorModel(
      id: json["id"],
      firstName: json["first_name"],
      lastName: json["last_name"],
      department: json["department"],
      phoneNo: json["phone_no"],
      gender: json["gender"],
      registrationNo: json["registration_no"],
      maritalStatus: json["marital_status"],
      bloodGroup: json["blood_group"],
      dob: json["dob"] != null ? DateTime.parse(json["dob"]) : null,
      joiningDate: json["joining_date"] != null
          ? DateTime.parse(json["joining_date"])
          : null,
      workExperience: json["work_experience"],
      presentAddress: json["present_address"],
      permanentAddress: json["permanent_address"],
      biography: json["biography"],
      specialist: json["specialist"],
      educationalQualification: json["educational_qualification"],
      image: json["image"],
      attachments: json["attachments"],
      status: json["status"],
      email: json["email"],
      checkupSlotPeriod: json["checkup_slot_period"],
      newPatientVisit: json["new_patient_visit"],
      oldPatientVisit: json["old_patient_visit"],
      createdAt: json["created_at"] != null
          ? DateTime.parse(json["created_at"])
          : null,
      updatedAt: json["updated_at"] != null
          ? DateTime.parse(json["updated_at"])
          : null,
      zoneId: json["zone_id"],
      regionId: json["region_id"],
      branchId: json["branch_id"],
      districtId: json["district_id"],
      divisionId: json["division_id"],
      thanaId: json["thana_id"],
      unionId: json["union_id"],
      averageRating: json['averageRating'] ?? 0.0,
      totalRatingLength: json['totalRatingLength'] ?? '');

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "department": department,
        "phone_no": phoneNo,
        "gender": gender,
        "marital_status": maritalStatus,
        "blood_group": bloodGroup,
        "registration_no": registrationNo,
        "dob": dob != null
            ? "${dob!.year.toString().padLeft(4, '0')}-${dob!.month.toString().padLeft(2, '0')}-${dob!.day.toString().padLeft(2, '0')}"
            : null,
        "joining_date": joiningDate != null
            ? "${joiningDate!.year.toString().padLeft(4, '0')}-${joiningDate!.month.toString().padLeft(2, '0')}-${joiningDate!.day.toString().padLeft(2, '0')}"
            : null,
        "work_experience": workExperience,
        "present_address": presentAddress,
        "permanent_address": permanentAddress,
        "biography": biography,
        "specialist": specialist,
        "educational_qualification": educationalQualification,
        "image": image,
        "attachments": attachments,
        "status": status,
        "email": email,
        "checkup_slot_period": checkupSlotPeriod,
        "new_patient_visit": newPatientVisit,
        "old_patient_visit": oldPatientVisit,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "zone_id": zoneId,
        "region_id": regionId,
        "branch_id": branchId,
        "district_id": districtId,
        "division_id": divisionId,
        "thana_id": thanaId,
        "union_id": unionId,
      };
}
