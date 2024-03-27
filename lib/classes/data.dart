import 'DataDetails.dart';
import 'SejelPlace.dart';
import 'Ta2ifa.dart';
import 'gender.dart';
import 'khadamet.dart';

class Data {
  final int userId;
  final String? lastName;
  final String? name;
  final String? midlename;
  final String? motherName;
  final String? birthDate;
  final int? gender;
  final int? mantika;
  final int? sejelNumber;
  final int? mazhab;
  final int? ta2ifa;
  final int? yantakheb;
  final int? mandoub;
  final int? harakeh;
  final int? khedmeh;
  final int? money;
  final int? cvLink;
  final int? identityLink;
  // Assuming Gender, SejelPlace, Ta2ifa, and other related classes are defined
  final Gender? genderData;
  final SejelPlace? sejelPlace;
  final Ta2ifa? ta2ifaData;
  final List<DataDetails> dataDetails; // Assuming DataDetails class is defined
  final List<Khadamet> khadamet; // Assuming Khadamet class is defined

  Data({
    required this.userId,
    this.lastName,
    this.name,
    this.midlename,
    this.motherName,
    this.birthDate,
    this.gender,
    this.mantika,
    this.sejelNumber,
    this.mazhab,
    this.ta2ifa,
    this.yantakheb,
    this.mandoub,
    this.harakeh,
    this.khedmeh,
    this.money,
    this.cvLink,
    this.identityLink,
    this.genderData,
    this.sejelPlace,
    this.ta2ifaData,
    required this.dataDetails,
    required this.khadamet,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    // List<DataDetails> details;
    // if (json['DataDetails'] != null) {
    //   details = List.from(json['DataDetails']).map((i) => DataDetails.fromJson(i as Map<String, dynamic>)).toList();
    // } else {
    //   details = [];
    // }

    List<DataDetails> details;
    List<Khadamet> khadamet;
    if (json.containsKey('DataDetails') && json['DataDetails'] != null) {
      var dataDetailsList = json['DataDetails'] as List;
      details = dataDetailsList.map((i) => DataDetails.fromJson(i)).toList();
    } else {
      details = []; // or provide a default value
    }
    if (json.containsKey('Khadamet') && json['Khadamet'] != null) {
      var khadametList = json['Khadamet'] as List;
      khadamet = khadametList.map((i) => Khadamet.fromJson(i)).toList();
    } else {
      khadamet = []; // or provide a default value
    }
    // var dataDetailsList = json['DataDetails'] as List;
    //   List<DataDetails> details = dataDetailsList.map((i) => DataDetails.fromJson(i)).toList();
    // var khadametList = json['Khadamet'] as List;
    // List<Khadamet> khadamet = khadametList.map((i) => Khadamet.fromJson(i)).toList();

    return Data(
      userId: json['User_ID'],
      lastName: json['LastName'],
      name: json['Name'],
      midlename: json['Midlename'],
      motherName: json['MotherName'],
      birthDate: json['BirthDate'],
      gender: json['Gender'],
      mantika: json['Mantika'],
      sejelNumber: json['SejelNumber'],
      mazhab: json['Mazhab'],
      ta2ifa: json['ta2ifa'],
      yantakheb: json['Yantakheb'],
      mandoub: json['Mandoub'],
      harakeh: json['Harakeh'],
      khedmeh: json['Khedmeh'],
      money: json['Money'],
      cvLink: json['CV_Link'],
      identityLink: json['Identity_Link'],
      genderData: json['Gender_Data_GenderToGender'] != null
          ? Gender.fromJson(json['Gender_Data_GenderToGender'])
          : null,
      sejelPlace: json['SejelPlace'] != null
          ? SejelPlace.fromJson(json['SejelPlace'])
          : null,
      ta2ifaData:
          json['Ta2ifa'] != null ? Ta2ifa.fromJson(json['Ta2ifa']) : null,
      dataDetails: details,
      khadamet: khadamet,
    );
  }
}
