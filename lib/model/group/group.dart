class Group {
  int? groupId;
  String? groupName;
  String? groupJoinLink;
  String? groupChatLink;
  String? groupChatPassword;
  String? groupDescription;
  int? groupAmount;
  bool? groupIsActivated;
  int? groupMemberLimit;
  int? groupMemberCount;

  Group({
    this.groupId,
    this.groupName,
    this.groupJoinLink,
    this.groupChatLink,
    this.groupChatPassword,
    this.groupDescription,
    this.groupAmount,
    this.groupIsActivated,
    this.groupMemberLimit,
    this.groupMemberCount,
  });

  Group copyWith({
    String? groupName,
    String? groupDescription,
    String? groupChatLink,
    String? groupChatPassword,
    bool? groupIsActivated,
    int? groupMemberLimit,
  }) {
    return Group(
      groupName: groupName ?? this.groupName,
      groupDescription: groupDescription ?? this.groupDescription,
      groupChatLink: groupChatLink ?? this.groupChatLink,
      groupChatPassword: groupChatPassword ?? this.groupChatPassword,
      groupIsActivated: groupIsActivated ?? this.groupIsActivated,
      groupMemberLimit: groupMemberLimit ?? this.groupMemberLimit,
    );
  }

  factory Group.fromJsonForPromotion(Map<String, dynamic> json) {
    return Group(
      groupId: json['groupId'],
      groupName: json['groupName'],
      groupJoinLink: json['groupJoinLink'],
      groupDescription: json['groupDescription'],
      groupAmount: json['groupAmount'],
    );
  }

  factory Group.fromJson(Map<String, dynamic> json) {
    return Group(
      groupId: json['groupId'],
      groupName: json['groupName'],
      groupJoinLink: json['groupJoinLink'],
      groupDescription: json['groupDescription'],
      groupAmount: json['groupAmount'],
      groupChatLink: json['groupChatLink'],
      groupChatPassword: json['groupChatPassword'],
      groupIsActivated: json['groupIsActivated'],
      groupMemberLimit: json['groupMemberLimit'],
      groupMemberCount: json['groupMemberCount'],
    );
  }

  Map<String, dynamic> toJsonForAdd() {
    return {
      'groupName': groupName,
      'groupDescription': groupDescription,
      'groupAmount': groupAmount,
      'groupChatLink': groupChatLink,
      'groupChatPassword': groupChatPassword,
      'groupMemberLimit': groupMemberLimit,
    };
  }

  Map<String, dynamic> toJsonForUpdate() {
    return {
      'groupName': groupName,
      'groupDescription': groupDescription,
      'groupChatLink': groupChatLink,
      'groupChatPassword': groupChatPassword,
      'groupIsActivated': groupIsActivated,
      'groupMemberLimit': groupMemberLimit,
    };
  }
}
