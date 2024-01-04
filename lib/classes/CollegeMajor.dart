class CollegeMajor {
  final int collegeMajorId;
  final String? collegeMajorName;
  final int? collegeMajorType;

  CollegeMajor({
    required this.collegeMajorId,
    this.collegeMajorName,
    this.collegeMajorType,
  });

  factory CollegeMajor.fromJson(Map<String, dynamic> json) {
    return CollegeMajor(
      collegeMajorId: json['CollegeMajor_ID'],
      collegeMajorName: json['CollegeMajor_Name'],
      collegeMajorType: json['CollegeMajor_Type'],
    );
  }
}
