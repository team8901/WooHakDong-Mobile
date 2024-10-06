class Member {
  String memberName;
  String memberPhoneNumber;
  String memberEmail;
  String memberMajor;
  String memberStudentNumber;
  String memberGender;

  Member({
    required this.memberName,
    required this.memberPhoneNumber,
    required this.memberEmail,
    required this.memberMajor,
    required this.memberStudentNumber,
    required this.memberGender,
  });

  Map<String, dynamic> toJson() {
    return {
      'memberName': memberName,
      'memberPhoneNumber': memberPhoneNumber,
      'memberEmail': memberEmail,
      'memberMajor': memberMajor,
      'memberStudentNumber': memberStudentNumber,
      'memberGender': memberGender,
    };
  }
}
