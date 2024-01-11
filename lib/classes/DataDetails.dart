import 'package:service_app/classes/Education.dart';
import 'package:service_app/classes/Marital.dart';
import 'package:service_app/classes/Mouaref.dart';
import 'package:service_app/classes/Region.dart';

import 'BloodType.dart';
import 'College.dart';
import 'CollegeGrade.dart';
import 'CollegeMajor.dart';

class DataDetails {
  final int dataDetailsId;
  final int IdUser;
  final String HomePhone;
  final Region HomeLocation;
  final String HomeAddress;
  final String PersonalPhone;
  final String WorkPhone;
  final Region WorkLocation;
  final String WorkAddress;
  final String WorkType;
  final int EducationLevel;
  final Mouaref mouaref;
  final String? CV_Link_text;
  final String? Identity_Link_text;
  final int? CV_College;
  final int? CV_Grade;
  final int? CV_Major;
  final int? CV_Note;
  final Education? education;
  final Marital? marital;
  final BloodType? bloodType;
  final College? college;
  final CollegeGrade? collegeGrade;
  final CollegeMajor? collegeMajor;
// This assumes that a Data class exists

  DataDetails({
    required this.dataDetailsId,
    required this.IdUser,
    required this.HomePhone,
    required this.HomeLocation,
    required this.HomeAddress,
    required this.PersonalPhone,
    required this.WorkPhone,
    required this.WorkLocation,
    required this.WorkAddress,
    required this.WorkType,
    required this.EducationLevel,
    required this.mouaref,
    this.CV_Link_text,
    this.Identity_Link_text,
    this.CV_College,
    this.CV_Grade,
    this.CV_Major,
    this.CV_Note,
    this.education,
    this.marital,
    this.bloodType,
    this.college,
    this.collegeGrade,
    this.collegeMajor,
  });

  factory DataDetails.fromJson(Map<String, dynamic> json) {
    return DataDetails(
      dataDetailsId: json['DataDetails_ID'] as int,
      IdUser: json['IdUser'] as int,
      HomePhone: json['HomePhone'] as String,
      HomeLocation: Region.fromJson(json['Region_DataDetails_HomeLocationToRegion']),
      HomeAddress: json['HomeAddress'] as String,
      PersonalPhone: json['PersonalPhone'] as String,
      WorkPhone: json['WorkPhone'] as String,
      WorkLocation: Region.fromJson(json['Region_DataDetails_WorkLocationToRegion']),
      WorkAddress: json['WorkAddress'] as String,
      WorkType: json['WorkType'] as String,
      EducationLevel: json['EducationLevel'],
      mouaref: Mouaref.fromJson(json['Mouaref']),
      CV_Link_text: json['CV_Link_text'],
      Identity_Link_text:json['Identity_Link_text'],
      CV_College: json['CV_College'] as int?,
      CV_Grade: json['CV_Grade'] as int?,
      CV_Major: json['CV_Major'] as int?,
      CV_Note: json['CV_Note'] as int?,
      education:Education.fromJson(json['Education']),
      marital: json['Marital'] != null ? Marital.fromJson(json['Marital_DataDetails_MaritalToMarital']) : null,
      bloodType: json['BloodType'] != null ? BloodType.fromJson(json['BloodType_DataDetails_BloodTypeToBloodType']) : null,
      college: json['College'] != null ? College.fromJson(json['College']) : null,
      collegeGrade: json['CollegeGrade'] != null ? CollegeGrade.fromJson(json['CollegeGrade']) : null,
      collegeMajor: json['CollegeMajor'] != null ? CollegeMajor.fromJson(json['CollegeMajor']) : null,
    );
  }
}
