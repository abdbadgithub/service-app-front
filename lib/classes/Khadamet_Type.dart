class KhadametType {
  final int statusCallingId;
  final String? khedmetStatusCalling;

  KhadametType({
    required this.statusCallingId,
    this.khedmetStatusCalling,
  });

  factory KhadametType.fromJson(Map<String, dynamic> json) {
    return KhadametType(
      statusCallingId: json['StatusCalling_ID'],
      khedmetStatusCalling: json['KhedmetStatusCalling'],
    );
  }
}
