class ClubMemberTerm {
  final DateTime? clubHistoryUsageDate;

  ClubMemberTerm({
    this.clubHistoryUsageDate,
  });

  factory ClubMemberTerm.fromJson(Map<String, dynamic> json) {
    return ClubMemberTerm(
      clubHistoryUsageDate: json['clubHistoryUsageDate'] != null ? DateTime.parse(json['clubHistoryUsageDate']) : null,
    );
  }
}
