class KhedmehResponsibleOffice {
  final int respomsibleId;
  final String? khedmehResponsibleOffice;
  final int? khedmehResponsibleOfficeActive;

  KhedmehResponsibleOffice({
    required this.respomsibleId,
    this.khedmehResponsibleOffice,
    this.khedmehResponsibleOfficeActive,
  });

  factory KhedmehResponsibleOffice.fromJson(Map<String, dynamic> json) {
    return KhedmehResponsibleOffice(
      respomsibleId: json['Respomsible_ID'],
      khedmehResponsibleOffice: json['KhedmehResponsibleOffice'],
      khedmehResponsibleOfficeActive: json['KhedmehResponsibleOfficeActive'],
    );
  }
}
