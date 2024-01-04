import 'DriverSifa.dart';

class Driver {
  final int idDriver;
  final int? idUser;
  final int? driverSifa;
  final DriverSifa? driverSifaDetails;

  Driver({
    required this.idDriver,
    this.idUser,
    this.driverSifa,
    this.driverSifaDetails,
  });

  factory Driver.fromJson(Map<String, dynamic> json) {

    return Driver(
      idDriver: json['IdDriver'],
      idUser: json['IdUser'],
      driverSifa: json['Driver_Sifa'],
      driverSifaDetails: json['DriverSifa'] != null ? DriverSifa.fromJson(json['DriverSifa']) : null,
    );
  }
}
