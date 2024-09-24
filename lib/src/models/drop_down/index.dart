import '../json_modal.dart';

List<DropDownList> dropDownFromJson(dynamic data) => List<DropDownList>.from(
      // ignore: avoid_dynamic_calls
      data.map(
        (res) => DropDownList.fromJson({
          // ignore: avoid_dynamic_calls
          "value": res["id"],
          // ignore: avoid_dynamic_calls
          "label": res["shop_name"],
        }),
      ),
    );

class DropDownList<T> extends Indexable {
  DropDownList({
    required this.value,
    required this.label,
  }) : super(label);

  T value;
  String label;

  factory DropDownList.fromJson(Map<String, dynamic> json) => DropDownList(
        value: json['value'] as T,
        label: json['label'] as String,
      );

  factory DropDownList.fronZone(Map<String, dynamic> json) {
    return DropDownList(
      value: json['code'] as T,
      label: json['name'] as String,
    );
  }
  factory DropDownList.fromVehicleSymbol(Map<String, dynamic> json) =>
      DropDownList(
        value: json['name'] as T,
        label: json['name'] as String,
      );
  @override
  Map<String, dynamic> toJson() => {
        "value": value,
        "label": label,
      };
}
