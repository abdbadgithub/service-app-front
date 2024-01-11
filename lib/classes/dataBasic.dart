class DataBasic {
  final String? lastName;
  final String? name;
  final String? midlename;

  DataBasic({
    this.lastName,
    this.name,
    this.midlename,
  });

  factory DataBasic.fromJson(Map<String, dynamic> json) {

    return DataBasic(
      lastName: json['LastName'],
      name: json['Name'],
      midlename: json['Midlename'],
    );
  }
}
