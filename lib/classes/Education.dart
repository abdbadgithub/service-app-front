class Education {
  final int educationId;
  final String eName;

  Education({
    required this.educationId,
    required this.eName,
  });

  factory Education.fromJson(Map<String, dynamic> json) {

    return Education(
      educationId: json['Education_ID'],
      eName: json['E_Name'],
    );
  }
}
