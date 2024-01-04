class SejelPlace {
  final int sejelPlaceId;
  final String spName;

  SejelPlace({
    required this.sejelPlaceId,
    required this.spName,
  });

  factory SejelPlace.fromJson(Map<String, dynamic> json) {
    return SejelPlace(
      sejelPlaceId: json['SejelPlace_ID'],
      spName: json['SP_Name'],
    );
  }
}
