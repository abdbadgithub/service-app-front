import 'package:service_app/classes/relative.dart';

class DataRelative {
  final int dataRelativeId;
  final int? relativeMainIdUser;
  final int? relativeClientIdUser;
  final int? idRelative;
  final Relative? relative;

  DataRelative({
    required this.dataRelativeId,
    this.relativeMainIdUser,
    this.relativeClientIdUser,
    this.idRelative,
    this.relative,
  });

  factory DataRelative.fromJson(Map<String, dynamic> json) {
    return DataRelative(
      dataRelativeId: json['DataRelative_ID'],
      relativeMainIdUser: json['RelativeMain_IdUser'],
      relativeClientIdUser: json['RelativeClient_IdUser'],
      idRelative: json['IDRelative'],
      relative: json['Relative'] != null ? Relative.fromJson(json['Relative']) : null,
    );
  }
}
