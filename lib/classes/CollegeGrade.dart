class CollegeGrade {
  final int gradeId;
  final String? gradeName;
  final int? gradeType;

  CollegeGrade({
    required this.gradeId,
    this.gradeName,
    this.gradeType,
  });

  factory CollegeGrade.fromJson(Map<String, dynamic> json) {
    return CollegeGrade(
      gradeId: json['Grade_ID'],
      gradeName: json['Grade_Name'],
      gradeType: json['Grade_Type'],
    );
  }
}
