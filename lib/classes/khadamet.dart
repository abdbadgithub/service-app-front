import 'Khadamet_Company.dart';
import 'Khadamet_Status.dart';
import 'Khadamet_Subject.dart';
import 'Khadamet_Type.dart';
import 'KhedmehResponsibleOffice.dart';
import 'data.dart';

class KhadametDetailsReply {
  final int idKhadametDetailsReply;
  final int idKkhadamet;
  final DateTime? khadametDetailsImpotantDate;
  final String khadametDetailsNote;
  final String rowguid;

  KhadametDetailsReply({
    required this.idKhadametDetailsReply,
    required this.idKkhadamet,
    this.khadametDetailsImpotantDate,
    required this.khadametDetailsNote,
    required this.rowguid,
  });

  factory KhadametDetailsReply.fromJson(Map<String, dynamic> json) {
    return KhadametDetailsReply(
      idKhadametDetailsReply: json['ID_KhadametDetailsReply'],
      idKkhadamet: json['IdKkhadamet'],
      khadametDetailsImpotantDate: json['khadametdetails_impotantdate'] != null
          ? DateTime.parse(json['khadametdetails_impotantdate'])
          : null,
      khadametDetailsNote: json['khadametdetails_note'],
      rowguid: json['rowguid'],
    );
  }
}

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
  final Data? data;
  final KhadametCompany? khadametCompany;
  final KhadametStatus? khadametStatus;
  final KhadametSubject? khadametSubject;
  final KhadametType? khadametType;
  final KhedmehResponsibleOffice? khedmehResponsibleOffice;
  final List<KhadametDetailsReply>? khadametDetailsReply; // Include this field

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
    this.data,
    this.khadametCompany,
    this.khadametStatus,
    this.khadametSubject,
    this.khadametType,
    this.khedmehResponsibleOffice,
    this.khadametDetailsReply, // Initialize this field
  });

  factory Khadamet.fromJson(Map<String, dynamic> json) {
    // Parsing KhadametDetailsReply list
    List<dynamic> detailsReplyJson = json['KhadametDetailsReply'];
    List<KhadametDetailsReply> detailsReplyList = detailsReplyJson
        .map((replyJson) => KhadametDetailsReply.fromJson(replyJson))
        .toList();

    Data? data;
    if (json.containsKey('Data') && json['Data'] != null) {
      data = Data.fromJson(json['Data']);
    } else {
      data = null;
    }

    return Khadamet(
      idKhedmet: json['IdKhedmet'],
      idUser: json['IdUser'],
      khedmehSubject: json['KhedmehSubject'],
      khedmetSubjectDetails: json['KhedmetSubjectDetails'],
      startDate:
          json['StartDate'] != null ? DateTime.parse(json['StartDate']) : null,
      importantDate: json['ImportantDate'] != null
          ? DateTime.parse(json['ImportantDate'])
          : null,
      endDate: json['EndDate'] != null ? DateTime.parse(json['EndDate']) : null,
      sKhedmehResponsibleOffice: json['S_KhedmehResponsibleOffice'],
      khedmetStatus: json['KhedmetStatus'],
      khedmetType: json['KhedmetType'],
      khedmetCompany: json['KhedmetCompany'],
      khedmetCompanyDetails: json['KhedmetCompanyDetails'],
      data: data,
      khadametCompany: json['Khadamet_Company'] != null
          ? KhadametCompany.fromJson(json['Khadamet_Company'])
          : null,
      khadametStatus: json['Khadamet_Status'] != null
          ? KhadametStatus.fromJson(json['Khadamet_Status'])
          : null,
      khadametSubject: json['Khadamet_Subject'] != null
          ? KhadametSubject.fromJson(json['Khadamet_Subject'])
          : null,
      khadametType: json['Khadamet_Type'] != null
          ? KhadametType.fromJson(json['Khadamet_Type'])
          : null,
      khedmehResponsibleOffice: json['KhedmehResponsibleOffice'] != null
          ? KhedmehResponsibleOffice.fromJson(json['KhedmehResponsibleOffice'])
          : null,
      khadametDetailsReply: detailsReplyList,
    );
  }
}
