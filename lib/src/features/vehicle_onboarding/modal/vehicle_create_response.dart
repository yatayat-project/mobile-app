// Main class
class VehicleCreationResponse {
  final bool status;
  final String message;
  final VehicleData data;

  VehicleCreationResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  // Factory constructor for creating an instance from a JSON map
  factory VehicleCreationResponse.fromJson(Map<String, dynamic> json) {
    return VehicleCreationResponse(
      status: json['status'] as bool,
      message: json['message'] as String,
      data: VehicleData.fromJson(json['data'] as Map<String, dynamic>),
    );
  }

  // Convert the instance back to JSON map
  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data.toJson(),
    };
  }
}

// Nested class for the 'data' field
class VehicleData {
  final String type;
  final String? zone;
  final String? province;
  final String vehicleUuid;
  final int vehicleNo;
  final int lotNo;
  final String? officeCode;
  final String vehicleSymbol;
  final int isEmboss;
  final String? embossNo;
  final int addedBy;
  final DateTime updatedAt;
  final DateTime createdAt;
  final int id;

  VehicleData({
    required this.type,
    required this.zone,
    this.province,
    required this.vehicleUuid,
    required this.vehicleNo,
    required this.lotNo,
    this.officeCode,
    required this.vehicleSymbol,
    required this.isEmboss,
    this.embossNo,
    required this.addedBy,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  // Factory constructor for creating an instance from a JSON map
  factory VehicleData.fromJson(Map<String, dynamic> json) {
    return VehicleData(
      type: json['type'],
      zone: json['zone'],
      province: json['province'] as String?,
      vehicleUuid: json['vehicle_uuid'] as String,
      vehicleNo: json['vehicle_no'] as int,
      lotNo: json['lot_no'] as int,
      officeCode: json['office_code'] as String?,
      vehicleSymbol: json['vehicle_symbol'] as String,
      isEmboss: json['is_emboss'] as int,
      embossNo: json['emboss_no'] as String?,
      addedBy: json['added_by'] as int,
      updatedAt: DateTime.parse(json['updated_at'] as String),
      createdAt: DateTime.parse(json['created_at'] as String),
      id: json['id'] as int,
    );
  }

  // Convert the instance back to JSON map
  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'zone': zone,
      'province': province,
      'vehicle_uuid': vehicleUuid,
      'vehicle_no': vehicleNo,
      'lot_no': lotNo,
      'office_code': officeCode,
      'vehicle_symbol': vehicleSymbol,
      'is_emboss': isEmboss,
      'emboss_no': embossNo,
      'added_by': addedBy,
      'updated_at': updatedAt.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
      'id': id,
    };
  }
}
