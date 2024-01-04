class Mouaref {
  final int mouarefId;
  final int mouarefMarje3;
  final String mouarefName;
  final String mourefPhone;
  final String mouarefClass;

  Mouaref({
    required this.mouarefId,
    required this.mouarefMarje3,
    required this.mouarefName,
    required this.mourefPhone,
    required this.mouarefClass,
  });

  factory Mouaref.fromJson(Map<String, dynamic> json) {
    return Mouaref(
      mouarefId: json['Mouaref_ID'],
      mouarefMarje3: json['Mouaref_Marje3'],
      mouarefName: json['Mouaref_Name'],
      mourefPhone: json['Mouref_Phone'],
      mouarefClass: json['Mouaref_Class'],
    );
  }
}
