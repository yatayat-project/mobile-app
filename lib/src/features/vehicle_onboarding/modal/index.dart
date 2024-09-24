import 'dart:convert';

import '../../../models/drop_down/index.dart';

// Main class to hold the entire response
class VehicleCategoryResponse {
  final bool status;
  final String message;
  final List<DropDownList> zoneData;
  final List<DropDownList> provinceData;
  final List<DropDownList> vehicleSymbol;
  final List<DropDownList> type;

  VehicleCategoryResponse({
    required this.status,
    required this.message,
    required this.zoneData,
    required this.provinceData,
    required this.vehicleSymbol,
    required this.type,
  });

  factory VehicleCategoryResponse.fromJson(Map<String, dynamic> json) {
    return VehicleCategoryResponse(
      status: json['status'],
      message: json['message'],
      zoneData: [DropDownList.fronZone(json['zoneData'])],
      provinceData: [DropDownList.fronZone(json['provinceData'])],
      vehicleSymbol: (json['vehicleSymbol'] as List)
          .map((e) => DropDownList.fromVehicleSymbol(e))
          .toList(),
      type: (json['Type'] as List<dynamic>)
          .map(
            (e) => DropDownList(
              value: e,
              label: e.toString()[0].toUpperCase() + e.toString().substring(1),
            ),
          )
          .toList(),
    );
  }
}

// Zone Data class
class ZoneData {
  final int id;
  final String name;
  final String code;
  final int? provinceId;
  final String? deletedAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  ZoneData({
    required this.id,
    required this.name,
    required this.code,
    this.provinceId,
    this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  // Factory constructor for creating a new ZoneData instance from a map
  factory ZoneData.fromJson(Map<String, dynamic> json) {
    return ZoneData(
      id: json['id'],
      name: json['name'],
      code: json['code'],
      provinceId: json['province_id'],
      deletedAt: json['deleted_at'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}

// Province Data class
class ProvinceData {
  final int id;
  final String name;
  final String code;
  final String? deletedAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  ProvinceData({
    required this.id,
    required this.name,
    required this.code,
    this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  // Factory constructor for creating a new ProvinceData instance from a map
  factory ProvinceData.fromJson(Map<String, dynamic> json) {
    return ProvinceData(
      id: json['id'],
      name: json['name'],
      code: json['code'],
      deletedAt: json['deleted_at'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}

// Vehicle Symbol class
class VehicleSymbol {
  final int id;
  final String name;
  final String? deletedAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  VehicleSymbol({
    required this.id,
    required this.name,
    this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  // Factory constructor for creating a new VehicleSymbol instance from a map
  factory VehicleSymbol.fromJson(Map<String, dynamic> json) {
    return VehicleSymbol(
      id: json['id'],
      name: json['name'],
      deletedAt: json['deleted_at'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}

// Function to parse JSON string into VehicleCategoryResponse
VehicleCategoryResponse parseVehicleCategoryResponse(String jsonString) {
  final Map<String, dynamic> jsonData = json.decode(jsonString);
  return VehicleCategoryResponse.fromJson(jsonData);
}
