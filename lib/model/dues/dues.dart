class Dues {
  final int? clubAccountHistoryId;
  final String? clubAccountHistoryInOutType;
  final DateTime? clubAccountHistoryTranDate;
  final int? clubAccountHistoryBalanceAmount;
  final int? clubAccountHistoryTranAmount;
  final String? clubAccountHistoryContent;

  Dues({
    this.clubAccountHistoryId,
    this.clubAccountHistoryInOutType,
    this.clubAccountHistoryTranDate,
    this.clubAccountHistoryBalanceAmount,
    this.clubAccountHistoryTranAmount,
    this.clubAccountHistoryContent,
  });

  factory Dues.fromJson(Map<String, dynamic> json) {
    return Dues(
      clubAccountHistoryId: json['clubAccountHistoryId'],
      clubAccountHistoryInOutType: json['clubAccountHistoryInOutType'],
      clubAccountHistoryTranDate: json['clubAccountHistoryTranDate'] != null
          ? DateTime.parse(json['clubAccountHistoryTranDate'])
          : null,
      clubAccountHistoryBalanceAmount: json['clubAccountHistoryBalanceAmount'],
      clubAccountHistoryTranAmount: json['clubAccountHistoryTranAmount'],
      clubAccountHistoryContent: json['clubAccountHistoryContent'],
    );
  }
}
