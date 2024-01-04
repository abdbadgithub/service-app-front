class Sifa {
  final int sifaId;
  final String sName;

  Sifa({
    required this.sifaId,
    required this.sName,
  });

  factory Sifa.fromJson(Map<String, dynamic> json) {
    return Sifa(
      sifaId: json['Sifa_ID'],
      sName: json['S_Name'],
    );
  }
}
