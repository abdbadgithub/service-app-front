class BloodType {
  final int bloodTypeId;
  final String? bloodTypeName;

  BloodType({
    required this.bloodTypeId,
    this.bloodTypeName,
  });

  factory BloodType.fromJson(Map<String, dynamic> json) {
    return BloodType(
      bloodTypeId: json['BloodType_ID'],
      bloodTypeName: json['BloodTypeName'],
    );
  }
}
