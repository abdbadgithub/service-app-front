import 'package:service_app/classes/dataBasic.dart';

import 'Khadamet_Status.dart';
import 'Khadamet_Subject.dart';
import 'KhedmehResponsibleOffice.dart';

class KhadametBasic {
  final int idKhedmet;
  final int idUser;
  final DataBasic? data; // Assuming you have a Data class
  final KhadametStatus? khadametStatus; // Assuming you have a KhadametStatus class
  final KhadametSubject? khadametSubject; // Assuming you have a KhadametSubject class
  final KhedmehResponsibleOffice? khedmehResponsibleOffice; // Assuming you have a KhedmehResponsibleOffice class// Assuming you have a KhadametDetails class

  KhadametBasic({
    required this.idKhedmet,
    required this.idUser,
    this.data,
    this.khadametStatus,
    this.khadametSubject,
    this.khedmehResponsibleOffice,
  });

  factory KhadametBasic.fromJson(Map<String, dynamic> json) {
    var data;
    if (json.containsKey('Data') && json['Data'] != null) {
      data = DataBasic.fromJson(json['Data']);
    } else {
      // Handle the case where 'data' does not exist or is null
      // For example, initialize it with a default value or keep it null
      data = null; // or provide a default value
    }
    return KhadametBasic(
      idKhedmet: json['IdKhedmet'],
      idUser: json['IdUser'],
      data: data,
      khadametStatus: json['Khadamet_Status'] != null ? KhadametStatus.fromJson(json['Khadamet_Status']) : null,
      khadametSubject: json['Khadamet_Subject'] != null ? KhadametSubject.fromJson(json['Khadamet_Subject']) : null,
      khedmehResponsibleOffice: json['KhedmehResponsibleOffice'] != null ? KhedmehResponsibleOffice.fromJson(json['KhedmehResponsibleOffice']) : null,
    );
  }
}
