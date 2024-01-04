class Ta2ifa {
  final int ta2ifaId;
  final String? tName;

  Ta2ifa({
    required this.ta2ifaId,
    this.tName,
  });

  factory Ta2ifa.fromJson(Map<String, dynamic> json) {
    return Ta2ifa(
      ta2ifaId: json['Ta2ifa_ID'],
      tName: json['T_Name'],
    );
  }
}
