class ClubMember {
  final int? memberId;
  final String? memberName;
  final String? memberPhoneNumber;
  final String? memberEmail;
  final String? memberSchool;
  final String? memberGender;
  final String? memberMajor;
  final String? memberStudentNumber;
  final String? clubMemberRole;
  final String? clubJoinedDate;
  final String? clubMemberAssignedTerm;

  ClubMember({
    this.memberId,
    this.memberName,
    this.memberPhoneNumber,
    this.memberEmail,
    this.memberSchool,
    this.memberGender,
    this.memberMajor,
    this.memberStudentNumber,
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
      memberSchool: json['memberSchool'] as String?,
      memberGender: json['memberGender'] as String?,
      memberMajor: json['memberMajor'] as String?,
      memberStudentNumber: json['memberStudentNumber'] as String?,
      clubMemberRole: json['clubMemberRole'] as String?,
      clubJoinedDate: json['clubJoinedDate'] as String?,
      clubMemberAssignedTerm: json['clubMemberAssignedTerm'] as String?,
    );
  }
}
