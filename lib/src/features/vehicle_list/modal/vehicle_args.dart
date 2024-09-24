import '../../../widgets/atoms/image_picker_sheet.dart';

class VehicleListArgs {
  int page;
  VehicleStatusType vehicleStatusType;
  String? query;

  VehicleListArgs({
    required this.page,
    required this.vehicleStatusType,
    this.query,
  });

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'page': page,
      'vehicleStatusType': vehicleStatusType.name,
      'query': query,
    };
  }

  // fromJson constructor
  factory VehicleListArgs.fromJson(Map<String, dynamic> json) {
    return VehicleListArgs(
      page: json['page'],
      query: json['query'],
      vehicleStatusType: VehicleStatusType.values.firstWhere(
        (e) => e.name == json['vehicleStatusType'],
        orElse: () => VehicleStatusType.pending,
      ),
    );
  }

  // Override equality operator
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VehicleListArgs &&
          runtimeType == other.runtimeType &&
          page == other.page &&
          query == other.query &&
          vehicleStatusType == other.vehicleStatusType;

  // Override hashCode
  @override
  int get hashCode =>
      page.hashCode ^ vehicleStatusType.hashCode ^ query.hashCode;
}
