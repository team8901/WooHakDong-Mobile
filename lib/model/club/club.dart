class Club {
  int? clubId;
  String? clubName;
  String? clubEnglishName;
  String? clubImage;
  String? clubDescription;
  String? clubRoom;
  String? clubGeneration;
  String? clubGroupChatLink;
  String? clubGroupChatPassword;
  int? clubDues;

  Club({
    this.clubId,
    this.clubName,
    this.clubEnglishName,
    this.clubImage,
    this.clubDescription,
    this.clubRoom,
    this.clubGeneration,
    this.clubGroupChatLink,
    this.clubGroupChatPassword,
    this.clubDues,
  });

  Club copyWith({
    int? clubId,
    String? clubName,
    String? clubEnglishName,
    String? clubImage,
    String? clubDescription,
    String? clubRoom,
    String? clubGeneration,
    String? clubGroupChatLink,
    String? clubGroupChatPassword,
    int? clubDues,
  }) {
    return Club(
      clubId: clubId ?? this.clubId,
      clubName: clubName ?? this.clubName,
      clubEnglishName: clubEnglishName ?? this.clubEnglishName,
      clubImage: clubImage ?? this.clubImage,
      clubDescription: clubDescription ?? this.clubDescription,
      clubRoom: clubRoom ?? this.clubRoom,
      clubGeneration: clubGeneration ?? this.clubGeneration,
      clubGroupChatLink: clubGroupChatLink ?? this.clubGroupChatLink,
      clubGroupChatPassword: clubGroupChatPassword ?? this.clubGroupChatPassword,
      clubDues: clubDues ?? this.clubDues,
    );
  }

  factory Club.fromJson(Map<String, dynamic> json) {
    return Club(
      clubId: json['clubId'],
      clubName: json['clubName'],
      clubEnglishName: json['clubEnglishName'],
      clubImage: json['clubImage'],
      clubDescription: json['clubDescription'],
      clubRoom: json['clubRoom'],
      clubGeneration: json['clubGeneration'],
      clubGroupChatLink: json['clubGroupChatLink'],
      clubGroupChatPassword: json['clubGroupChatPassword'],
      clubDues: json['clubDues'],
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
      'clubGroupChatLink': clubGroupChatLink,
      'clubGroupChatPassword': clubGroupChatPassword,
      'clubDues': clubDues,
    };
  }
}
