import 'Driver.dart';

class DriverSifa {
  final int idSifacar;
  final String? name;
  final Driver? driver;

  DriverSifa({
    required this.idSifacar,
    this.name,
    this.driver,
  });

  factory DriverSifa.fromJson(Map<String, dynamic> json) {
    return DriverSifa(
      idSifacar: json['id_sifacar'],
      name: json['name'],
      driver: json['Driver'] != null ? Driver.fromJson(json['Driver']) : null,
    );
  }
}
