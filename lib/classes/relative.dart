class Relative {
  final int relativeId;
  final String? relativeName;

  Relative({
    required this.relativeId,
    this.relativeName,
  });

  factory Relative.fromJson(Map<String, dynamic> json) {
    return Relative(
      relativeId: json['Relative_ID'],
      relativeName: json['Relative_Name'],
    );
  }
}
