class KhadametDetails {
  final int idKhadametdetails;
  final int idKkhadamet;
  final DateTime kdNoteDate;
  final String kdNote;// Assuming you have a Khadamet class

  KhadametDetails({
    required this.idKhadametdetails,
    required this.idKkhadamet,
    required this.kdNoteDate,
    required this.kdNote,
  });

  factory KhadametDetails.fromJson(Map<String, dynamic> json) {
    return KhadametDetails(
      idKhadametdetails: json['IdKhadametdetails'],
      idKkhadamet: json['IdKkhadamet'],
      kdNoteDate: DateTime.parse(json['KDNoteDate']),
      kdNote: json['KDNote'],
    );
  }
}

