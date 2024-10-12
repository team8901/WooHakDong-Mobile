class Club {
  int? clubId;
  String? clubName;
  String? clubEnglishName;
  String? clubImage;
  String? clubDescription;
  String? clubRoom;
  String? clubGeneration;
  int? clubDues;

  Club({
    this.clubId,
    this.clubName,
    this.clubEnglishName,
    this.clubImage,
    this.clubDescription,
    this.clubRoom,
    this.clubGeneration,
    this.clubDues,
  });

  factory Club.fromJson(Map<String, dynamic> json) {
    return Club(
      clubId: json['clubId'],
      clubName: json['clubName'],
      clubEnglishName: json['clubEnglishName'],
      clubImage: json['clubImage'],
      clubDescription: json['clubDescription'],
      clubRoom: json['clubRoom'],
      clubGeneration: json['clubGeneration'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'clubName': clubName,
      'clubEnglishName': clubEnglishName,
      'clubImage': clubImage,
      'clubDescription': clubDescription,
      'clubRoom': clubRoom,
      'clubGeneration': clubGeneration,
      'clubDues': clubDues,
    };
  }
}
