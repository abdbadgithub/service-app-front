class Gender {
  final int gId;
  final String gName;

  Gender({
    required this.gId,
    required this.gName,
  });

  factory Gender.fromJson(Map<String, dynamic> json) {
    return Gender(
      gId: json['G_ID'],
      gName: json['G_Name'],
    );
  }
}
