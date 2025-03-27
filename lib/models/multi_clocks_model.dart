class MultiClocksModel {
  DateTime cityTime;
  String cityName;

  MultiClocksModel({
    required this.cityTime,
    required this.cityName,
  });

  MultiClocksModel copyWith({
    DateTime? cityTime,
    String? cityName,
  }) {
    return MultiClocksModel(
      cityTime: cityTime ?? this.cityTime,
      cityName: cityName ?? this.cityName,
    );
  }

  factory MultiClocksModel.fromJson(Map<String, dynamic> json) {
    return MultiClocksModel(
      cityTime: json['cityTime'] as DateTime,
      cityName: json['cityName'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cityTime': cityTime,
      'cityName': cityName,
    };
  }
}
