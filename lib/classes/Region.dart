class Region {
  final int regionId;
  final String? regionName;
  final int? regionMantika;

  Region({
    required this.regionId,
    this.regionName,
    this.regionMantika,
  });

  factory Region.fromJson(Map<String, dynamic> json) {
    return Region(
      regionId: json['Region_ID'],
      regionName: json['Region_Name'],
      regionMantika: json['Region_Mantika'],
    );
  }
}
