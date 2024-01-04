import 'Khadamet_Company.dart';
import 'Khadamet_Status.dart';
import 'Khadamet_Subject.dart';
import 'Khadamet_Type.dart';
import 'KhedmehResponsibleOffice.dart';

class Khadamet {
  final int idKhedmet;
  final int idUser;
  final int? khedmehSubject;
  final String? khedmetSubjectDetails;
  final DateTime? startDate;
  final DateTime? importantDate;
  final DateTime? endDate;
  final int? sKhedmehResponsibleOffice;
  final int? khedmetStatus;
  final int? khedmetType;
  final int? khedmetCompany;
  final String? khedmetCompanyDetails;
  final KhadametCompany? khadametCompany; // Assuming you have a KhadametCompany class
  final KhadametStatus? khadametStatus; // Assuming you have a KhadametStatus class
  final KhadametSubject? khadametSubject; // Assuming you have a KhadametSubject class
  final KhadametType? khadametType; // Assuming you have a KhadametType class
  final KhedmehResponsibleOffice? khedmehResponsibleOffice; // Assuming you have a KhedmehResponsibleOffice class// Assuming you have a KhadametDetails class

  Khadamet({
    required this.idKhedmet,
    required this.idUser,
    this.khedmehSubject,
    this.khedmetSubjectDetails,
    this.startDate,
    this.importantDate,
    this.endDate,
    this.sKhedmehResponsibleOffice,
    this.khedmetStatus,
    this.khedmetType,
    this.khedmetCompany,
    this.khedmetCompanyDetails,
    this.khadametCompany,
    this.khadametStatus,
    this.khadametSubject,
    this.khadametType,
    this.khedmehResponsibleOffice,
  });

  factory Khadamet.fromJson(Map<String, dynamic> json) {

    return Khadamet(
      idKhedmet: json['IdKhedmet'],
      idUser: json['IdUser'],
      khedmehSubject: json['KhedmehSubject'],
      khedmetSubjectDetails: json['KhedmetSubjectDetails'],
      startDate: json['StartDate'] != null ? DateTime.parse(json['StartDate']) : null,
      importantDate: json['ImportantDate'] != null ? DateTime.parse(json['ImportantDate']) : null,
      endDate: json['EndDate'] != null ? DateTime.parse(json['EndDate']) : null,
      sKhedmehResponsibleOffice: json['S_KhedmehResponsibleOffice'],
      khedmetStatus: json['KhedmetStatus'],
      khedmetType: json['KhedmetType'],
      khedmetCompany: json['KhedmetCompany'],
      khedmetCompanyDetails: json['KhedmetCompanyDetails'],
      khadametCompany: json['Khadamet_Company'] != null ? KhadametCompany.fromJson(json['Khadamet_Company']) : null,
      khadametStatus: json['Khadamet_Status'] != null ? KhadametStatus.fromJson(json['Khadamet_Status']) : null,
      khadametSubject: json['Khadamet_Subject'] != null ? KhadametSubject.fromJson(json['Khadamet_Subject']) : null,
      khadametType: json['Khadamet_Type'] != null ? KhadametType.fromJson(json['Khadamet_Type']) : null,
      khedmehResponsibleOffice: json['KhedmehResponsibleOffice'] != null ? KhedmehResponsibleOffice.fromJson(json['KhedmehResponsibleOffice']) : null,
    );
  }
}
