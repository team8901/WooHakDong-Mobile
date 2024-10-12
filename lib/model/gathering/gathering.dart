class Gathering {
  final int gatheringId;
  final String gatheringName;
  final String gatheringLink;
  final String gatheringDescription;
  final String gatheringAmount;

  Gathering({
    required this.gatheringId,
    required this.gatheringName,
    required this.gatheringLink,
    required this.gatheringDescription,
    required this.gatheringAmount,
  });

  factory Gathering.fromJson(Map<String, dynamic> json) {
    return Gathering(
      gatheringId: json['gatheringId'],
      gatheringName: json['gatheringName'],
      gatheringLink: json['gatheringLink'],
      gatheringDescription: json['gatheringDescription'],
      gatheringAmount: json['gatheringAmount'],
    );
  }
}