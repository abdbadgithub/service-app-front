class Marital {
  final int maritalId;
  final String? maritalName;

  Marital({
    required this.maritalId,
    this.maritalName,
  });

  factory Marital.fromJson(Map<String, dynamic> json) {
    return Marital(
      maritalId: json['Marital_ID'],
      maritalName: json['Marital_Name'],
    );
  }
}
