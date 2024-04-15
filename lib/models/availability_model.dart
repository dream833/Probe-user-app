class AvailabilityModel {
  int? id;
  String? startTime;
  String? endTime;
  String? day;
  String? type;
  int? maxPatients;
  String? location;
  String? phone;
  int? price;
  String? address;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? doctorId;
  String? slotDate;

  AvailabilityModel({
    this.id,
    this.startTime,
    this.endTime,
    this.day,
    this.type,
    this.price,
    this.maxPatients,
    this.location,
    this.phone,
    this.address,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.doctorId,
    this.slotDate,
  });

  factory AvailabilityModel.fromJson(Map<String, dynamic> json) =>
      AvailabilityModel(
          id: json["id"] ?? 1,
          startTime: json["start_time"],
          endTime: json["end_time"],
          day: json["day"],
          type: json["type"],
          maxPatients: json["max_patients"],
          location: json["location"],
          price: json["price"],
          phone: json["phone"],
          address: json["address"],
          status: json["status"],
          createdAt: json["created_at"] == null
              ? null
              : DateTime.parse(json["created_at"]),
          updatedAt: json["updated_at"] == null
              ? null
              : DateTime.parse(json["updated_at"]),
          doctorId: json["doctor_id"],
          slotDate: json['slot_date']);

  Map<String, dynamic> toJson() => {
        "id": id,
        "start_time": startTime,
        "end_time": endTime,
        "day": day,
        "type": 'online',
        "max_patients": maxPatients,
        "location": location,
        "price": price,
        "phone": phone,
        "address": address,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "doctor_id": doctorId,
        "slot_date": slotDate
      };
}
