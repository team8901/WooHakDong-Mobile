class Member {
  String email;
  String name;
  String gender;
  String department;
  String studentId;
  String phoneNumber;

  Member({
    required this.email,
    required this.name,
    required this.gender,
    required this.department,
    required this.studentId,
    required this.phoneNumber,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'name': name,
      'gender': gender,
      'department': department,
      'studentId': studentId,
      'phoneNumber': phoneNumber,
    };
  }
}
