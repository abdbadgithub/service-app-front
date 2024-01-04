class College {
  final int collegeId;
  final String? collegeName;
  final int? collegeType;

  College({
    required this.collegeId,
    this.collegeName,
    this.collegeType,
  });

  factory College.fromJson(Map<String, dynamic> json) {
    return College(
      collegeId: json['College_ID'],
      collegeName: json['College_Name'],
      collegeType: json['College_Type'],
    );
  }
}
