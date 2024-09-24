abstract class JsonModal {
  Map<String, dynamic> toJson();
}

abstract class Indexable extends JsonModal {
  late final String key;

  Indexable(this.key);

  operator [](index) => toJson()[index];

  @override
  bool operator ==(Object other) {
    return other is Indexable && other.key == key;
  }

  @override
  int get hashCode => key.hashCode;
}

class ResData<T extends dynamic> {
  T data;
  int count;

  ResData({required this.data, required this.count});

  factory ResData.fromJson(
    Map<String, dynamic> json, [
    T Function(dynamic data)? parseData,
  ]) {
    return ResData(
      data: parseData != null ? parseData(json['data']) : json['data'],
      count: json['count'],
    );
  }
}
