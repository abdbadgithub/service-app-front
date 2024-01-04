class KhadametCompany {
  final int companyId;
  final String? companyName;

  KhadametCompany({
    required this.companyId,
    this.companyName,
  });

  factory KhadametCompany.fromJson(Map<String, dynamic> json) {
    return KhadametCompany(
      companyId: json['Company_ID'],
      companyName: json['Company_Name'],
    );
  }
}
