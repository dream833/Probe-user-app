// To parse this JSON data, do
//
//     final zoneModel = zoneModelFromJson(jsonString);

import 'dart:convert';

List<ZoneModel> zoneModelFromJson(String str) =>
    List<ZoneModel>.from(json.decode(str).map((x) => ZoneModel.fromJson(x)));

String zoneModelToJson(List<ZoneModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ZoneModel {
  int? id;
  String? name;
  int? zoneCode;
  dynamic createdAt;
  DateTime? updatedAt;

  ZoneModel({
    this.id,
    this.name,
    this.zoneCode,
    this.createdAt,
    this.updatedAt,
  });

  factory ZoneModel.fromJson(Map<String, dynamic> json) => ZoneModel(
        id: json["id"],
        name: json["name"],
        zoneCode: json["zone_code"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "zone_code": zoneCode,
        "created_at": createdAt,
        "updated_at": updatedAt?.toIso8601String(),
      };
}

enum CreatedAtEnum { THE_0000011130_T00_0000000000_Z }

final createdAtEnumValues = EnumValues({
  "-000001-11-30T00:00:00.000000Z":
      CreatedAtEnum.THE_0000011130_T00_0000000000_Z
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
