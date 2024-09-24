import '../../../models/params/index.dart';

class OnboardingParams extends Params {
  String? zone;
  String? province;
  final int lotNo;
  final String vehicleSymbol;
  final int vehicleNumber;
  final String type;
  String? officeCode;

  OnboardingParams({
    this.officeCode,
    this.zone,
    this.province,
    required this.lotNo,
    required this.vehicleSymbol,
    required this.vehicleNumber,
    required this.type,
  });

  @override
  Params clone() {
    return OnboardingParams(
      zone: zone,
      lotNo: lotNo,
      vehicleNumber: vehicleNumber,
      vehicleSymbol: vehicleSymbol,
      type: type,
      province: province,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (zone == null) {
      data['province'] = province;
      data["office_code"] = officeCode;
    } else {
      data['zone'] = zone;
    }
    data["lot_no"] = lotNo;
    data["vehicle_symbol"] = vehicleSymbol;
    data["vehicle_no"] = vehicleNumber;
    data["type"] = type;
    return data;
  }
}
