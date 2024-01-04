class KhadametSubject {
  final int subjectId;
  final String? subjectName;

  KhadametSubject({
    required this.subjectId,
    this.subjectName,
  });

  factory KhadametSubject.fromJson(Map<String, dynamic> json) {
    return KhadametSubject(
      subjectId: json['Subject_ID'],
      subjectName: json['Subject_Name'],
    );
  }
}
