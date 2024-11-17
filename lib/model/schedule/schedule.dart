class Schedule {
  int? scheduleId;
  String? scheduleTitle;
  String? scheduleContent;
  DateTime? scheduleDateTime;
  String? scheduleColor;

  Schedule({
    this.scheduleId,
    this.scheduleTitle,
    this.scheduleContent,
    this.scheduleDateTime,
    this.scheduleColor,
  });

  Schedule copyWith({
    String? scheduleTitle,
    String? scheduleContent,
    DateTime? scheduleDateTime,
    String? scheduleColor,
  }) {
    return Schedule(
      scheduleTitle: scheduleTitle ?? this.scheduleTitle,
      scheduleContent: scheduleContent ?? this.scheduleContent,
      scheduleDateTime: scheduleDateTime ?? this.scheduleDateTime,
      scheduleColor: scheduleColor ?? this.scheduleColor,
    );
  }

  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      scheduleId: json['scheduleId'],
      scheduleTitle: json['scheduleTitle'],
      scheduleContent: json['scheduleContent'],
      scheduleDateTime: json['scheduleDateTime'] != null ? DateTime.parse(json['scheduleDateTime']) : null,
      scheduleColor: json['scheduleColor'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'scheduleTitle': scheduleTitle,
      'scheduleContent': scheduleContent,
      'scheduleDateTime': scheduleDateTime?.toIso8601String(),
      'scheduleColor': scheduleColor,
    };
  }
}
