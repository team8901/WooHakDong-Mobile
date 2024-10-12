class ClubAccount {
  final String clubAccountBankName;
  final String clubAccountNumber;
  String? clubAccountPinTechNumber;

  ClubAccount({
    required this.clubAccountBankName,
    required this.clubAccountNumber,
    this.clubAccountPinTechNumber,
  });

  factory ClubAccount.fromJson(Map<String, dynamic> json) {
    return ClubAccount(
      clubAccountBankName: json['clubAccountBankName'],
      clubAccountNumber: json['clubAccountNumber'],
      clubAccountPinTechNumber: json['clubAccountPinTechNumber'],
    );
  }

  factory ClubAccount.fromMap(Map<String, dynamic> map) {
    return ClubAccount(
      clubAccountBankName: map['clubAccountBankName'],
      clubAccountNumber: map['clubAccountNumber'],
      clubAccountPinTechNumber: map['clubAccountPinTechNumber'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'clubAccountBankName': clubAccountBankName,
      'clubAccountNumber': clubAccountNumber,
    };
  }
}
