class ClubMember {
  final int? memberId;
  final String? memberName;
  final String? memberPhoneNumber;
  final String? memberEmail;
  final String? memberGender;
  final String? memberMajor;
  final String? memberStudentNumber;
  final int? clubMemberId;
  final String? clubMemberRole;
  final DateTime? clubJoinedDate;
  final DateTime? clubMemberAssignedTerm;

  ClubMember({
    this.memberId,
    this.memberName,
    this.memberPhoneNumber,
    this.memberEmail,
    this.memberGender,
    this.memberMajor,
    this.memberStudentNumber,
    this.clubMemberId,
    this.clubMemberRole,
    this.clubJoinedDate,
    this.clubMemberAssignedTerm,
  });

  factory ClubMember.fromJson(Map<String, dynamic> json) {
    return ClubMember(
      memberId: json['memberId'] as int?,
      memberName: json['memberName'] as String?,
      memberPhoneNumber: json['memberPhoneNumber'] as String?,
      memberEmail: json['memberEmail'] as String?,
      memberGender: json['memberGender'] as String?,
      memberMajor: json['memberMajor'] as String?,
      memberStudentNumber: json['memberStudentNumber'] as String?,
      clubMemberId: json['clubMemberId'] as int?,
      clubMemberRole: json['clubMemberRole'] as String?,
      clubJoinedDate: json['clubJoinedDate'] != null ? DateTime.parse(json['clubJoinedDate']) : null,
      clubMemberAssignedTerm:
          json['clubMemberAssignedTerm'] != null ? DateTime.parse(json['clubMemberAssignedTerm']) : null,
    );
  }
}
