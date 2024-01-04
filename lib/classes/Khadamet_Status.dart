class KhadametStatus {
  final int statusId;
  final String? statusName;

  KhadametStatus({
    required this.statusId,
    this.statusName,
  });

  factory KhadametStatus.fromJson(Map<String, dynamic> json) {
    return KhadametStatus(
      statusId: json['Status_ID'],
      statusName: json['Status_Name'],
    );
  }
}
