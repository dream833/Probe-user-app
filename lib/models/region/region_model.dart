// To parse this JSON data, do
//
//     final regionModel = regionModelFromJson(jsonString);

// ignore_for_file: constant_identifier_names

import 'dart:convert';

RegionModel regionModelFromJson(String str) =>
    RegionModel.fromJson(json.decode(str));

String regionModelToJson(RegionModel data) => json.encode(data.toJson());

class RegionModel {
  int? id;
  String? name;
  int? zoneCode;
  AtedAt? createdAt;
  DateTime? updatedAt;
  List<Region>? regions;

  RegionModel({
    this.id,
    this.name,
    this.zoneCode,
    this.createdAt,
    this.updatedAt,
    this.regions,
  });

  factory RegionModel.fromJson(Map<String, dynamic> json) => RegionModel(
        id: json["id"],
        name: json["name"],
        zoneCode: json["zone_code"],
        createdAt: atedAtValues.map[json["created_at"]],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        regions: json["regions"] == null
            ? []
            : List<Region>.from(json["regions"].map((x) => Region.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "zone_code": zoneCode,
        "created_at": atedAtValues.reverse[createdAt],
        "updated_at": updatedAt?.toIso8601String(),
        "regions": regions == null
            ? []
            : List<dynamic>.from(regions!.map((x) => x.toJson())),
      };
}

enum AtedAt { THE_0000011130_T00_0000000000_Z }

final atedAtValues = EnumValues(
    {"-000001-11-30T00:00:00.000000Z": AtedAt.THE_0000011130_T00_0000000000_Z});

class Region {
  int? id;
  String? regionName;
  int? regionCode;
  int? zoneId;
  AtedAt? createdAt;
  AtedAt? updatedAt;

  Region({
    this.id,
    this.regionName,
    this.regionCode,
    this.zoneId,
    this.createdAt,
    this.updatedAt,
  });

  factory Region.fromJson(Map<String, dynamic> json) => Region(
        id: json["id"],
        regionName: json["region_name"],
        regionCode: json["region_code"],
        zoneId: json["zone_id"],
        createdAt: atedAtValues.map[json["created_at"]],
        updatedAt: atedAtValues.map[json["updated_at"]],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "region_name": regionName,
        "region_code": regionCode,
        "zone_id": zoneId,
        "created_at": atedAtValues.reverse[createdAt],
        "updated_at": atedAtValues.reverse[updatedAt],
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
