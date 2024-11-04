class Group {
  int? groupId;
  String? groupName;
  String? groupJoinLink;
  String? groupDescription;
  int? groupAmount;

  Group({
    this.groupId,
    this.groupName,
    this.groupJoinLink,
    this.groupDescription,
    this.groupAmount,
  });

  factory Group.fromJson(Map<String, dynamic> json) {
    return Group(
      groupId: json['groupId'],
      groupName: json['groupName'],
      groupJoinLink: json['groupJoinLink'],
      groupDescription: json['groupDescription'],
      groupAmount: json['groupAmount'],
    );
  }
}
