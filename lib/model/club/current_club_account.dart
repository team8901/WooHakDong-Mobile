class CurrentClubAccount {
  int? clubAccountId;
  String? clubAccountBankName;
  String? clubAccountNumber;
  String? clubAccountPinTechNumber;
  DateTime? clubAccountLastUpdateDate;
  String? clubAccountBankCode;
  int? clubAccountBalance;

  CurrentClubAccount({
    this.clubAccountId,
    this.clubAccountBankName,
    this.clubAccountNumber,
    this.clubAccountPinTechNumber,
    this.clubAccountLastUpdateDate,
    this.clubAccountBankCode,
    this.clubAccountBalance,
  });


  factory CurrentClubAccount.fromJson(Map<String, dynamic> json) {
    return CurrentClubAccount(
      clubAccountId: json['clubAccountId'],
      clubAccountBankName: json['clubAccountBankName'],
      clubAccountNumber: json['clubAccountNumber'],
      clubAccountPinTechNumber: json['clubAccountPinTechNumber'],
      clubAccountLastUpdateDate:
      json['clubAccountLastUpdateDate'] != null ? DateTime.parse(json['clubAccountLastUpdateDate']) : null,
      clubAccountBankCode: json['clubAccountBankCode'],
      clubAccountBalance: json['clubAccountBalance'],
    );
  }
}